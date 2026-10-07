<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Http\Request;
use App\Notifications\OrderNotification;
use App\Services\FirebasePushService;

class AdminOrderController extends Controller
{
    public function index()
    {
        return response()->json(
            Order::with('items.product')->get()
        );
    }

    public function updateStatus(Request $request, $id)
    {
        $order = Order::findOrFail($id);

        $request->validate([
            'status' => 'required|in:pending,completed,cancelled'
        ]);

        $order->update([
            'status' => $request->status
        ]);

        $user = $order->user;

        if ($order->status === 'completed') {
            $message =
                'Your order has been completed successfully.';

            $user->notify(
                new OrderNotification(
                    $order,
                    $message
                )
            );

            if ($user->fcm_token) {
                app(FirebasePushService::class)->send(
                    $user->fcm_token,
                    'Order completed ☕',
                    "Your order #{$order->id} has been completed.",
                    [
                        'type' => 'order',
                        'order_id' => $order->id,
                        'status' => $order->status,
                    ]
                );
            }
        }

        if ($order->status === 'cancelled') {
            $message =
                'Your order has been cancelled.';

            $user->notify(
                new OrderNotification(
                    $order,
                    $message
                )
            );

            if ($user->fcm_token) {
                app(FirebasePushService::class)->send(
                    $user->fcm_token,
                    'Order cancelled',
                    "Your order #{$order->id} has been cancelled.",
                    [
                        'type' => 'order',
                        'order_id' => $order->id,
                        'status' => $order->status,
                    ]
                );
            }
        }

        return response()->json([
            'message' => 'Order status updated',
            'order' => $order->fresh(),
        ]);
    }
}