<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Banner extends Model
{
    protected $fillable = [
        'title',
        'image',
        'discount',
        'is_active',
    ];

    protected $casts = [
        'discount' => 'integer',
        'is_active' => 'boolean',
    ];
}