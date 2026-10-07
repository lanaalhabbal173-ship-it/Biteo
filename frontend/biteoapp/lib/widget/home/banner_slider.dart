import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      if (controller.banners.isEmpty) {
        return const SizedBox();
      }

      return CarouselSlider.builder(
        itemCount: controller.banners.length,

        itemBuilder: (context, index, realIndex) {
          final banner = controller.banners[index];

          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.08),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(26),

              child: Stack(
                fit: StackFit.expand,

                children: [
                  // IMAGE
                  Image.network(
                    banner.image,
                    fit: BoxFit.cover,

                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: const Color(0xFFEADFD6),

                        child: const Center(
                          child: Icon(
                            Icons.local_cafe_rounded,
                            size: 48,
                            color: Color(0xFF8B5E3C),
                          ),
                        ),
                      );
                    },
                  ),

                  // GRADIENT
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,

                        colors: [
                          Colors.black.withOpacity(.58),
                          Colors.black.withOpacity(.25),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),

                  // CONTENT
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 14,
                    ),

                    child: Align(
                      alignment: Alignment.centerLeft,

                      child: SizedBox(
                        width: 190,

                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            if (banner.discount != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 9,
                                  vertical: 4,
                                ),

                                decoration: BoxDecoration(
                                  color: const Color(0xFFD9A26C),
                                  borderRadius: BorderRadius.circular(20),
                                ),

                                child: Text(
                                  "${banner.discount}% OFF",

                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),

                            const SizedBox(height: 7),

                            Text(
                              banner.title,

                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,

                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                height: 1.1,
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 6),

                            const Text(
                              "Order your favorite coffee now",

                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,

                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 13,
                                vertical: 7,
                              ),

                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFBF7),
                                borderRadius: BorderRadius.circular(13),
                              ),

                              child: const Text(
                                "Order Now",

                                style: TextStyle(
                                  color: Color(0xFF6F472E),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },

        options: CarouselOptions(
          height: 205,

          autoPlay: controller.banners.length > 1,

          autoPlayInterval: const Duration(seconds: 4),

          autoPlayAnimationDuration: const Duration(milliseconds: 700),

          enlargeCenterPage: true,

          viewportFraction: .95,

          enableInfiniteScroll: controller.banners.length > 1,
        ),
      );
    });
  }
}
