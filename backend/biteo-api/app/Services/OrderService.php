<?php

namespace App\Services;

use App\Models\Order;
use Illuminate\Support\Facades\DB;
use App\Notifications\OrderNotification;
use App\Services\FirebasePushService;

class OrderService
{
    public function checkout($user)
    {
        $cart = $user->cart()
            ->with('items.product')
            ->first();

        if (!$cart || $cart->items->count() === 0) {
            return [
                'message' => 'Cart is empty',
            ];
        }

        return DB::transaction(function () use ($cart, $user) {

            $total = 0;

            foreach ($cart->items as $item) {
                $total +=
                    (float) $item->price *
                    $item->quantity;
            }

            // Default delivery address
            $defaultAddress = $user->addresses()
                ->where('is_default', true)
                ->first();

            if (!$defaultAddress) {
                return [
                    'message' => 'No default delivery address',
                ];
            }

            // Create order
            $order = Order::create([
                'user_id' => $user->id,
                'total' => $total,
                'status' => 'pending',

                'address_label' => $defaultAddress->label,
                'delivery_address' => $defaultAddress->address,
                'city' => $defaultAddress->city,
                'phone' => $defaultAddress->phone,
            ]);

            // Copy cart items into order items
            foreach ($cart->items as $item) {

                $order->items()->create([
                    'product_id' => $item->product_id,
                    'quantity' => $item->quantity,
                    'price' => $item->price,

                    'size' => $item->size,
                    'temperature' => $item->temperature,
                    'extras' => $item->extras,
                ]);
            }

            // Notification
            $user->notify(
    new OrderNotification(
        $order,
        'Your order has been placed successfully.'
    )
);

if ($user->fcm_token) {
    app(FirebasePushService::class)->send(
        $user->fcm_token,
        'Order placed ☕',
        'Your order has been placed successfully.',
        [
            'type' => 'order',
            'order_id' => $order->id,
            'status' => $order->status,
        ]
    );
}

            // Clear cart
            $cart->items()->delete();

            return $order->load('items.product');
        });
    }

    public function myOrders($user)
    {
        return $user->orders()
            ->with('items.product')
            ->latest()
            ->get();
    }

    public function show($user, $id)
    {
        return $user->orders()
            ->with('items.product')
            ->findOrFail($id);
    }
}