<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Favorite;
use App\Models\Product;
use Illuminate\Http\Request;

class FavoriteController extends Controller
{
    // =========================
    // LIST FAVORITES
    // =========================

    public function index(Request $request)
    {
        $favorites = Favorite::with('product')
            ->where('user_id', $request->user()->id)
            ->latest()
            ->get();

        return response()->json(
            $favorites
        );
    }

    // =========================
    // ADD FAVORITE
    // =========================

    public function store(
        Request $request,
        Product $product
    ) {
        $favorite = Favorite::firstOrCreate([
            'user_id' => $request->user()->id,
            'product_id' => $product->id,
        ]);

        $favorite->load('product');

        return response()->json([
            'message' =>
                'Product added to favorites',
            'favorite' =>
                $favorite,
        ], 201);
    }

    // =========================
    // REMOVE FAVORITE
    // =========================

    public function destroy(
        Request $request,
        Product $product
    ) {
        Favorite::where(
            'user_id',
            $request->user()->id
        )
            ->where(
                'product_id',
                $product->id
            )
            ->delete();

        return response()->json([
            'message' =>
                'Product removed from favorites',
        ]);
    }
}