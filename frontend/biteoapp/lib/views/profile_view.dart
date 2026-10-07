import 'package:biteoapp/controllers/profile_controller.dart';
import 'package:biteoapp/views/address_view.dart';
import 'package:biteoapp/views/edit_profile_view.dart';
import 'package:biteoapp/views/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});

  final ProfileController controller = Get.put(ProfileController());

  final GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFF8B5E3C)),
            );
          }

          return RefreshIndicator(
            color: const Color(0xFF8B5E3C),
            onRefresh: controller.fetchProfile,

            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),

              padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  const Text(
                    "Profile",
                    style: TextStyle(
                      color: Color(0xFF2B1D16),
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFBF7),

                      borderRadius: BorderRadius.circular(26),

                      border: Border.all(color: const Color(0xFFE8DDD3)),
                    ),

                    child: Column(
                      children: [
                        Container(
                          width: 90,
                          height: 90,

                          decoration: const BoxDecoration(
                            color: Color(0xFFF0E3D7),
                            shape: BoxShape.circle,
                          ),

                          child: Center(
                            child: Text(
                              controller.name.value.isNotEmpty
                                  ? controller.name.value[0].toUpperCase()
                                  : "U",

                              style: const TextStyle(
                                color: Color(0xFF8B5E3C),
                                fontSize: 34,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Text(
                          controller.name.value.isNotEmpty
                              ? controller.name.value
                              : "Coffee Lover",

                          style: const TextStyle(
                            color: Color(0xFF2B1D16),
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        if (controller.email.value.isNotEmpty) ...[
                          const SizedBox(height: 5),

                          Text(
                            controller.email.value,

                            style: const TextStyle(
                              color: Color(0xFF95857A),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Account",
                    style: TextStyle(
                      color: Color(0xFF2B1D16),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _profileItem(
                    icon: Icons.person_outline_rounded,
                    title: "Personal Information",
                    subtitle: "Manage your account details",

                    onTap: () async {
                      controller.nameController.text = controller.name.value;

                      controller.emailController.text = controller.email.value;

                      await Get.to(() => EditProfileView());

                      await controller.fetchProfile();
                    },
                  ),

                  _profileItem(
                    icon: Icons.location_on_outlined,
                    title: "Delivery Address",
                    subtitle: "Manage your addresses",
                    onTap: () {
                      Get.to(() => AddressView());
                    },
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    "Preferences",
                    style: TextStyle(
                      color: Color(0xFF2B1D16),
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 12),

                  _profileItem(
                    icon: Icons.notifications_none_rounded,
                    title: "Notifications",
                    subtitle: "View your order updates",
                    onTap: () {
                      Get.to(() => NotificationsView());
                    },
                  ),
                  _profileItem(
                    icon: Icons.language_rounded,
                    title: "Language",
                    subtitle: "English",
                    onTap: () {},
                  ),

                  _profileItem(
                    icon: Icons.help_outline_rounded,
                    title: "Help & Support",
                    subtitle: "Get help with your account",
                    onTap: () {},
                  ),

                  const SizedBox(height: 22),

                  InkWell(
                    onTap: _showLogoutDialog,
                    borderRadius: BorderRadius.circular(18),

                    child: Container(
                      width: double.infinity,

                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF8E9E6),

                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: const Row(
                        children: [
                          Icon(Icons.logout_rounded, color: Color(0xFFB15F54)),

                          SizedBox(width: 12),

                          Text(
                            "Log Out",
                            style: TextStyle(
                              color: Color(0xFFB15F54),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _profileItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),

      decoration: BoxDecoration(
        color: const Color(0xFFFFFBF7),

        borderRadius: BorderRadius.circular(18),

        border: Border.all(color: const Color(0xFFECE1D8)),
      ),

      child: ListTile(
        onTap: onTap,

        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),

        leading: Container(
          width: 43,
          height: 43,

          decoration: BoxDecoration(
            color: const Color(0xFFF0E3D7),

            borderRadius: BorderRadius.circular(13),
          ),

          child: Icon(icon, color: const Color(0xFF8B5E3C), size: 22),
        ),

        title: Text(
          title,

          style: const TextStyle(
            color: Color(0xFF2B1D16),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),

        subtitle: Text(
          subtitle,

          style: const TextStyle(color: Color(0xFF9C8C81), fontSize: 11.5),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 15,
          color: Color(0xFFB2A39A),
        ),
      ),
    );
  }

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFFFFFBF7),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),

        title: const Text(
          "Log out?",
          style: TextStyle(
            color: Color(0xFF2B1D16),
            fontWeight: FontWeight.w700,
          ),
        ),

        content: const Text("Are you sure you want to log out?"),

        actions: [
          TextButton(
            onPressed: Get.back,

            child: const Text(
              "Cancel",
              style: TextStyle(color: Color(0xFF8B5E3C)),
            ),
          ),

          TextButton(
            onPressed: () async {
              Get.back();

              await box.remove("token");
              await box.remove("name");
              await box.remove("email");

              Get.offAllNamed("/login");
            },

            child: const Text(
              "Log Out",
              style: TextStyle(
                color: Color(0xFFB15F54),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
