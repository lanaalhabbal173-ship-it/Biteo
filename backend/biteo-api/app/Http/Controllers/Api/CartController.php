<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\CartService;
use Illuminate\Http\Request;

class CartController extends Controller
{
    public function __construct(
        private CartService $cartService
    ) {}

    public function index(Request $request)
    {
        return response()->json(
            $request->user()
                ->cart()
                ->with('items.product')
                ->first()
        );
    }

    public function add(Request $request)
    {
        $data = $request->validate([
            'product_id' => 'required|exists:products,id',

            'quantity' => 'required|integer|min:1',

            'size' => 'required|in:Small,Medium,Large',

            'temperature' => 'required|in:Hot,Iced',

            'extras' => 'nullable|array',

            'extras.*' => 'string|in:Extra Shot,Caramel Syrup,Vanilla Syrup',
        ]);

        return response()->json(
            $this->cartService->addToCart(
                $request->user(),
                $data
            )
        );
    }

    public function update(Request $request, $id)
    {
        $data = $request->validate([
            'quantity' => 'required|integer|min:1',
        ]);

        $cart = $request->user()
            ->cart()
            ->firstOrFail();

        $item = $cart
            ->items()
            ->findOrFail($id);

        $item->update([
            'quantity' => $data['quantity'],
        ]);

        return response()->json([
            'message' => 'Cart updated successfully',
            'item' => $item->load('product'),
        ]);
    }

    public function remove(Request $request, $id)
    {
        $cart = $request->user()
            ->cart()
            ->firstOrFail();

        $item = $cart
            ->items()
            ->findOrFail($id);

        $item->delete();

        return response()->json([
            'message' => 'Item removed successfully',
        ]);
    }
}