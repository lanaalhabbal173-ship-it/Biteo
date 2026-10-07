<?php

namespace App\Notifications;

use App\Models\Order;
use Illuminate\Bus\Queueable;
use Illuminate\Notifications\Notification;

class OrderNotification extends Notification
{
    use Queueable;

    public function __construct(
        public Order $order,
        public string $message
    ) {}

    public function via(object $notifiable): array
    {
        return ['database'];
    }

    public function toDatabase(object $notifiable): array
    {
        return [
            'title' => 'Order Update',
            'message' => $this->message,
            'order_id' => $this->order->id,
            'status' => $this->order->status,
        ];
    }

    public function toArray(object $notifiable): array
    {
        return [
            'title' => 'Order Update',
            'message' => $this->message,
            'order_id' => $this->order->id,
            'status' => $this->order->status,
        ];
    }
}