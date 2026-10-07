<?php

namespace Database\Seeders;

use App\Models\Category;
use Illuminate\Database\Seeder;

class CategorySeeder extends Seeder
{
    public function run(): void
    {
        Category::create([
            'name' => 'Coffee',
            'image' => 'biteo/categories/coffee.png',
        ]);

        Category::create([
            'name' => 'Cold Drinks',
            'image' => 'biteo/categories/cold_drinks.png',
        ]);

        Category::create([
            'name' => 'Desserts',
            'image' => 'biteo/categories/desserts.png',
        ]);

        Category::create([
            'name' => 'Bakery',
            'image' => 'biteo/categories/bakery.png',
        ]);

        Category::create([
            'name' => 'Tea',
            'image' => 'biteo/categories/tea.png',
        ]);
    }
}