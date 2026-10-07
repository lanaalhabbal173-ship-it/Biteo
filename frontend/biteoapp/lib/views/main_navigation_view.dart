import 'package:biteoapp/controllers/cart_controller.dart';
import 'package:biteoapp/controllers/favorite_controller.dart';
import 'package:biteoapp/controllers/orders_controller.dart';
import 'package:biteoapp/controllers/notification_controller.dart';

import 'package:biteoapp/views/profile_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view.dart';
import 'favorites_view.dart';
import 'cart_view.dart';
import 'orders_view.dart';

class MainNavigationView extends StatefulWidget {
  const MainNavigationView({super.key});

  @override
  State<MainNavigationView> createState() => _MainNavigationViewState();
}

class _MainNavigationViewState extends State<MainNavigationView> {
  int currentIndex = 0;

  // =====================================
  // NOTIFICATIONS CONTROLLER
  // =====================================

  final NotificationController notificationController =
      Get.isRegistered<NotificationController>()
      ? Get.find<NotificationController>()
      : Get.put(NotificationController(), permanent: true);

  // =====================================
  // FAVORITES CONTROLLER
  // =====================================

  final FavoriteController favoriteController =
      Get.isRegistered<FavoriteController>()
      ? Get.find<FavoriteController>()
      : Get.put(FavoriteController(), permanent: true);

  // =====================================
  // PAGES
  // =====================================

  final List<Widget> pages = [
    const HomeView(),
    const FavoritesView(),
    CartView(),
    OrdersView(),
    ProfileView(),
  ];

  // =====================================
  // CHANGE PAGE
  // =====================================

  Future<void> _changePage(int index) async {
    setState(() {
      currentIndex = index;
    });

    // Refresh Home notifications
    if (index == 0) {
      await notificationController.fetchUnreadCount();
    }

    // Refresh Favorites
    if (index == 1) {
      await favoriteController.fetchFavorites();
    }

    // Refresh Cart
    if (index == 2) {
      if (Get.isRegistered<CartController>()) {
        await Get.find<CartController>().fetchCart();
      }
    }

    // Refresh Orders
    if (index == 3) {
      if (Get.isRegistered<OrdersController>()) {
        await Get.find<OrdersController>().fetchOrders();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      body: IndexedStack(index: currentIndex, children: pages),

      bottomNavigationBar: SafeArea(
        top: false,

        child: Container(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),

          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),

          decoration: BoxDecoration(
            color: const Color(0xFFFFFBF7),

            borderRadius: BorderRadius.circular(26),

            border: Border.all(color: const Color(0xFFEDE2D8)),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.08),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,

            children: [
              _navItem(index: 0, icon: Icons.home_rounded, label: "Home"),

              _navItem(
                index: 1,
                icon: Icons.favorite_rounded,
                label: "Favorites",
              ),

              _navItem(
                index: 2,
                icon: Icons.shopping_bag_rounded,
                label: "Cart",
              ),

              _navItem(
                index: 3,
                icon: Icons.receipt_long_rounded,
                label: "Orders",
              ),

              _navItem(index: 4, icon: Icons.person_rounded, label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================
  // NAV ITEM
  // =====================================

  Widget _navItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final selected = currentIndex == index;

    return GestureDetector(
      onTap: () {
        _changePage(index);
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),

        curve: Curves.easeOut,

        padding: EdgeInsets.symmetric(
          horizontal: selected ? 13 : 10,
          vertical: 10,
        ),

        decoration: BoxDecoration(
          color: selected ? const Color(0xFFF0E3D7) : Colors.transparent,

          borderRadius: BorderRadius.circular(18),
        ),

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            Icon(
              icon,
              size: 23,

              color: selected
                  ? const Color(0xFF8B5E3C)
                  : const Color(0xFF9B8C82),
            ),

            if (selected) ...[
              const SizedBox(width: 6),

              Text(
                label,

                style: const TextStyle(
                  color: Color(0xFF6F472E),
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
