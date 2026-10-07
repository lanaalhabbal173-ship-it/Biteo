<?php

namespace App\Services;

use App\Models\Product;

class CartService
{
    public function addToCart($user, $data)
    {
        $cart = $user->cart()->firstOrCreate([
            'user_id' => $user->id,
        ]);

        $product = Product::findOrFail(
            $data['product_id']
        );

        /*
        |--------------------------------------------------------------------------
        | Options
        |--------------------------------------------------------------------------
        */

        $size = $data['size'];

        $temperature = $data['temperature'];

        $extras = $data['extras'] ?? [];

        // ترتيب الـ extras حتى لو انبعتوا بترتيب مختلف
        sort($extras);

        /*
        |--------------------------------------------------------------------------
        | Base Price
        |--------------------------------------------------------------------------
        */

        $price = $product->price;

        if (
            $product->has_offer &&
            $product->offer_price !== null
        ) {
            $price = $product->offer_price;
        }

        $price = (float) $price;

        /*
        |--------------------------------------------------------------------------
        | Size Price
        |--------------------------------------------------------------------------
        */

        if ($size === 'Small') {
            $price -= 0.50;
        }

        if ($size === 'Large') {
            $price += 1.00;
        }

        /*
        |--------------------------------------------------------------------------
        | Extras Price
        |--------------------------------------------------------------------------
        */

        foreach ($extras as $extra) {

            if ($extra === 'Extra Shot') {
                $price += 1.00;
            }

            if ($extra === 'Caramel Syrup') {
                $price += 0.50;
            }

            if ($extra === 'Vanilla Syrup') {
                $price += 0.50;
            }
        }

        /*
        |--------------------------------------------------------------------------
        | Find Same Cart Item
        |--------------------------------------------------------------------------
        */

        $items = $cart->items()
            ->where('product_id', $product->id)
            ->where('size', $size)
            ->where('temperature', $temperature)
            ->get();

        $item = $items->first(function ($item) use ($extras) {

            $itemExtras = $item->extras ?? [];

            sort($itemExtras);

            return $itemExtras === $extras;
        });

        /*
        |--------------------------------------------------------------------------
        | Update Or Create
        |--------------------------------------------------------------------------
        */

        if ($item) {

            $item->increment(
                'quantity',
                $data['quantity']
            );

        } else {

            $cart->items()->create([
                'product_id' => $product->id,

                'quantity' => $data['quantity'],

                'price' => $price,

                'size' => $size,

                'temperature' => $temperature,

                'extras' => $extras,
            ]);
        }

        return $cart
            ->fresh()
            ->load('items.product');
    }
}