import 'package:biteoapp/widget/home/banner_slider.dart';
import 'package:biteoapp/widget/home/category_section.dart';
import 'package:biteoapp/widget/home/home_header.dart';
import 'package:biteoapp/widget/home/popular_proudcts.dart';
import 'package:biteoapp/widget/home/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =========================
              // HEADER + SEARCH
              // =========================

              Stack(
                clipBehavior: Clip.none,
                children: [
                  HomeHeader(),

                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: -32,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/search');
                      },
                      child: const SearchBarWidget(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 60),

              // =========================
              // BODY
              // =========================

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // =========================
                    // CATEGORIES
                    // =========================

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Categories",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2B1D16),
                          ),
                        ),

                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "See all",
                            style: TextStyle(
                              color: Color(0xFF8B5E3C),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const CategorySection(),

                    const SizedBox(height: 28),

                    // =========================
                    // BANNERS
                    // =========================

                    const BannerSlider(),

                    const SizedBox(height: 30),

                    // =========================
                    // POPULAR
                    // =========================

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Popular Coffee",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF2B1D16),
                          ),
                        ),

                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "See all",
                            style: TextStyle(
                              color: Color(0xFF8B5E3C),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const PopularProducts(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}