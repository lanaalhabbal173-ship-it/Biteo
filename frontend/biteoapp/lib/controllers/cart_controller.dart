import 'package:biteoapp/controllers/orders_controller.dart';
import 'package:biteoapp/models/cart_item_model.dart';
import 'package:biteoapp/services/cart_service.dart';
import 'package:biteoapp/services/order_service.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  final CartService cartService = CartService();
  final OrderService orderService = OrderService();

  RxList<CartItemModel> items = <CartItemModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isCheckingOut = false.obs;

  RxInt updatingItemId = 0.obs;
  RxInt deletingItemId = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCart();
  }

  Future<void> fetchCart({bool showLoading = true}) async {
    try {
      if (showLoading) {
        isLoading.value = true;
      }

      final response = await cartService.getCart();

      final data = response.data;

      if (data == null) {
        items.clear();
        return;
      }

      final cartItems = data['items'];

      if (cartItems is List) {
        items.value = cartItems
            .map((item) => CartItemModel.fromJson(item))
            .toList();
      } else {
        items.clear();
      }
    } catch (e) {
      print("CART ERROR: $e");
    } finally {
      if (showLoading) {
        isLoading.value = false;
      }
    }
  }

  double get subtotal {
    return items.fold(0, (sum, item) => sum + item.totalPrice);
  }

  Future<void> increaseQuantity(CartItemModel item) async {
    await updateQuantity(item, item.quantity + 1);
  }

  Future<void> decreaseQuantity(CartItemModel item) async {
    if (item.quantity <= 1) {
      await removeItem(item.id);
      return;
    }

    await updateQuantity(item, item.quantity - 1);
  }

  Future<void> updateQuantity(CartItemModel item, int quantity) async {
    try {
      updatingItemId.value = item.id;

      await cartService.updateQuantity(itemId: item.id, quantity: quantity);

      await fetchCart(showLoading: false);
    } catch (e) {
      print("UPDATE CART ERROR: $e");

      Get.snackbar(
        "Error",
        "Could not update quantity",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      updatingItemId.value = 0;
    }
  }

  Future<void> removeItem(int itemId) async {
    try {
      deletingItemId.value = itemId;

      await cartService.removeItem(itemId);

      await fetchCart(showLoading: false);

      Get.snackbar(
        "Removed",
        "Item removed from cart",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print("REMOVE CART ERROR: $e");

      Get.snackbar(
        "Error",
        "Could not remove item",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      deletingItemId.value = 0;
    }
  }

  Future<void> checkout() async {
    if (items.isEmpty) {
      Get.snackbar(
        "Cart is empty",
        "Add some coffee before checkout",
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    try {
      isCheckingOut.value = true;

      final response = await orderService.checkout();

      print("CHECKOUT RESPONSE: ${response.data}");

      final data = response.data;

      // Cart empty from backend
      if (data is Map && data['message'] == 'Cart is empty') {
        Get.snackbar(
          "Cart is empty",
          "There are no items to checkout",
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      // No default delivery address
      if (data is Map && data['message'] == 'No default delivery address') {
        Get.snackbar(
          "Delivery address required",
          "Please add a default delivery address before checkout",
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 4),
        );

        return;
      }

      // Order created successfully
      items.clear();

      // Refresh Orders immediately
      if (Get.isRegistered<OrdersController>()) {
        await Get.find<OrdersController>().fetchOrders();
      }

      Get.snackbar(
        "Order placed ☕",
        "Your order has been placed successfully",
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      print("CHECKOUT ERROR: $e");

      Get.snackbar(
        "Checkout failed",
        "Could not place your order",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isCheckingOut.value = false;
    }
  }
}
