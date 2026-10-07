class ProductModel {
  final int id;
  final int categoryId;

  final String name;
  final String description;

  final String price;
  final String? offerPrice;

  final bool hasOffer;
  final bool isAvailable;

  final String image;

  ProductModel({
    required this.id,
    required this.categoryId,
    required this.name,
    required this.description,
    required this.price,
    required this.offerPrice,
    required this.hasOffer,
    required this.isAvailable,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? 0,
      categoryId: json['category_id'] ?? 0,

      name: json['name'] ?? '',
      description: json['description'] ?? '',

      price: json['price']?.toString() ?? '0',

      offerPrice: json['offer_price']?.toString(),

      hasOffer: json['has_offer'] == true ||
          json['has_offer'] == 1,

      isAvailable: json['is_available'] == true ||
          json['is_available'] == 1,

      image: json['image'] ?? '',
    );
  }

  String get displayPrice {
    if (hasOffer && offerPrice != null) {
      return offerPrice!;
    }

    return price;
  }
}