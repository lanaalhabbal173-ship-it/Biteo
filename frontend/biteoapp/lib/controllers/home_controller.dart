import 'package:biteoapp/models/banner_model.dart';
import 'package:biteoapp/services/banner_service.dart';
import 'package:get/get.dart';

import '../services/home_service.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';

class HomeController extends GetxController {
  final HomeService service = HomeService();
  final BannerService bannerService = BannerService();

  RxList<BannerModel> banners = <BannerModel>[].obs;
  RxList<CategoryModel> categories = <CategoryModel>[].obs;

  RxList<ProductModel> products = <ProductModel>[].obs;

  // بنحتفظ بكل المنتجات هون
  RxList<ProductModel> allProducts = <ProductModel>[].obs;

  var selectedCategory = 0.obs;
  var isLoading = false.obs;

  RxString location = "Damascus, Syria".obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  void changeLocation(String newLocation) {
    location.value = newLocation;
  }

  Future<void> fetchHomeData() async {
    print("🔥 FETCH HOME START");

    try {
      isLoading.value = true;

      // ======================
      // GET CATEGORIES
      // ======================

      final categoriesResponse = await service.getCategories();

      if (categoriesResponse.data is List) {
        categories.value = (categoriesResponse.data as List)
            .map((item) => CategoryModel.fromJson(item))
            .toList();
      }

      // ======================
      // GET BANNERS
      // ======================

      final bannersResponse = await bannerService.getBanners();

      final bannersData = bannersResponse.data;

      if (bannersData is List) {
        banners.value = bannersData
            .map<BannerModel>((item) => BannerModel.fromJson(item))
            .toList();
      } else if (bannersData is Map<String, dynamic>) {
        banners.value = [
          BannerModel.fromJson(bannersData),
        ];
      }

      print("BANNERS COUNT: ${banners.length}");

      if (banners.isNotEmpty) {
        print("BANNER IMAGE: ${banners.first.image}");
      }

      // ======================
      // GET PRODUCTS
      // ======================

      final productsResponse = await service.getProducts();

      dynamic productsData = productsResponse.data;

      if (productsData is Map && productsData['data'] != null) {
        productsData = productsData['data'];
      }

      if (productsData is List) {
        final loadedProducts = productsData
            .map((item) => ProductModel.fromJson(item))
            .toList();

        allProducts.value = loadedProducts;
        products.value = loadedProducts;
      }

      print("CATEGORIES: ${categories.length}");
      print("PRODUCTS: ${products.length}");
    } catch (e) {
      print("HOME ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void changeCategory(int index) {
    selectedCategory.value = index;

    // أول اختيار = All
    if (index == 0) {
      products.value = allProducts;
      return;
    }

    // لأن index 0 مخصص لـ All
    final selectedCategoryModel = categories[index - 1];

    products.value = allProducts
        .where(
          (product) =>
              product.categoryId == selectedCategoryModel.id,
        )
        .toList();
  }
}