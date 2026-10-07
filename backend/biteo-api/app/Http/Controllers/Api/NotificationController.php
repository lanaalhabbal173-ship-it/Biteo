<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Http\Resources\NotificationResource;

class NotificationController extends Controller
{
  public function index(Request $request)
{
    return NotificationResource::collection(
        $request->user()
        ->notifications()
        ->latest()
        ->get()
    );
}
public function unreadCount(Request $request)
{
    return response()->json([
        'count' => $request->user()
            ->unreadNotifications()
            ->count()
    ]);
}

    public function read(Request $request, $id)
    {
        $notification = $request->user()
            ->notifications()
            ->findOrFail($id);

        $notification->markAsRead();

        return response()->json([
            'message' => 'Notification marked as read'
        ]);
    }
    public function destroy(Request $request, $id)
{
    $notification = $request->user()
        ->notifications()
        ->where('id', $id)
        ->firstOrFail();

    $notification->delete();

    return response()->json([
        'message' => 'Notification deleted successfully'
    ]);
}
}