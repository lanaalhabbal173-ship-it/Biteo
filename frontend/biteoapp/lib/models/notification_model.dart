class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String createdAt;
  final bool isRead;

  final int orderId;
  final String status;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.createdAt,
    required this.isRead,
    required this.orderId,
    required this.status,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];

    Map<String, dynamic> data = {};

    if (rawData is Map) {
      data = Map<String, dynamic>.from(rawData);
    }

    return NotificationModel(
      id: json['id']?.toString() ?? '',

      title: data['title']?.toString() ?? 'Order Update',

      message: data['message']?.toString() ?? '',

      createdAt: json['created_at']?.toString() ?? '',

      isRead: json['read_at'] != null,

      orderId: int.tryParse(data['order_id']?.toString() ?? '') ?? 0,

      status: data['status']?.toString() ?? '',
    );
  }
}
