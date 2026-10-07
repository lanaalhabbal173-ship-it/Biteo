class CartItemModel {
  final int id;
  final int productId;
  final int quantity;
  final String price;
  final String size;
  final String temperature;
  final List<String> extras;

  final String productName;
  final String productImage;

  CartItemModel({
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

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final product = json['product'] ?? {};

    return CartItemModel(
      id: json['id'] ?? 0,
      productId: json['product_id'] ?? 0,
      quantity: json['quantity'] ?? 1,
      price: json['price']?.toString() ?? '0',
      size: json['size'] ?? '',
      temperature: json['temperature'] ?? '',
      extras: json['extras'] != null
          ? List<String>.from(json['extras'])
          : [],
      productName: product['name'] ?? '',
      productImage: product['image'] ?? '',
    );
  }

  double get totalPrice {
    final unitPrice = double.tryParse(price) ?? 0;
    return unitPrice * quantity;
  }
}