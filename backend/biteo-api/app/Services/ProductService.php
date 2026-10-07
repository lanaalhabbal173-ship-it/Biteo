<?php

namespace App\Services;

use App\Models\Product;

class ProductService
{
    public function create($data)
    {
        $product = Product::create($data);

        return $this->formatProduct(
            $product->load('category')
        );
    }

    public function getAll($request)
    {
        $query = Product::with('category');

        // Search by product name
        if ($request->filled('search')) {
            $query->where(
                'name',
                'like',
                '%' . $request->search . '%'
            );
        }

        // Filter by category
        if ($request->filled('category_id')) {
            $query->where(
                'category_id',
                $request->category_id
            );
        }

        // Only available products
        if ($request->filled('is_available')) {
            $query->where(
                'is_available',
                $request->boolean('is_available')
            );
        }

        // Offers only
        if (
            $request->filled('offers') &&
            $request->boolean('offers')
        ) {
            $query->where('has_offer', true);
        }

        // Sort
        if ($request->sort === 'price_low') {
            $query->orderBy('price', 'asc');
        }

        if ($request->sort === 'price_high') {
            $query->orderBy('price', 'desc');
        }

        if ($request->sort === 'latest') {
            $query->latest();
        }

        $products = $query->paginate(10);

        $products->getCollection()->transform(
            function ($product) {
                return $this->formatProduct($product);
            }
        );

        return $products;
    }

    public function update($product, $data)
    {
        $product->update($data);

        return $this->formatProduct(
            $product->fresh()->load('category')
        );
    }

    public function delete($product)
    {
        $product->delete();

        return [
            'message' => 'Product deleted successfully'
        ];
    }

    private function formatProduct($product)
    {
        // Product image
        if ($product->image) {
            if (!str_starts_with($product->image, 'http')) {
                $product->image =
                    asset('storage/' . $product->image);
            }
        }

        // Category image inside product
        if (
            $product->category &&
            $product->category->image
        ) {
            if (
                !str_starts_with(
                    $product->category->image,
                    'http'
                )
            ) {
                $product->category->image =
                    asset(
                        'storage/' .
                        $product->category->image
                    );
            }
        }

        return $product;
    }
}