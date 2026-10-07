import 'package:biteoapp/models/product_model.dart';

class FavoriteModel {
  final int id;
  final int userId;
  final int productId;
  final ProductModel product;

  FavoriteModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.product,
  });

  factory FavoriteModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return FavoriteModel(
      id: int.tryParse(
            json['id']?.toString() ?? '',
          ) ??
          0,

      userId: int.tryParse(
            json['user_id']?.toString() ?? '',
          ) ??
          0,

      productId: int.tryParse(
            json['product_id']?.toString() ?? '',
          ) ??
          0,

      product: ProductModel.fromJson(
        Map<String, dynamic>.from(
          json['product'] ?? {},
        ),
      ),
    );
  }
}