import 'package:biteoapp/controllers/favorite_controller.dart';
import 'package:biteoapp/widget/favorites/favorite_product_card.dart';
import 'package:biteoapp/widget/favorites/favorites_empty_state.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller =
        Get.find<FavoriteController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // =========================
              // HEADER
              // =========================

              const Text(
                "Favorites",
                style: TextStyle(
                  color: Color(0xFF2B1D16),
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Your favorite coffee picks ☕",
                style: TextStyle(
                  color: Color(0xFF8B7A6F),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 24),

              // =========================
              // CONTENT
              // =========================

              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value &&
                      controller.favorites.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF8B5E3C),
                      ),
                    );
                  }

                  if (controller.favorites.isEmpty) {
                    return const FavoritesEmptyState();
                  }

                  return RefreshIndicator(
                    color: const Color(0xFF8B5E3C),
                    onRefresh: controller.fetchFavorites,

                    child: GridView.builder(
                      physics:
                          const AlwaysScrollableScrollPhysics(),

                      padding:
                          const EdgeInsets.only(
                        bottom: 30,
                      ),

                      itemCount:
                          controller.favorites.length,

                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.72,
                      ),

                      itemBuilder: (
                        context,
                        index,
                      ) {
                        final favorite =
                            controller.favorites[index];

                        return FavoriteProductCard(
                          product: favorite.product,
                          controller: controller,
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}