import 'package:biteoapp/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategorySection extends GetView<HomeController> {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      child: Obx(() {
        final selectedIndex = controller.selectedCategory.value;

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.categories.length + 1,
          itemBuilder: (context, index) {
            // =========================
            // ALL CATEGORY
            // =========================

            if (index == 0) {
              final selected = selectedIndex == 0;

              return GestureDetector(
                onTap: () {
                  controller.changeCategory(0);
                },
                child: Container(
                  width: 82,
                  margin: const EdgeInsets.only(right: 14),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        height: 78,
                        width: 78,
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF8B5E3C)
                              : const Color(0xFFFFFBF7),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFF8B5E3C)
                                : const Color(0xFFEADFD6),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: selected
                                  ? const Color(0xFF8B5E3C).withOpacity(.22)
                                  : Colors.black.withOpacity(.04),
                              blurRadius: 14,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.local_cafe_rounded,
                          size: 34,
                          color: selected
                              ? Colors.white
                              : const Color(0xFF8B5E3C),
                        ),
                      ),
                      const SizedBox(height: 9),
                      Text(
                        "All",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: selected
                              ? const Color(0xFF6F472E)
                              : const Color(0xFF6E625A),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // =========================
            // API CATEGORIES
            // =========================

            final category = controller.categories[index - 1];
            final selected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                controller.changeCategory(index);
              },
              child: Container(
                width: 82,
                margin: const EdgeInsets.only(right: 14),
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 220),
                      curve: Curves.easeOut,
                      height: 78,
                      width: 78,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBF7),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: selected
                              ? const Color(0xFF8B5E3C)
                              : const Color(0xFFEADFD6),
                          width: selected ? 2.2 : 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: selected
                                ? const Color(0xFF8B5E3C).withOpacity(.18)
                                : Colors.black.withOpacity(.035),
                            blurRadius: 14,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: category.image.isEmpty
                            ? _fallbackIcon()
                            : Image.network(
                                category.image,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  print("CATEGORY IMAGE ERROR: $error");
                                  print(
                                    "CATEGORY IMAGE URL: ${category.image}",
                                  );

                                  return _fallbackIcon();
                                },
                              ),
                      ),
                    ),
                    const SizedBox(height: 9),
                    Text(
                      category.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: selected
                            ? const Color(0xFF6F472E)
                            : const Color(0xFF6E625A),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget _fallbackIcon() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFF3E7DC),
      child: const Center(
        child: Icon(Icons.coffee_rounded, color: Color(0xFF8B5E3C), size: 31),
      ),
    );
  }
}
