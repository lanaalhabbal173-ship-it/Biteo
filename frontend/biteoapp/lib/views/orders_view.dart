import 'package:biteoapp/controllers/orders_controller.dart';
import 'package:biteoapp/views/order_details_view.dart';

import 'package:biteoapp/widget/orders/order_card.dart';
import 'package:biteoapp/widget/orders/orders_empty_state.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersView extends StatelessWidget {
  OrdersView({super.key});

  final OrdersController controller =
      Get.isRegistered<OrdersController>()
          ? Get.find<OrdersController>()
          : Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF7F1EA,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            20,
            20,
            0,
          ),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              const Text(
                "My Orders",

                style: TextStyle(
                  color:
                      Color(0xFF2B1D16),
                  fontSize: 28,
                  fontWeight:
                      FontWeight.w800,
                ),
              ),

              const SizedBox(
                height: 6,
              ),

              const Text(
                "Track and review your coffee orders",

                style: TextStyle(
                  color:
                      Color(0xFF96877C),
                  fontSize: 14,
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              Expanded(
                child: Obx(() {
                  if (controller
                      .isLoading.value) {
                    return const Center(
                      child:
                          CircularProgressIndicator(
                        color:
                            Color(0xFF8B5E3C),
                      ),
                    );
                  }

                  if (controller
                      .orders.isEmpty) {
                    return const OrdersEmptyState();
                  }

                  return RefreshIndicator(
                    color:
                        const Color(
                      0xFF8B5E3C,
                    ),

                    onRefresh:
                        controller.fetchOrders,

                    child:
                        ListView.separated(
                      physics:
                          const AlwaysScrollableScrollPhysics(
                        parent:
                            BouncingScrollPhysics(),
                      ),

                      itemCount:
                          controller
                              .orders.length,

                      separatorBuilder:
                          (_, __) =>
                              const SizedBox(
                        height: 16,
                      ),

                      itemBuilder:
                          (context, index) {
                        final order =
                            controller
                                .orders[index];

                        return OrderCard(
                          order: order,

                          onTap: () {
                            Get.to(
                              () =>
                                  const OrderDetailsView(),
                              arguments:
                                  order,
                            );
                          },
                        );
                      },
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}