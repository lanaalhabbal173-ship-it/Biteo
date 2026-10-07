<?php

namespace App\Services;

use Kreait\Firebase\Factory;
use Kreait\Firebase\Messaging\CloudMessage;
use Kreait\Firebase\Messaging\Notification;

class FirebasePushService
{
    protected $messaging;

    public function __construct()
    {
        $credentialsPath = base_path(
            env(
                'FIREBASE_CREDENTIALS',
                'storage/app/firebase/firebase-service-account.json'
            )
        );

        $this->messaging = (new Factory)
            ->withServiceAccount($credentialsPath)
            ->createMessaging();
    }

    public function send(
        string $token,
        string $title,
        string $body,
        array $data = []
    ): void {
        $data = collect($data)
            ->mapWithKeys(
                fn ($value, $key) => [
                    $key => (string) $value
                ]
            )
            ->toArray();

        $message = CloudMessage::withTarget(
            'token',
            $token
        )
            ->withNotification(
                Notification::create(
                    $title,
                    $body
                )
            )
            ->withData($data);

        $this->messaging->send($message);
    }
}