import 'package:biteoapp/controllers/favorite_controller.dart';
import 'package:biteoapp/models/product_model.dart';

import 'package:flutter/material.dart';

class FavoriteProductCard extends StatelessWidget {
  final ProductModel product;
  final FavoriteController controller;

  const FavoriteProductCard({
    super.key,
    required this.product,
    required this.controller,
  });

  static const String baseImageUrl = "http://10.123.104.76:8080/storage/";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF7),

        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: const Color(0xFFEDE2D8)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          // =========================
          // IMAGE
          // =========================
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(22),
                  ),

                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,

                    child: product.image.isNotEmpty
                        ? Image.network(
                            _imageUrl(product.image),
                            fit: BoxFit.cover,

                            errorBuilder: (context, error, stackTrace) {
                              return _imagePlaceholder();
                            },
                          )
                        : _imagePlaceholder(),
                  ),
                ),

                // =========================
                // FAVORITE BUTTON
                // =========================
                Positioned(
                  top: 10,
                  right: 10,

                  child: GestureDetector(
                    onTap: () async {
                      await controller.toggleFavorite(product.id);
                    },

                    child: Container(
                      width: 38,
                      height: 38,

                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBF7).withOpacity(.94),

                        shape: BoxShape.circle,

                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.08),
                            blurRadius: 8,
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Color(0xFF8B5E3C),
                        size: 21,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // =========================
          // DETAILS
          // =========================
          Padding(
            padding: const EdgeInsets.fromLTRB(13, 12, 13, 14),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  product.name,

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    color: Color(0xFF2B1D16),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  "\$${product.price}",

                  style: const TextStyle(
                    color: Color(0xFF8B5E3C),
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _imageUrl(String image) {
    if (image.startsWith('http')) {
      return image;
    }

    return "$baseImageUrl$image";
  }

  Widget _imagePlaceholder() {
    return Container(
      color: const Color(0xFFF0E3D7),

      child: const Center(
        child: Icon(Icons.coffee_rounded, size: 50, color: Color(0xFF8B5E3C)),
      ),
    );
  }
}
