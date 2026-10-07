import 'package:biteoapp/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderModel order = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F1EA),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF7F1EA),
        elevation: 0,
        centerTitle: true,

        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF2B1D16),
          ),
        ),

        title: Text(
          "Order #${order.id}",
          style: const TextStyle(
            color: Color(0xFF2B1D16),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          20,
          10,
          20,
          30,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF7),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFFE9DDD2),
                ),
              ),

              child: Row(
                children: [
                  Container(
                    width: 52,
                    height: 52,

                    decoration: BoxDecoration(
                      color: const Color(0xFFF0E3D7),
                      borderRadius: BorderRadius.circular(16),
                    ),

                    child: const Icon(
                      Icons.receipt_long_rounded,
                      color: Color(0xFF8B5E3C),
                    ),
                  ),

                  const SizedBox(width: 13),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Order #${order.id}",
                          style: const TextStyle(
                            color: Color(0xFF2B1D16),
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          "${order.items.length} item${order.items.length == 1 ? '' : 's'}",
                          style: const TextStyle(
                            color: Color(0xFF95857A),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  _statusBadge(order.status),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              "Items",
              style: TextStyle(
                color: Color(0xFF2B1D16),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            ...order.items.map(
              (item) => Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFE9DDD2),
                  ),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),

                      child: item.productImage.isEmpty
                          ? _fallback()
                          : Image.network(
                              item.productImage,
                              width: 75,
                              height: 75,
                              fit: BoxFit.cover,
                              errorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return _fallback();
                              },
                            ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            style: const TextStyle(
                              color: Color(0xFF2B1D16),
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 5),

                          if (item.size.isNotEmpty ||
                              item.temperature.isNotEmpty)
                            Text(
                              "${item.size} • ${item.temperature}",
                              style: const TextStyle(
                                color: Color(0xFF8D7D72),
                                fontSize: 12,
                              ),
                            ),

                          if (item.extras.isNotEmpty) ...[
                            const SizedBox(height: 4),

                            Text(
                              item.extras.join(", "),
                              style: const TextStyle(
                                color: Color(0xFFAA988B),
                                fontSize: 11,
                              ),
                            ),
                          ],

                          const SizedBox(height: 8),

                          Text(
                            "\$${item.price}",
                            style: const TextStyle(
                              color: Color(0xFF6F472E),
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),

                      decoration: BoxDecoration(
                        color: const Color(0xFFF0E3D7),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Text(
                        "x${item.quantity}",
                        style: const TextStyle(
                          color: Color(0xFF8B5E3C),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            if (order.deliveryAddress.isNotEmpty) ...[
              const SizedBox(height: 10),

              const Text(
                "Delivery Address",
                style: TextStyle(
                  color: Color(0xFF2B1D16),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color: const Color(0xFFFFFBF7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFFE9DDD2),
                  ),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFF8B5E3C),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          if (order.addressLabel.isNotEmpty)
                            Text(
                              order.addressLabel,
                              style: const TextStyle(
                                color: Color(0xFF2B1D16),
                                fontWeight: FontWeight.w700,
                              ),
                            ),

                          if (order.addressLabel.isNotEmpty)
                            const SizedBox(height: 4),

                          Text(
                            order.deliveryAddress,
                            style: const TextStyle(
                              color: Color(0xFF74665D),
                              fontSize: 13,
                            ),
                          ),

                          if (order.city.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              order.city,
                              style: const TextStyle(
                                color: Color(0xFF95857A),
                                fontSize: 12,
                              ),
                            ),
                          ],

                          if (order.phone.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              order.phone,
                              style: const TextStyle(
                                color: Color(0xFF95857A),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 22),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                color: const Color(0xFFFFFBF7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFE9DDD2),
                ),
              ),

              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      color: Color(0xFF7B6B60),
                      fontSize: 15,
                    ),
                  ),

                  Text(
                    "\$${order.total}",
                    style: const TextStyle(
                      color: Color(0xFF6F472E),
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color background;
    Color textColor;

    switch (status) {
      case "completed":
        background = const Color(0xFFE6F2E8);
        textColor = const Color(0xFF537A5B);
        break;

      case "cancelled":
        background = const Color(0xFFF7E4E1);
        textColor = const Color(0xFFA4584D);
        break;

      default:
        background = const Color(0xFFFFEDD9);
        textColor = const Color(0xFFA66B32);
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 11,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.capitalizeFirst ?? status,
        style: TextStyle(
          color: textColor,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _fallback() {
    return Container(
      width: 75,
      height: 75,
      color: const Color(0xFFEDE1D6),
      child: const Icon(
        Icons.local_cafe_rounded,
        color: Color(0xFF8B5E3C),
        size: 32,
      ),
    );
  }
}