import 'package:biteoapp/controllers/favorite_controller.dart';
import 'package:biteoapp/models/product_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductImageHeader
    extends StatelessWidget {
  final ProductModel product;

  const ProductImageHeader({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    final FavoriteController
        favoriteController =
        Get.find<FavoriteController>();

    return Stack(
      children: [
        Container(
          height: 330,
          width: double.infinity,

          decoration:
              const BoxDecoration(
            color: Color(0xFFEDE1D6),

            borderRadius:
                BorderRadius.only(
              bottomLeft:
                  Radius.circular(35),
              bottomRight:
                  Radius.circular(35),
            ),
          ),

          child: ClipRRect(
            borderRadius:
                const BorderRadius.only(
              bottomLeft:
                  Radius.circular(35),
              bottomRight:
                  Radius.circular(35),
            ),

            child: product.image.isEmpty
                ? _fallbackImage()
                : Image.network(
                    product.image,
                    fit: BoxFit.cover,

                    errorBuilder: (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return _fallbackImage();
                    },
                  ),
          ),
        ),

        // BACK
        Positioned(
          top: 18,
          left: 18,

          child: _circleButton(
            icon: Icons
                .arrow_back_ios_new_rounded,
            onTap: Get.back,
          ),
        ),

        // FAVORITE
        Positioned(
          top: 18,
          right: 18,

          child: Obx(() {
            final isFavorite =
                favoriteController
                    .isFavorite(
              product.id,
            );

            return GestureDetector(
              onTap: () async {
                await favoriteController
                    .toggleFavorite(
                  product.id,
                );
              },

              child: Container(
                height: 44,
                width: 44,

                decoration:
                    BoxDecoration(
                  color: Colors.white
                      .withOpacity(.92),

                  shape:
                      BoxShape.circle,
                ),

                child: Icon(
                  isFavorite
                      ? Icons
                          .favorite_rounded
                      : Icons
                          .favorite_border_rounded,

                  color: isFavorite
                      ? const Color(
                          0xFF8B5E3C,
                        )
                      : const Color(
                          0xFF3B261C,
                        ),

                  size: 21,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
        height: 44,
        width: 44,

        decoration: BoxDecoration(
          color:
              Colors.white.withOpacity(.92),

          shape: BoxShape.circle,
        ),

        child: Icon(
          icon,
          color:
              const Color(0xFF3B261C),
          size: 20,
        ),
      ),
    );
  }

  Widget _fallbackImage() {
    return Container(
      color: const Color(0xFFEDE1D6),

      child: const Center(
        child: Icon(
          Icons.local_cafe_rounded,
          color: Color(0xFF8B5E3C),
          size: 70,
        ),
      ),
    );
  }
}