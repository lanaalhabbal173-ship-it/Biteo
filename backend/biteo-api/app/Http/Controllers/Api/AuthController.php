<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\AuthService;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function __construct(
        private AuthService $authService
    ) {}


    public function register(Request $request)
    {
        $data = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'phone' => 'required',
            'password' => 'required|min:6',
        ]);

        $result = $this->authService->register($data);

        return response()->json($result);
    }
    public function login(Request $request)
{
    $data = $request->validate([
        'email' => 'required|email',
        'password' => 'required',
    ]);

    $result = $this->authService->login($data);

    if (!$result) {
        return response()->json([
            'message' => 'Invalid credentials'
        ], 401);
    }

    return response()->json($result);
}
public function logout(Request $request)
{
    return response()->json(
        $this->authService->logout($request->user())
    );
}
public function forgotPassword(Request $request)
{
    $data = $request->validate([
        'email' => 'required|email',
    ]);

    return response()->json(
        $this->authService->forgotPassword($data)
    );
}


public function resetPassword(Request $request)
{
    $data = $request->validate([
        'token' => 'required',
        'email' => 'required|email',
        'password' => 'required|min:6',
    ]);

    return response()->json(
        $this->authService->resetPassword($data)
    );
}
};