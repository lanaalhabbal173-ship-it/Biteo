<?php

use App\Http\Controllers\Api\AddressController;
use Illuminate\Support\Facades\Route;
use Illuminate\Http\Request;

use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\ProductController;
use App\Http\Controllers\Api\CartController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\AdminOrderController;
use App\Http\Controllers\Api\NotificationController;
use App\Http\Controllers\Api\BannerController;
use App\Http\Controllers\Api\DeviceTokenController;
use App\Http\Controllers\Api\FavoriteController;
use App\Http\Controllers\Api\PasswordResetOtpController;
use App\Http\Controllers\Api\ProfileController;


// =====================================
// BANNERS
// =====================================

Route::get(
    '/banners',
    [BannerController::class, 'index']
);

Route::post(
    '/banners',
    [BannerController::class, 'store']
);


// =====================================
// AUTH
// =====================================

// =====================================
// AUTH
// =====================================

Route::post(
    '/register',
    [AuthController::class, 'register']
);

Route::post(
    '/login',
    [AuthController::class, 'login']
);

// -------------------------------------
// PASSWORD RESET OTP
// -------------------------------------

Route::post(
    '/forgot-password-otp',
    [PasswordResetOtpController::class, 'sendOtp']
);

Route::post(
    '/verify-otp',
    [PasswordResetOtpController::class, 'verifyOtp']
);

Route::post(
    '/reset-password-otp',
    [PasswordResetOtpController::class, 'resetPassword']
);

// -------------------------------------
// LOGOUT
// -------------------------------------

Route::middleware('auth:sanctum')
    ->post(
        '/logout',
        [AuthController::class, 'logout']
    );
// =====================================
// CATEGORIES
// =====================================

Route::get(
    '/categories',
    [CategoryController::class, 'index']
);

Route::middleware([
    'auth:sanctum',
    'role:admin'
])->post(
    '/categories',
    [CategoryController::class, 'store']
);


// =====================================
// PRODUCTS
// =====================================

Route::get(
    '/products',
    [ProductController::class, 'index']
);

Route::middleware([
    'auth:sanctum',
    'role:admin'
])->group(function () {

    Route::post(
        '/products',
        [ProductController::class, 'store']
    );

    Route::put(
        '/products/{product}',
        [ProductController::class, 'update']
    );

    Route::delete(
        '/products/{product}',
        [ProductController::class, 'destroy']
    );
});


// =====================================
// AUTHENTICATED USER
// =====================================

Route::middleware('auth:sanctum')
    ->group(function () {

        // ---------------------------------
        // TEST AUTH
        // ---------------------------------

        Route::get(
            '/test-auth',
            function (Request $request) {
                return response()->json([
                    'user' =>
                        $request->user(),

                    'token' =>
                        $request->bearerToken(),
                ]);
            }
        );


        // ---------------------------------
        // PROFILE
        // ---------------------------------

        Route::get(
            '/profile',
            [ProfileController::class, 'show']
        );

        Route::put(
            '/profile',
            [ProfileController::class, 'update']
        );


        // ---------------------------------
        // DEVICE TOKEN
        // ---------------------------------

        Route::post(
            '/device-token',
            [DeviceTokenController::class, 'store']
        );


        // ---------------------------------
        // CART
        // ---------------------------------

        Route::post(
            '/cart/add',
            [CartController::class, 'add']
        );

        Route::get(
            '/cart',
            [CartController::class, 'index']
        );

        Route::put(
            '/cart/update/{id}',
            [CartController::class, 'update']
        );

        Route::delete(
            '/cart/remove/{id}',
            [CartController::class, 'remove']
        );


        // ---------------------------------
        // ORDERS
        // ---------------------------------

        Route::post(
            '/checkout',
            [OrderController::class, 'checkout']
        );

        Route::get(
            '/orders',
            [OrderController::class, 'index']
        );

        Route::get(
            '/orders/{id}',
            [OrderController::class, 'show']
        );


        // ---------------------------------
        // NOTIFICATIONS
        // ---------------------------------

        Route::get(
            '/notifications',
            [NotificationController::class, 'index']
        );

        Route::get(
            '/notifications/unread-count',
            [NotificationController::class, 'unreadCount']
        );

        Route::put(
            '/notifications/{id}/read',
            [NotificationController::class, 'read']
        );

        Route::delete(
            '/notifications/{id}',
            [NotificationController::class, 'destroy']
        );


        // ---------------------------------
        // ADDRESSES
        // ---------------------------------

        Route::get(
            '/addresses',
            [AddressController::class, 'index']
        );

        Route::post(
            '/addresses',
            [AddressController::class, 'store']
        );

        Route::put(
            '/addresses/{address}',
            [AddressController::class, 'update']
        );

        Route::put(
            '/addresses/{address}/default',
            [AddressController::class, 'setDefault']
        );

        Route::delete(
            '/addresses/{address}',
            [AddressController::class, 'destroy']
        );
        // ---------------------------------
// FAVORITES
// ---------------------------------

Route::get(
    '/favorites',
    [FavoriteController::class, 'index']
);

Route::post(
    '/favorites/{product}',
    [FavoriteController::class, 'store']
);

Route::delete(
    '/favorites/{product}',
    [FavoriteController::class, 'destroy']
);
    });


// =====================================
// ADMIN ORDERS
// =====================================

Route::middleware([
    'auth:sanctum',
    'role:admin'
])->group(function () {

    Route::get(
        '/admin/orders',
        [AdminOrderController::class, 'index']
    );

    Route::put(
        '/admin/orders/{order}/status',
        [AdminOrderController::class, 'updateStatus']
    );
});