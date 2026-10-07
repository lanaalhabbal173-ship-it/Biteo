import 'package:biteoapp/controllers/address_controller.dart';
import 'package:biteoapp/views/add_address_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddressView extends StatelessWidget {
  AddressView({super.key});

  final AddressController controller =
      Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF7F1EA),

      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF7F1EA),

        elevation: 0,

        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF2B1D16),
          ),
        ),

        title: const Text(
          "Delivery Address",
          style: TextStyle(
            color: Color(0xFF2B1D16),
            fontWeight: FontWeight.w700,
          ),
        ),

        centerTitle: true,
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor:
            const Color(0xFF8B5E3C),

        foregroundColor: Colors.white,

        onPressed: () {
          controller.clearForm();

          Get.to(
            () => AddAddressView(),
          );
        },

        icon: const Icon(
          Icons.add_rounded,
        ),

        label: const Text(
          "Add Address",
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: Color(0xFF8B5E3C),
            ),
          );
        }

        if (controller.addresses.isEmpty) {
          return const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 70,
                  color: Color(0xFF8B5E3C),
                ),

                SizedBox(height: 14),

                Text(
                  "No addresses yet",
                  style: TextStyle(
                    color: Color(0xFF2B1D16),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(height: 5),

                Text(
                  "Add your delivery address",
                  style: TextStyle(
                    color: Color(0xFF96877C),
                  ),
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          color: const Color(0xFF8B5E3C),

          onRefresh:
              controller.fetchAddresses,

          child: ListView.separated(
            padding:
                const EdgeInsets.fromLTRB(
              20,
              20,
              20,
              100,
            ),

            itemCount:
                controller.addresses.length,

            separatorBuilder: (_, __) =>
                const SizedBox(height: 14),

            itemBuilder: (context, index) {
              final address =
                  controller.addresses[index];

              return Container(
                padding:
                    const EdgeInsets.all(16),

                decoration: BoxDecoration(
                  color:
                      const Color(0xFFFFFBF7),

                  borderRadius:
                      BorderRadius.circular(22),

                  border: Border.all(
                    color: address.isDefault
                        ? const Color(
                            0xFF8B5E3C,
                          )
                        : const Color(
                            0xFFE9DDD2,
                          ),
                    width:
                        address.isDefault
                            ? 1.4
                            : 1,
                  ),
                ),

                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [
                    Container(
                      width: 46,
                      height: 46,

                      decoration: BoxDecoration(
                        color:
                            const Color(
                          0xFFF0E3D7,
                        ),

                        borderRadius:
                            BorderRadius.circular(
                          14,
                        ),
                      ),

                      child: Icon(
                        address.label
                                    .toLowerCase() ==
                                "work"
                            ? Icons
                                .business_outlined
                            : Icons.home_outlined,

                        color:
                            const Color(
                          0xFF8B5E3C,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [
                          Row(
                            children: [
                              Text(
                                address.label,

                                style:
                                    const TextStyle(
                                  color:
                                      Color(
                                    0xFF2B1D16,
                                  ),
                                  fontSize: 16,
                                  fontWeight:
                                      FontWeight
                                          .w700,
                                ),
                              ),

                              if (address
                                  .isDefault) ...[
                                const SizedBox(
                                  width: 8,
                                ),

                                Container(
                                  padding:
                                      const EdgeInsets
                                          .symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),

                                  decoration:
                                      BoxDecoration(
                                    color:
                                        const Color(
                                      0xFFF0E3D7,
                                    ),

                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                      20,
                                    ),
                                  ),

                                  child:
                                      const Text(
                                    "Default",
                                    style:
                                        TextStyle(
                                      color:
                                          Color(
                                        0xFF8B5E3C,
                                      ),
                                      fontSize: 10,
                                      fontWeight:
                                          FontWeight
                                              .w700,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),

                          const SizedBox(
                            height: 6,
                          ),

                          Text(
                            address.address,

                            style:
                                const TextStyle(
                              color:
                                  Color(
                                0xFF7F7066,
                              ),
                              fontSize: 13,
                            ),
                          ),

                          if (address.city
                              .isNotEmpty) ...[
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              address.city,
                              style:
                                  const TextStyle(
                                color:
                                    Color(
                                  0xFF9A8C82,
                                ),
                                fontSize: 12,
                              ),
                            ),
                          ],

                          if (address.phone
                              .isNotEmpty) ...[
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              address.phone,
                              style:
                                  const TextStyle(
                                color:
                                    Color(
                                  0xFF9A8C82,
                                ),
                                fontSize: 12,
                              ),
                            ),
                          ],

                          const SizedBox(
                            height: 12,
                          ),

                          Row(
                            children: [
                              if (!address
                                  .isDefault)
                                TextButton(
                                  onPressed: () {
                                    controller
                                        .setDefault(
                                      address,
                                    );
                                  },
                                  child:
                                      const Text(
                                    "Set Default",
                                    style:
                                        TextStyle(
                                      color:
                                          Color(
                                        0xFF8B5E3C,
                                      ),
                                    ),
                                  ),
                                ),

                              const Spacer(),

                              IconButton(
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title:
                                          const Text(
                                        "Delete address?",
                                      ),

                                      content:
                                          const Text(
                                        "Are you sure you want to remove this address?",
                                      ),

                                      actions: [
                                        TextButton(
                                          onPressed:
                                              Get.back,
                                          child:
                                              const Text(
                                            "Cancel",
                                          ),
                                        ),

                                        TextButton(
                                          onPressed:
                                              () async {
                                            Get.back();

                                            await controller
                                                .deleteAddress(
                                              address,
                                            );
                                          },

                                          child:
                                              const Text(
                                            "Delete",
                                            style:
                                                TextStyle(
                                              color:
                                                  Colors
                                                      .redAccent,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },

                                icon: const Icon(
                                  Icons
                                      .delete_outline_rounded,
                                  color:
                                      Color(
                                    0xFFB86B5E,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}