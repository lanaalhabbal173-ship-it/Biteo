import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/product_search_controller.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final ProductSearchController controller = Get.put(ProductSearchController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Search",
                style: TextStyle(
                  color: Color(0xFF2B1D16),
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                "Find your favorite coffee and treats",
                style: TextStyle(color: Color(0xFF96877C), fontSize: 14),
              ),

              const SizedBox(height: 22),

              // =========================
              // SEARCH BOX
              // =========================
              Container(
                height: 62,

                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF7),
                  borderRadius: BorderRadius.circular(21),

                  border: Border.all(color: const Color(0xFFE4D5C8)),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.045),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: TextField(
                  onSubmitted: (value) {
                    controller.addToHistory(value);
                  },

                  onChanged: (value) {
                    controller.search(value);
                  },

                  style: const TextStyle(
                    color: Color(0xFF2B1D16),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),

                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xFF8B5E3C),
                      size: 26,
                    ),

                    hintText: "Search Caramel Latte...",

                    hintStyle: const TextStyle(
                      color: Color(0xFFA99B90),
                      fontSize: 14,
                    ),

                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(7),

                      child: Container(
                        width: 45,

                        decoration: BoxDecoration(
                          color: const Color(0xFF8B5E3C),
                          borderRadius: BorderRadius.circular(14),
                        ),

                        child: const Icon(
                          Icons.tune_rounded,
                          color: Colors.white,
                          size: 21,
                        ),
                      ),
                    ),

                    border: InputBorder.none,

                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Expanded(
                child: Obx(() {
                  if (controller.results.isEmpty) {
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Popular searches",
                            style: TextStyle(
                              color: Color(0xFF2B1D16),
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 14),

                          Wrap(
                            spacing: 10,
                            runSpacing: 10,

                            children: [
                              _chip("Latte", Icons.local_cafe_rounded),

                              _chip("Cappuccino", Icons.coffee_rounded),

                              _chip("Iced Coffee", Icons.ac_unit_rounded),

                              _chip("Matcha", Icons.eco_rounded),

                              _chip("Desserts", Icons.cake_outlined),
                            ],
                          ),

                          const SizedBox(height: 34),

                          Obx(() {
                            if (controller.searchHistory.isEmpty) {
                              return const SizedBox();
                            }

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,

                                  children: [
                                    const Text(
                                      "Recent searches",
                                      style: TextStyle(
                                        color: Color(0xFF2B1D16),
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),

                                    TextButton(
                                      onPressed: () {
                                        controller.searchHistory.clear();
                                      },

                                      child: const Text(
                                        "Clear all",
                                        style: TextStyle(
                                          color: Color(0xFF9A8B80),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,

                                  children: controller.searchHistory
                                      .map(
                                        (item) => GestureDetector(
                                          onTap: () {
                                            controller.search(item);
                                          },

                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 10,
                                            ),

                                            decoration: BoxDecoration(
                                              color: const Color(0xFFFFFBF7),

                                              borderRadius:
                                                  BorderRadius.circular(18),

                                              border: Border.all(
                                                color: const Color(0xFFE9DDD2),
                                              ),
                                            ),

                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,

                                              children: [
                                                const Icon(
                                                  Icons.history_rounded,
                                                  size: 17,
                                                  color: Color(0xFF9B8A7E),
                                                ),

                                                const SizedBox(width: 7),

                                                Text(
                                                  item,

                                                  style: const TextStyle(
                                                    color: Color(0xFF5F4A3E),
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    );
                  }

                  // =========================
                  // RESULTS
                  // =========================

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),

                    itemCount: controller.results.length,

                    separatorBuilder: (_, __) => const SizedBox(height: 13),

                    itemBuilder: (context, index) {
                      final product = controller.results[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed('/product-details', arguments: product);
                        },

                        child: Container(
                          padding: const EdgeInsets.all(10),

                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFBF7),

                            borderRadius: BorderRadius.circular(22),

                            border: Border.all(color: const Color(0xFFECE1D7)),

                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.035),
                                blurRadius: 14,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),

                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(17),

                                child: product.image.isEmpty
                                    ? _fallbackImage()
                                    : Image.network(
                                        product.image,
                                        width: 82,
                                        height: 82,
                                        fit: BoxFit.cover,

                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return _fallbackImage();
                                            },
                                      ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
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
                                        fontSize: 12,
                                      ),
                                    ),

                                    const SizedBox(height: 9),

                                    product.hasOffer &&
                                            product.offerPrice != null
                                        ? Row(
                                            children: [
                                              Text(
                                                "\$${product.offerPrice}",
                                                style: const TextStyle(
                                                  color: Color(0xFF6F472E),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800,
                                                ),
                                              ),

                                              const SizedBox(width: 7),

                                              Text(
                                                "\$${product.price}",
                                                style: const TextStyle(
                                                  color: Color(0xFFB5AAA2),
                                                  fontSize: 12,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                ),
                                              ),
                                            ],
                                          )
                                        : Text(
                                            "\$${product.price}",
                                            style: const TextStyle(
                                              color: Color(0xFF6F472E),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                  ],
                                ),
                              ),

                              Container(
                                height: 38,
                                width: 38,

                                decoration: BoxDecoration(
                                  color: const Color(0xFF8B5E3C),
                                  borderRadius: BorderRadius.circular(13),
                                ),

                                child: const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                  size: 21,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chip(String text, IconData icon) {
    return GestureDetector(
      onTap: () {
        controller.search(text);
        controller.addToHistory(text);
      },

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

        decoration: BoxDecoration(
          color: const Color(0xFFF0E3D7),
          borderRadius: BorderRadius.circular(18),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            Icon(icon, size: 18, color: const Color(0xFF8B5E3C)),

            const SizedBox(width: 7),

            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF6F472E),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fallbackImage() {
    return Container(
      width: 82,
      height: 82,
      color: const Color(0xFFF0E4D8),

      child: const Icon(
        Icons.local_cafe_rounded,
        size: 35,
        color: Color(0xFF8B5E3C),
      ),
    );
  }
}
