<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Mail\PasswordResetOtpMail;
use App\Models\PasswordResetOtp;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class PasswordResetOtpController extends Controller
{
    // =========================
    // SEND OTP
    // =========================

    public function sendOtp(Request $request)
    {
        $validator = Validator::make(
            $request->all(),
            [
                'email' => 'required|email|exists:users,email',
            ]
        );

        if ($validator->fails()) {
            return response()->json([
                'message' => 'Please check your email address.',
                'errors' => $validator->errors(),
            ], 422);
        }

        $email = $request->email;

        // Delete previous OTP
        PasswordResetOtp::where(
            'email',
            $email
        )->delete();

        // Generate 4 digit OTP
        $otp = (string) random_int(
            1000,
            9999
        );

        PasswordResetOtp::create([
            'email' => $email,

            'otp' => Hash::make(
                $otp
            ),

            'expires_at' =>
                now()->addMinutes(10),

            'verified' => false,

            'verification_token' =>
                null,
        ]);

        try {
            Mail::to($email)->send(
                new PasswordResetOtpMail(
                    $otp
                )
            );
        } catch (\Throwable $e) {
            return response()->json([
                'message' =>
                    'Could not send verification email.',

                'error' =>
                    $e->getMessage(),
            ], 500);
        }

        return response()->json([
            'message' =>
                'Verification code sent successfully.',
        ], 200);
    }

    // =========================
    // VERIFY OTP
    // =========================

    public function verifyOtp(
        Request $request
    ) {
        $validator = Validator::make(
            $request->all(),
            [
                'email' =>
                    'required|email',

                'otp' =>
                    'required|string|size:4',
            ]
        );

        if ($validator->fails()) {
            return response()->json([
                'message' =>
                    'Invalid verification data.',

                'errors' =>
                    $validator->errors(),
            ], 422);
        }

        $record =
            PasswordResetOtp::where(
                'email',
                $request->email
            )
                ->latest()
                ->first();

        if (!$record) {
            return response()->json([
                'message' =>
                    'Verification code not found.',
            ], 404);
        }

        if (
            $record
                ->expires_at
                ->isPast()
        ) {
            return response()->json([
                'message' =>
                    'Verification code has expired.',
            ], 422);
        }

        if (
            !Hash::check(
                $request->otp,
                $record->otp
            )
        ) {
            return response()->json([
                'message' =>
                    'Invalid verification code.',
            ], 422);
        }

        $verificationToken =
            Str::random(64);

        $record->update([
            'verified' => true,

            'verification_token' =>
                Hash::make(
                    $verificationToken
                ),
        ]);

        return response()->json([
            'message' =>
                'OTP verified successfully.',

            'verification_token' =>
                $verificationToken,
        ], 200);
    }

    // =========================
    // RESET PASSWORD
    // =========================

    public function resetPassword(
        Request $request
    ) {
        $validator = Validator::make(
            $request->all(),
            [
                'email' =>
                    'required|email|exists:users,email',

                'verification_token' =>
                    'required|string',

                'password' =>
                    'required|string|min:6|confirmed',
            ]
        );

        if ($validator->fails()) {
            return response()->json([
                'message' =>
                    'Invalid reset password data.',

                'errors' =>
                    $validator->errors(),
            ], 422);
        }

        $record =
            PasswordResetOtp::where(
                'email',
                $request->email
            )
                ->where(
                    'verified',
                    true
                )
                ->latest()
                ->first();

        if (!$record) {
            return response()->json([
                'message' =>
                    'OTP verification required.',
            ], 403);
        }

        if (
            !$record
                ->verification_token
        ) {
            return response()->json([
                'message' =>
                    'Verification token missing.',
            ], 403);
        }

        if (
            !Hash::check(
                $request
                    ->verification_token,

                $record
                    ->verification_token
            )
        ) {
            return response()->json([
                'message' =>
                    'Invalid verification token.',
            ], 403);
        }

        $user =
            User::where(
                'email',
                $request->email
            )->firstOrFail();

        $user->update([
            'password' =>
                Hash::make(
                    $request->password
                ),
        ]);

        PasswordResetOtp::where(
            'email',
            $request->email
        )->delete();

        return response()->json([
            'message' =>
                'Password reset successfully.',
        ], 200);
    }
}