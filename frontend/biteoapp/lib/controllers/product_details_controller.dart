import 'package:biteoapp/models/product_model.dart';
import 'package:biteoapp/services/cart_service.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  late ProductModel product;

  RxString selectedSize = "Medium".obs;
  RxString selectedType = "Hot".obs;

  RxInt quantity = 1.obs;

  RxBool extraShot = false.obs;
  RxBool caramelSyrup = false.obs;
  RxBool vanillaSyrup = false.obs;
  final CartService cartService = CartService();

  RxBool isAddingToCart = false.obs;

  @override
  void onInit() {
    super.onInit();

    product = Get.arguments as ProductModel;
  }

  void selectSize(String size) {
    selectedSize.value = size;
  }

  void selectType(String type) {
    selectedType.value = type;
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  double get basePrice {
    return double.tryParse(product.displayPrice) ?? 0;
  }

  double get extrasPrice {
    double total = 0;

    if (extraShot.value) total += 1.0;
    if (caramelSyrup.value) total += 0.5;
    if (vanillaSyrup.value) total += 0.5;

    return total;
  }

  double get sizePrice {
    if (selectedSize.value == "Large") {
      return 1.0;
    }

    if (selectedSize.value == "Small") {
      return -0.5;
    }

    return 0;
  }

  double get totalPrice {
    final price = basePrice + extrasPrice + sizePrice;

    return price * quantity.value;
  }

  Future<void> addToCart() async {
    try {
      isAddingToCart.value = true;

      List<String> extras = [];

      if (extraShot.value) {
        extras.add("Extra Shot");
      }

      if (caramelSyrup.value) {
        extras.add("Caramel Syrup");
      }

      if (vanillaSyrup.value) {
        extras.add("Vanilla Syrup");
      }

      final response = await cartService.addToCart(
        productId: product.id,
        quantity: quantity.value,
        size: selectedSize.value,
        temperature: selectedType.value,
        extras: extras,
      );

      print("ADD TO CART RESPONSE: ${response.data}");

      Get.snackbar(
        "Added to cart",
        "${product.name} added successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("ADD TO CART ERROR: $e");

      Get.snackbar(
        "Error",
        "Could not add product to cart",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isAddingToCart.value = false;
    }
  }
}
