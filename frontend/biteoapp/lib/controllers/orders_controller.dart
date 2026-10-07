import 'package:biteoapp/models/order_model.dart';
import 'package:biteoapp/services/order_service.dart';
import 'package:biteoapp/views/order_details_view.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  final OrderService orderService = OrderService();

  RxList<OrderModel> orders = <OrderModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool isOpeningOrder = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;

      final response =
          await orderService.getOrders();

      if (response.data is List) {
        orders.value =
            (response.data as List)
                .map(
                  (item) =>
                      OrderModel.fromJson(
                    Map<String, dynamic>.from(
                      item,
                    ),
                  ),
                )
                .toList();
      }
    } catch (e) {
      print("ORDERS ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openOrderFromNotification(
    int orderId,
  ) async {
    try {
      isOpeningOrder.value = true;

      final response =
          await orderService.getOrderById(
        orderId,
      );

      final data = response.data;

      if (data is Map) {
        final order =
            OrderModel.fromJson(
          Map<String, dynamic>.from(
            data,
          ),
        );

        Get.to(
          () => const OrderDetailsView(),
          arguments: order,
        );
      }
    } catch (e) {
      print(
        "OPEN ORDER FROM NOTIFICATION ERROR: $e",
      );

      Get.snackbar(
        "Error",
        "Could not open this order",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isOpeningOrder.value = false;
    }
  }
}