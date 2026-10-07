import 'package:get/get.dart';

import '../models/product_model.dart';
import '../services/home_service.dart';

class ProductSearchController extends GetxController {
  final HomeService service = HomeService();

  RxList<ProductModel> results = <ProductModel>[].obs;
  RxList<String> searchHistory = <String>[].obs;
  Future<void> search(String value) async {
    if (value.trim().isEmpty) {
      results.clear();
      return;
    }

    try {
      final response = await service.searchProducts(value);
      print("SEARCH RESPONSE: ${response.data}");

      dynamic data = response.data;

      if (data is Map && data['data'] != null) {
        data = data['data'];
      }

      results.value = (data as List)
          .map((item) => ProductModel.fromJson(item))
          .toList();
    } catch (e) {
      print("SEARCH ERROR : $e");
    }
  }

  void addToHistory(String value) {
    if (value.trim().isEmpty) return;

    if (!searchHistory.contains(value)) {
      searchHistory.add(value);
    }
  }
}
