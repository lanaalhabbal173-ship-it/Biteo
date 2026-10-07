<?php

namespace App\Services;

use App\Models\Category;

class CategoryService
{
    public function create($data)
    {
        $category = Category::create($data);

        return $this->formatCategory($category);
    }

    public function getAll()
    {
        $categories = Category::all();

        $categories->transform(function ($category) {
            return $this->formatCategory($category);
        });

        return $categories;
    }

    private function formatCategory($category)
    {
        if ($category->image) {
            if (!str_starts_with($category->image, 'http')) {
                $category->image =
                    asset('storage/' . $category->image);
            }
        }

        return $category;
    }
}