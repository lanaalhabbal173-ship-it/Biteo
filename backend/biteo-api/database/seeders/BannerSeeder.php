<?php

namespace Database\Seeders;

use App\Models\Banner;
use Illuminate\Database\Seeder;

class BannerSeeder extends Seeder
{
    public function run(): void
    {
        Banner::create([
            'title' => 'Morning Coffee Deal',
            'image' => 'biteo/banners/banner_1.jpg',
            'discount' => 20,
            'is_active' => true,
        ]);

        Banner::create([
            'title' => 'Iced Coffee Offer',
            'image' => 'biteo/banners/banner_2.jpg',
            'discount' => 15,
            'is_active' => true,
        ]);
    }
}