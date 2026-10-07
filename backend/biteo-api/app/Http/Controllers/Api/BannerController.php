<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Banner;
use Illuminate\Http\Request;

class BannerController extends Controller
{
    public function index()
    {
        $banners = Banner::where('is_active', true)->get();

        $banners->transform(function ($banner) {

            if ($banner->image && !str_starts_with($banner->image, 'http')) {
                $banner->image = asset('storage/' . $banner->image);
            }

            return $banner;
        });

        return response()->json($banners);
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'title' => 'required|string|max:255',
            'image' => 'required|string',
            'discount' => 'nullable|integer|min:0|max:100',
            'is_active' => 'nullable|boolean',
        ]);

        $banner = Banner::create([
            'title' => $data['title'],
            'image' => $data['image'],
            'discount' => $data['discount'] ?? null,
            'is_active' => $data['is_active'] ?? true,
        ]);

        if ($banner->image && !str_starts_with($banner->image, 'http')) {
            $banner->image = asset('biteo/' . $banner->image);
        }

        return response()->json($banner, 201);
    }
}