class BannerModel {
  final int id;
  final String title;
  final String image;
  final int? discount;
  final bool isActive;

  BannerModel({
    required this.id,
    required this.title,
    required this.image,
    this.discount,
    required this.isActive,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      discount: json['discount'],
      isActive: json['is_active'] == true ||
          json['is_active'] == 1,
    );
  }
}