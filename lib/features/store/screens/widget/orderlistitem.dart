import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/roundedcontainer.dart';
import 'package:myfarm/features/personalization/screens/orderdetails.dart';
import 'package:myfarm/features/store/controllers/ordercontroller.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/cloud_helper_functions.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    final controller = Get.put(OrderController());
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        final response = MFCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
        if (response != null) return response;

        final orders = snapshot.data!;
        return ListView.separated(
          itemCount: orders.length,
          shrinkWrap: true,
          separatorBuilder: (_, index) => const SizedBox(
            height: MFSizes.spaceBtwItems,
          ),
          itemBuilder: (_, index) {
            final order = orders[index];
            return RoundedContainer(
              showBorder: true,
              backgroundColor: dark ? MFColors.black : MFColors.light,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.send),
                        const SizedBox(
                          width: MFSizes.spaceBtwItems / 2,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.status,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                order.formattedOrderDate,
                                style: Theme.of(context).textTheme.headlineSmall,
                              )
                            ],
                          ),
                        ),
                        IconButton(
                            onPressed: () => Get.to(
                                  () => OrderDetailsScreen(
                                    order: order,
                                  ),
                                ),
                            icon: const Icon(Icons.arrow_forward_ios))
                      ],
                    ),
                    const SizedBox(
                      height: MFSizes.spaceBtwItems,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.tag),
                              const SizedBox(
                                width: MFSizes.spaceBtwItems / 2,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Order',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    Text(
                                      order.id,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              const Icon(Icons.calendar_month),
                              const SizedBox(
                                width: MFSizes.spaceBtwItems / 2,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Shipping Date',
                                      style: Theme.of(context).textTheme.labelMedium,
                                    ),
                                    Text(
                                      order.formattedDeliveryData,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
