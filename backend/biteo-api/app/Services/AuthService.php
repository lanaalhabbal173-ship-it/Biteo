<?php

namespace App\Services;
use Illuminate\Support\Facades\Password;
use Illuminate\Support\Facades\Hash;
use App\Models\User;

class AuthService
{
    public function register($data)
    {
        $user = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'phone' => $data['phone'],
            'password' => Hash::make($data['password']),
        ]);

        $token = $user->createToken('biteo-token')->plainTextToken;

        return [
            'user' => $user,
            'token' => $token
        ];
    }
    public function login($data)
{
    $user = User::where('email', $data['email'])->first();

    if (!$user || !Hash::check($data['password'], $user->password)) {
        return null;
    }

    $token = $user->createToken('biteo-token')->plainTextToken;

    return [
        'user' => $user,
        'token' => $token
    ];
}
public function forgotPassword($data)
{

    $status = Password::sendResetLink([
        'email' => $data['email'],
    ]);


    return [

        'message' => __($status)

    ];

}
public function resetPassword($data)
{

    $status = Password::reset(

        $data,

        function ($user, $password) {


            $user->password = Hash::make($password);

            $user->save();

        }

    );


    return [

        'message' => __($status)

    ];

}
public function logout($user)
{
    $user->currentAccessToken()->delete();

    return [
        'message' => 'Logged out successfully'
    ];
}

}