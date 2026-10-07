import 'package:biteoapp/models/notification_model.dart';
import 'package:biteoapp/services/notification_service.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final NotificationService notificationService = NotificationService();

  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  RxBool isLoading = false.obs;

  RxInt unreadCount = 0.obs;

  RxString deletingId = ''.obs;

  @override
  void onInit() {
    super.onInit();

    fetchNotifications();
    fetchUnreadCount();
  }

  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;

      final response = await notificationService.getNotifications();

      print("NOTIFICATIONS RESPONSE: ${response.data}");

      final data = response.data;

      List<dynamic> list = [];

      // Response مباشرة List
      if (data is List) {
        list = data;
      }
      // Laravel pagination
      else if (data is Map && data['data'] is List) {
        list = data['data'];
      }
      // Custom response
      else if (data is Map && data['notifications'] is List) {
        list = data['notifications'];
      }

      notifications.value = list
          .map(
            (item) =>
                NotificationModel.fromJson(Map<String, dynamic>.from(item)),
          )
          .toList();

      print("PARSED NOTIFICATIONS: ${notifications.length}");
    } catch (e) {
      print("NOTIFICATIONS ERROR: $e");

      notifications.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchUnreadCount() async {
    try {
      final response = await notificationService.getUnreadCount();

      final data = response.data;

      if (data is Map) {
        unreadCount.value =
            int.tryParse(
              data['count']?.toString() ??
                  data['unread_count']?.toString() ??
                  '0',
            ) ??
            0;
      }
    } catch (e) {
      print("UNREAD COUNT ERROR: $e");
    }
  }

  Future<void> markAsRead(NotificationModel notification) async {
    if (notification.isRead) {
      return;
    }

    try {
      await notificationService.markAsRead(notification.id);

      await fetchNotifications();
      await fetchUnreadCount();
    } catch (e) {
      print("MARK READ ERROR: $e");
    }
  }

  Future<void> deleteNotification(NotificationModel notification) async {
    try {
      deletingId.value = notification.id;

      await notificationService.deleteNotification(notification.id);

      notifications.removeWhere((item) => item.id == notification.id);

      await fetchUnreadCount();

      Get.snackbar(
        "Deleted",
        "Notification removed",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("DELETE NOTIFICATION ERROR: $e");
    } finally {
      deletingId.value = '';
    }
  }
}
