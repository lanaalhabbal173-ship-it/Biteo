<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Address;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AddressController extends Controller
{
    public function index(Request $request)
    {
        return response()->json(
            $request->user()
                ->addresses()
                ->latest()
                ->get()
        );
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'label' => 'required|string|max:50',
            'address' => 'required|string|max:500',
            'city' => 'nullable|string|max:100',
            'phone' => 'nullable|string|max:30',
            'is_default' => 'nullable|boolean',
        ]);

        $user = $request->user();

        return DB::transaction(function () use (
            $user,
            $validated
        ) {
            if (
                ($validated['is_default'] ?? false) ||
                !$user->addresses()->exists()
            ) {
                $user->addresses()
                    ->update([
                        'is_default' => false
                    ]);

                $validated['is_default'] = true;
            }

            $address = $user->addresses()
                ->create($validated);

            return response()->json(
                $address,
                201
            );
        });
    }

    public function update(
        Request $request,
        Address $address
    ) {
        if (
            $address->user_id !==
            $request->user()->id
        ) {
            abort(403);
        }

        $validated = $request->validate([
            'label' => 'required|string|max:50',
            'address' => 'required|string|max:500',
            'city' => 'nullable|string|max:100',
            'phone' => 'nullable|string|max:30',
            'is_default' => 'nullable|boolean',
        ]);

        return DB::transaction(function () use (
            $request,
            $address,
            $validated
        ) {
            if (
                $validated['is_default']
                ?? false
            ) {
                $request->user()
                    ->addresses()
                    ->where(
                        'id',
                        '!=',
                        $address->id
                    )
                    ->update([
                        'is_default' => false
                    ]);
            }

            $address->update($validated);

            return response()->json(
                $address->fresh()
            );
        });
    }

    public function setDefault(
        Request $request,
        Address $address
    ) {
        if (
            $address->user_id !==
            $request->user()->id
        ) {
            abort(403);
        }

        DB::transaction(function () use (
            $request,
            $address
        ) {
            $request->user()
                ->addresses()
                ->update([
                    'is_default' => false
                ]);

            $address->update([
                'is_default' => true
            ]);
        });

        return response()->json(
            $address->fresh()
        );
    }

    public function destroy(
        Request $request,
        Address $address
    ) {
        if (
            $address->user_id !==
            $request->user()->id
        ) {
            abort(403);
        }

        $wasDefault =
            $address->is_default;

        $address->delete();

        if ($wasDefault) {
            $nextAddress =
                $request->user()
                    ->addresses()
                    ->latest()
                    ->first();

            if ($nextAddress) {
                $nextAddress->update([
                    'is_default' => true
                ]);
            }
        }

        return response()->json([
            'message' =>
                'Address deleted successfully'
        ]);
    }
}