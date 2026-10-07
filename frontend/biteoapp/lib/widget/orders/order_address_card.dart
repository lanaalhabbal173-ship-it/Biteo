import 'package:biteoapp/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderAddressCard extends StatelessWidget {
  final OrderModel order;

  const OrderAddressCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    if (order.deliveryAddress.isEmpty) {
      return const SizedBox();
    }

    return Column(
      children: [
        const SizedBox(height: 6),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(13),

          decoration: BoxDecoration(
            color: const Color(0xFFF5ECE4),

            borderRadius:
                BorderRadius.circular(16),

            border: Border.all(
              color: const Color(0xFFE8D9CD),
            ),
          ),

          child: Row(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              Container(
                width: 38,
                height: 38,

                decoration: BoxDecoration(
                  color:
                      const Color(0xFFEAD9CB),

                  borderRadius:
                      BorderRadius.circular(12),
                ),

                child: const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF8B5E3C),
                  size: 21,
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Text(
                      order.addressLabel.isNotEmpty
                          ? order.addressLabel
                          : "Delivery Address",

                      style: const TextStyle(
                        color: Color(0xFF2B1D16),
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      order.deliveryAddress,

                      style: const TextStyle(
                        color: Color(0xFF74665D),
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),

                    if (order.city.isNotEmpty) ...[
                      const SizedBox(height: 3),

                      Row(
                        children: [
                          const Icon(
                            Icons
                                .location_city_outlined,
                            size: 13,
                            color:
                                Color(0xFF9A8C82),
                          ),

                          const SizedBox(width: 4),

                          Text(
                            order.city,

                            style: const TextStyle(
                              color:
                                  Color(
                                0xFF9A8C82,
                              ),
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ],

                    if (order.phone.isNotEmpty) ...[
                      const SizedBox(height: 3),

                      Row(
                        children: [
                          const Icon(
                            Icons.phone_outlined,
                            size: 13,
                            color:
                                Color(0xFF9A8C82),
                          ),

                          const SizedBox(width: 4),

                          Text(
                            order.phone,

                            style: const TextStyle(
                              color:
                                  Color(
                                0xFF9A8C82,
                              ),
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}