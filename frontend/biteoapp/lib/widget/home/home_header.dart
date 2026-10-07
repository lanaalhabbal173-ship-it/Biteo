import 'package:biteoapp/controllers/home_controller.dart';
import 'package:biteoapp/controllers/notification_controller.dart';
import 'package:biteoapp/views/notifications_view.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeHeader extends StatelessWidget {
  HomeHeader({super.key});

  final NotificationController notificationController =
      Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Container(
      height: 205,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 24),
      decoration: const BoxDecoration(
        color: Color(0xFF3B261C),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  _showLocationSheet(context, controller);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 9,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.10),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: Color(0xFFF3D7BE),
                        size: 20,
                      ),
                      const SizedBox(width: 7),

                      Obx(
                        () => ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 145),
                          child: Text(
                            controller.location.value,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 4),

                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white70,
                        size: 19,
                      ),
                    ],
                  ),
                ),
              ),

              // =====================================
              // NOTIFICATIONS
              // =====================================
              Obx(() {
                final count = notificationController.unreadCount.value;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    InkWell(
                      onTap: () async {
                        await Get.to(() => NotificationsView());

                        await notificationController.fetchNotifications();

                        await notificationController.fetchUnreadCount();
                      },

                      borderRadius: BorderRadius.circular(15),

                      child: Container(
                        height: 44,
                        width: 44,

                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.10),

                          borderRadius: BorderRadius.circular(15),
                        ),

                        child: const Icon(
                          Icons.notifications_none_rounded,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),

                    if (count > 0)
                      Positioned(
                        right: -4,
                        top: -5,

                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),

                          padding: const EdgeInsets.symmetric(horizontal: 5),

                          decoration: BoxDecoration(
                            color: const Color(0xFFDCA66F),

                            borderRadius: BorderRadius.circular(20),

                            border: Border.all(
                              color: const Color(0xFF3B261C),
                              width: 2,
                            ),
                          ),

                          alignment: Alignment.center,

                          child: Text(
                            count > 99 ? "99+" : "$count",

                            style: const TextStyle(
                              color: Color(0xFF3B261C),
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ],
          ),

          const SizedBox(height: 18),

          const Text(
            "Good Morning ☕",
            style: TextStyle(
              color: Color(0xFFE7CDB8),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            "What would you like\nto drink today?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              height: 1.12,
              fontWeight: FontWeight.w700,
              letterSpacing: -.3,
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationSheet(BuildContext context, HomeController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
        decoration: const BoxDecoration(
          color: Color(0xFFFFFBF7),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 5,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFD9CEC4),
                borderRadius: BorderRadius.circular(20),
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              "Select delivery location",
              style: TextStyle(
                color: Color(0xFF2B1D16),
                fontSize: 21,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 20),

            _locationTile(
              icon: Icons.my_location_rounded,
              title: "Current location",
              onTap: () {
                controller.changeLocation("Current Location");

                Get.back();
              },
            ),

            const SizedBox(height: 8),

            _locationTile(
              icon: Icons.location_on_rounded,
              title: "Damascus, Syria",
              onTap: () {
                controller.changeLocation("Damascus, Syria");

                Get.back();
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _locationTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        borderRadius: BorderRadius.circular(20),

        onTap: onTap,

        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),

            border: Border.all(color: const Color(0xFFEFE5DC)),
          ),

          child: Row(
            children: [
              Container(
                height: 42,
                width: 42,

                decoration: BoxDecoration(
                  color: const Color(0xFFF3E5D8),

                  borderRadius: BorderRadius.circular(14),
                ),

                child: Icon(icon, color: const Color(0xFF8B5E3C), size: 22),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Text(
                  title,

                  style: const TextStyle(
                    color: Color(0xFF2B1D16),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Color(0xFFB7A89B),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
