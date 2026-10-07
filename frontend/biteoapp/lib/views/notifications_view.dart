import 'package:biteoapp/controllers/notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({super.key});

final NotificationController controller =
    Get.find<NotificationController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F1EA),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF7F1EA),

        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF2B1D16),
          ),
        ),

        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Color(0xFF2B1D16),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF8B5E3C),
            ),
          );
        }

        if (controller.notifications.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons
                      .notifications_none_rounded,
                  size: 70,
                  color: Color(0xFF8B5E3C),
                ),

                SizedBox(height: 14),

                Text(
                  "No notifications",
                  style: TextStyle(
                    color: Color(0xFF2B1D16),
                    fontSize: 18,
                    fontWeight:
                        FontWeight.w700,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "Order updates will appear here",
                  style: TextStyle(
                    color: Color(0xFF96877C),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color:
              const Color(0xFF8B5E3C),

          onRefresh: () async {
            await controller
                .fetchNotifications();

            await controller
                .fetchUnreadCount();
          },

          child: ListView.separated(
            padding:
                const EdgeInsets.all(20),

            itemCount:
                controller.notifications.length,

            separatorBuilder: (_, __) =>
                const SizedBox(height: 12),

            itemBuilder:
                (context, index) {
              final notification =
                  controller
                      .notifications[index];

              return InkWell(
                borderRadius:
                    BorderRadius.circular(20),

                onTap: () {
                  controller.markAsRead(
                    notification,
                  );
                },

                child: Container(
                  padding:
                      const EdgeInsets.all(14),

                  decoration: BoxDecoration(
                    color: notification.isRead
                        ? const Color(
                            0xFFFFFBF7,
                          )
                        : const Color(
                            0xFFF3E5D8,
                          ),

                    borderRadius:
                        BorderRadius.circular(
                      20,
                    ),

                    border: Border.all(
                      color: notification.isRead
                          ? const Color(
                              0xFFE9DDD2,
                            )
                          : const Color(
                              0xFFD7BCA6,
                            ),
                    ),
                  ),

                  child: Row(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [
                      Container(
                        width: 46,
                        height: 46,

                        decoration:
                            BoxDecoration(
                          color:
                              const Color(
                            0xFFF0E3D7,
                          ),

                          borderRadius:
                              BorderRadius
                                  .circular(
                            14,
                          ),
                        ),

                        child: const Icon(
                          Icons
                              .local_cafe_rounded,
                          color:
                              Color(
                            0xFF8B5E3C,
                          ),
                        ),
                      ),

                      const SizedBox(
                        width: 12,
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,

                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    notification
                                        .title,

                                    style:
                                        const TextStyle(
                                      color:
                                          Color(
                                        0xFF2B1D16,
                                      ),
                                      fontSize:
                                          14,
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                    ),
                                  ),
                                ),

                                if (!notification
                                    .isRead)
                                  Container(
                                    width: 8,
                                    height: 8,

                                    decoration:
                                        const BoxDecoration(
                                      color:
                                          Color(
                                        0xFF8B5E3C,
                                      ),
                                      shape:
                                          BoxShape
                                              .circle,
                                    ),
                                  ),
                              ],
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            Text(
                              notification
                                  .message,

                              style:
                                  const TextStyle(
                                color:
                                    Color(
                                  0xFF7F7066,
                                ),
                                fontSize: 12,
                                height: 1.4,
                              ),
                            ),

                            if (notification
                                .createdAt
                                .isNotEmpty) ...[
                              const SizedBox(
                                height: 7,
                              ),

                              Text(
                                notification
                                    .createdAt,

                                style:
                                    const TextStyle(
                                  color:
                                      Color(
                                    0xFFAA988B,
                                  ),
                                  fontSize:
                                      10.5,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      Obx(() {
                        final deleting =
                            controller
                                    .deletingId
                                    .value ==
                                notification.id;

                        if (deleting) {
                          return const SizedBox(
                            width: 20,
                            height: 20,
                            child:
                                CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Color(
                                0xFF8B5E3C,
                              ),
                            ),
                          );
                        }

                        return IconButton(
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                title: const Text(
                                  "Delete notification?",
                                ),

                                content: const Text(
                                  "Are you sure you want to remove this notification?",
                                ),

                                actions: [
                                  TextButton(
                                    onPressed:
                                        Get.back,
                                    child:
                                        const Text(
                                      "Cancel",
                                    ),
                                  ),

                                  TextButton(
                                    onPressed:
                                        () async {
                                      Get.back();

                                      await controller
                                          .deleteNotification(
                                        notification,
                                      );
                                    },

                                    child:
                                        const Text(
                                      "Delete",
                                      style:
                                          TextStyle(
                                        color: Colors
                                            .redAccent,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },

                          icon: const Icon(
                            Icons
                                .delete_outline_rounded,
                            color:
                                Color(
                              0xFFB86B5E,
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}