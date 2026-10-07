class OrderItemModel {
  final int id;
  final int productId;
  final int quantity;
  final String price;

  final String size;
  final String temperature;
  final List<String> extras;

  final String productName;
  final String productImage;

  OrderItemModel({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.size,
    required this.temperature,
    required this.extras,
    required this.productName,
    required this.productImage,
  });

  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    final dynamic productData = json['product'];

    final Map<String, dynamic> product = productData is Map<String, dynamic>
        ? productData
        : {};

    List<String> parsedExtras = [];

    final extrasData = json['extras'];

    if (extrasData is List) {
      parsedExtras = extrasData.map((e) => e.toString()).toList();
    }

    return OrderItemModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,

      productId: int.tryParse(json['product_id']?.toString() ?? '') ?? 0,

      quantity: int.tryParse(json['quantity']?.toString() ?? '') ?? 1,

      price: json['price']?.toString() ?? '0',

      size: json['size']?.toString() ?? '',

      temperature: json['temperature']?.toString() ?? '',

      extras: parsedExtras,

      productName: product['name']?.toString() ?? '',

      productImage: product['image']?.toString() ?? '',
    );
  }
}

class OrderModel {
  final int id;

  final String total;
  final String status;
  final String createdAt;

  final String addressLabel;
  final String deliveryAddress;
  final String city;
  final String phone;

  final List<OrderItemModel> items;

  OrderModel({
    required this.id,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.addressLabel,
    required this.deliveryAddress,
    required this.city,
    required this.phone,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<OrderItemModel> parsedItems = [];

    final itemsData = json['items'];

    if (itemsData is List) {
      parsedItems = itemsData
          .whereType<Map<String, dynamic>>()
          .map((item) => OrderItemModel.fromJson(item))
          .toList();
    }

    return OrderModel(
      id: int.tryParse(json['id']?.toString() ?? '') ?? 0,

      total: json['total']?.toString() ?? '0',

      status: json['status']?.toString() ?? 'pending',

      createdAt: json['created_at']?.toString() ?? '',

      addressLabel: json['address_label']?.toString() ?? '',

      deliveryAddress: json['delivery_address']?.toString() ?? '',

      city: json['city']?.toString() ?? '',

      phone: json['phone']?.toString() ?? '',

      items: parsedItems,
    );
  }
}
