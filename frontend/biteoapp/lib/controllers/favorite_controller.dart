import 'package:biteoapp/models/favorite_model.dart';
import 'package:get/get.dart';

import '../services/favorite_service.dart';

class FavoriteController extends GetxController {
  final FavoriteService service =
      FavoriteService();

  final RxList<FavoriteModel> favorites =
      <FavoriteModel>[].obs;

  final RxSet<int> favoriteProductIds =
      <int>{}.obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavorites();
  }

  // =========================
  // FETCH FAVORITES
  // =========================

  Future<void> fetchFavorites() async {
    try {
      isLoading.value = true;

      final response =
          await service.getFavorites();

      print(
        "FAVORITES STATUS: "
        "${response.statusCode}",
      );

      print(
        "FAVORITES DATA: "
        "${response.data}",
      );

      if (response.statusCode == 200 &&
          response.data is List) {
        favorites.value =
            (response.data as List)
                .whereType<Map>()
                .map(
                  (item) =>
                      FavoriteModel.fromJson(
                    Map<String, dynamic>.from(
                      item,
                    ),
                  ),
                )
                .toList();

        favoriteProductIds
          ..clear()
          ..addAll(
            favorites.map(
              (favorite) =>
                  favorite.product.id,
            ),
          );
      }
    } catch (e) {
      print(
        "FETCH FAVORITES ERROR: $e",
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // CHECK FAVORITE
  // =========================

  bool isFavorite(int productId) {
    return favoriteProductIds.contains(
      productId,
    );
  }

  // =========================
  // TOGGLE FAVORITE
  // =========================

  Future<void> toggleFavorite(
    int productId,
  ) async {
    final bool currentlyFavorite =
        isFavorite(productId);

    try {
      if (currentlyFavorite) {
        final response =
            await service.removeFavorite(
          productId,
        );

        if (response.statusCode == 200 ||
            response.statusCode == 204) {
          favoriteProductIds.remove(
            productId,
          );

          favorites.removeWhere(
            (favorite) =>
                favorite.product.id ==
                productId,
          );
        }

        return;
      }

      final response =
          await service.addFavorite(
        productId,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final data = response.data;

        if (data is Map &&
            data['favorite'] is Map) {
          final favorite =
              FavoriteModel.fromJson(
            Map<String, dynamic>.from(
              data['favorite'],
            ),
          );

          favoriteProductIds.add(
            favorite.product.id,
          );

          final alreadyExists =
              favorites.any(
            (item) =>
                item.product.id ==
                favorite.product.id,
          );

          if (!alreadyExists) {
            favorites.insert(
              0,
              favorite,
            );
          }
        } else {
          // احتياطاً إذا الـ API ما رجع favorite object
          favoriteProductIds.add(
            productId,
          );

          await fetchFavorites();
        }
      }
    } catch (e) {
      print(
        "TOGGLE FAVORITE ERROR: $e",
      );

      Get.snackbar(
        "Error",
        "Could not update favorites",
        snackPosition:
            SnackPosition.BOTTOM,
      );
    }
  }
}