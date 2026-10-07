import 'package:biteoapp/controllers/favorite_controller.dart';
import 'package:biteoapp/controllers/home_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProducts extends GetView<HomeController> {
  const PopularProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController favoriteController =
        Get.find<FavoriteController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: CircularProgressIndicator(color: Color(0xFF8B5E3C)),
          ),
        );
      }

      if (controller.products.isEmpty) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF7),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Column(
            children: [
              Icon(Icons.coffee_rounded, color: Color(0xFF8B5E3C), size: 45),
              SizedBox(height: 10),
              Text(
                "No drinks found",
                style: TextStyle(
                  color: Color(0xFF6E625A),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),

        itemCount: controller.products.length,

        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 16,
          childAspectRatio: .68,
        ),

        itemBuilder: (context, index) {
          final product = controller.products[index];

          return GestureDetector(
            onTap: () {
              Get.toNamed('/product-details', arguments: product);
            },

            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFECE1D7)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.045),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  // =========================
                  // PRODUCT IMAGE
                  // =========================
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                            bottomLeft: Radius.circular(18),
                            bottomRight: Radius.circular(18),
                          ),

                          child: product.image.isEmpty
                              ? _fallbackImage()
                              : Image.network(
                                  product.image,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,

                                  errorBuilder: (context, error, stackTrace) {
                                    return _fallbackImage();
                                  },
                                ),
                        ),

                        // =========================
                        // FAVORITE
                        // =========================
                        Positioned(
                          top: 10,
                          right: 10,

                          child: Obx(() {
                            final bool isFavorite = favoriteController
                                .isFavorite(product.id);

                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,

                              onTap: () async {
                                await favoriteController.toggleFavorite(
                                  product.id,
                                );
                              },

                              child: Container(
                                height: 34,
                                width: 34,

                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.92),
                                  shape: BoxShape.circle,
                                ),

                                child: Icon(
                                  isFavorite
                                      ? Icons.favorite_rounded
                                      : Icons.favorite_border_rounded,

                                  color: const Color(0xFF8B5E3C),

                                  size: 19,
                                ),
                              ),
                            );
                          }),
                        ),

                        // =========================
                        // OFFER BADGE
                        // =========================
                        if (product.hasOffer)
                          Positioned(
                            left: 10,
                            top: 10,

                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 9,
                                vertical: 5,
                              ),

                              decoration: BoxDecoration(
                                color: const Color(0xFFD9A26C),
                                borderRadius: BorderRadius.circular(20),
                              ),

                              child: const Text(
                                "OFFER",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: .4,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  // =========================
                  // PRODUCT INFO
                  // =========================
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 13),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Text(
                          product.name,

                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                            color: Color(0xFF2B1D16),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          product.description,

                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,

                          style: const TextStyle(
                            color: Color(0xFF9A8C82),
                            fontSize: 11.5,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: Color(0xFFD9A26C),
                              size: 17,
                            ),

                            SizedBox(width: 4),

                            Text(
                              "4.8",
                              style: TextStyle(
                                color: Color(0xFF76675D),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(width: 4),

                            Text(
                              "• Popular",
                              style: TextStyle(
                                color: Color(0xFFB3A69C),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          children: [
                            // =========================
                            // PRICE
                            // =========================
                            Expanded(
                              child:
                                  product.hasOffer && product.offerPrice != null
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "\$${product.price}",
                                          style: const TextStyle(
                                            color: Color(0xFFB5AAA2),
                                            fontSize: 11,
                                            decoration:
                                                TextDecoration.lineThrough,
                                          ),
                                        ),
                                        Text(
                                          "\$${product.offerPrice}",
                                          style: const TextStyle(
                                            color: Color(0xFF6F472E),
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(
                                      "\$${product.price}",
                                      style: const TextStyle(
                                        color: Color(0xFF6F472E),
                                        fontSize: 17,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                            ),

                            // =========================
                            // ADD BUTTON
                            // =========================
                            Container(
                              height: 37,
                              width: 37,

                              decoration: BoxDecoration(
                                color: const Color(0xFF8B5E3C),
                                borderRadius: BorderRadius.circular(13),

                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF8B5E3C,
                                    ).withOpacity(.22),
                                    blurRadius: 9,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),

                              child: const Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 23,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _fallbackImage() {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF0E4D8),

      child: const Center(
        child: Icon(
          Icons.local_cafe_rounded,
          color: Color(0xFF8B5E3C),
          size: 48,
        ),
      ),
    );
  }
}
