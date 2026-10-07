<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\OrderService;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function __construct(
        private OrderService $orderService
    ) {}

    public function checkout(Request $request)
    {
        return response()->json(
            $this->orderService->checkout(
                $request->user()
            )
        );
    }

    public function index(Request $request)
    {
        return response()->json(
            $this->orderService->myOrders(
                $request->user()
            )
        );
    }

    public function show(Request $request, $id)
    {
        return response()->json(
            $this->orderService->show(
                $request->user(),
                $id
            )
        );
    }
}