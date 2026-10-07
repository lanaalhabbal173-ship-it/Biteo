<?php

namespace Database\Seeders;

use App\Models\Product;
use Illuminate\Database\Seeder;

class ProductSeeder extends Seeder
{
    public function run(): void
    {
        Product::create([
            'category_id' => 1,
            'name' => 'Caramel Latte',
            'description' => 'Espresso with steamed milk and caramel flavor.',
            'price' => 4.50,
            'offer_price' => 3.90,
            'has_offer' => true,
            'image' => 'biteo/products/caramel_latte.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 1,
            'name' => 'Cappuccino',
            'description' => 'Classic espresso with steamed milk and foam.',
            'price' => 4.00,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/cappuccino.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 1,
            'name' => 'Espresso',
            'description' => 'Strong and rich espresso shot.',
            'price' => 2.50,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/espresso.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 1,
            'name' => 'Americano',
            'description' => 'Espresso with hot water for a smooth bold taste.',
            'price' => 3.00,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/americano.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 1,
            'name' => 'Latte',
            'description' => 'Smooth espresso with steamed milk.',
            'price' => 4.00,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/latte.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 1,
            'name' => 'Mocha',
            'description' => 'Espresso with chocolate and steamed milk.',
            'price' => 4.75,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/mocha.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 1,
            'name' => 'Vanilla Latte',
            'description' => 'Espresso with milk and vanilla flavor.',
            'price' => 4.50,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/vanilla_latte.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 2,
            'name' => 'Iced Coffee',
            'description' => 'Refreshing cold coffee served over ice.',
            'price' => 3.75,
            'offer_price' => 3.25,
            'has_offer' => true,
            'image' => 'biteo/products/iced_coffee.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 2,
            'name' => 'Iced Latte',
            'description' => 'Cold espresso with milk and ice.',
            'price' => 4.50,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/iced_latte.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 2,
            'name' => 'Matcha Latte',
            'description' => 'Creamy matcha with milk.',
            'price' => 4.25,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/matcha_latte.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 2,
            'name' => 'Strawberry Matcha',
            'description' => 'Matcha with strawberry and milk.',
            'price' => 5.00,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/strawberry_matcha.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 2,
            'name' => 'Chocolate Drink',
            'description' => 'Rich chocolate drink.',
            'price' => 4.00,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/chocolate.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 2,
            'name' => 'Hot Chocolate',
            'description' => 'Warm chocolate drink with rich cocoa flavor.',
            'price' => 4.25,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/hot_chocolate.png',
            'is_available' => true,
        ]);

        Product::create([
            'category_id' => 5,
            'name' => 'Tea',
            'description' => 'Freshly brewed hot tea.',
            'price' => 2.50,
            'offer_price' => null,
            'has_offer' => false,
            'image' => 'biteo/products/tea.png',
            'is_available' => true,
        ]);
    }
}