<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Services\ProductService;
use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function __construct(
        private ProductService $productService
    ) {}

    /*
    |--------------------------------------------------------------------------
    | Get Products
    |--------------------------------------------------------------------------
    */

    public function index(Request $request)
    {
        return response()->json(
            $this->productService->getAll($request)
        );
    }

    /*
    |--------------------------------------------------------------------------
    | Create Product
    |--------------------------------------------------------------------------
    */

    public function store(Request $request)
    {
        $data = $request->validate([
            'category_id' => 'required|exists:categories,id',

            'name' => 'required|string|max:255',

            'description' => 'nullable|string',

            'price' => 'required|numeric|min:0',

            'offer_price' => 'nullable|numeric|min:0',

            'has_offer' => 'nullable|boolean',

            'image' => 'nullable|string',

            'is_available' => 'nullable|boolean',
        ]);

        return response()->json(
            $this->productService->create($data),
            201
        );
    }

    /*
    |--------------------------------------------------------------------------
    | Update Product
    |--------------------------------------------------------------------------
    */

    public function update(Request $request, Product $product)
    {
        $data = $request->validate([
            'category_id' => 'required|exists:categories,id',

            'name' => 'required|string|max:255',

            'description' => 'nullable|string',

            'price' => 'required|numeric|min:0',

            'offer_price' => 'nullable|numeric|min:0',

            'has_offer' => 'nullable|boolean',

            'image' => 'nullable|string',

            'is_available' => 'nullable|boolean',
        ]);

        return response()->json(
            $this->productService->update($product, $data)
        );
    }

    /*
    |--------------------------------------------------------------------------
    | Delete Product
    |--------------------------------------------------------------------------
    */

    public function destroy(Product $product)
    {
        return response()->json(
            $this->productService->delete($product)
        );
    }
}