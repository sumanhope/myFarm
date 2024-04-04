import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/roundedcontainer.dart';
import 'package:myfarm/features/store/models/ordermodel.dart';
import 'package:myfarm/features/store/screens/cart.dart';
import 'package:myfarm/main.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';
import 'package:myfarm/utils/popus/loader.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final OrderModel order;

  void deleteOrder(String userId, String orderId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).collection('Orders').doc(orderId).delete().then((value) {
        MFLoader.sucessSnackBar(title: "Order Canceled", message: "Your Order has been canceled.");
        Get.off(() => const LandingPage());
      });
    } catch (e) {
      MFLoader.errorSnackBar(title: "Error", message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const MFAppBar(
        showBackArrow: true,
        title: Text("Order Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MFSizes.defaultSpace),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.items.length,
                  itemBuilder: (context, index) {
                    return RoundedContainer(
                      width: double.infinity,
                      padding: const EdgeInsets.all(MFSizes.md),
                      radius: 10,
                      backgroundColor: dark ? MFColors.darkContainer : MFColors.light,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RoundedImage(
                            backgroundColor: dark ? MFColors.darkerGrey : MFColors.light,
                            imageurl: order.items[index].image ?? "",
                            height: 80,
                            width: 90,
                            padding: const EdgeInsets.all(MFSizes.sm),
                          ),
                          const SizedBox(
                            width: MFSizes.md,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 230,
                                child: Text(
                                  order.items[index].title,
                                  style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w800),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Text(
                                "Quantity: ${order.items[index].quantity} ",
                                style: Theme.of(context).textTheme.bodyLarge,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "Rs. ${order.items[index].price} ",
                                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: MFSizes.spaceBtwItems / 2,
              ),
              RoundedContainer(
                width: double.infinity,
                padding: const EdgeInsets.all(MFSizes.md),
                radius: 10,
                backgroundColor: dark ? MFColors.darkContainer : MFColors.primaryBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Id:${order.id} ",
                      style: Theme.of(context).textTheme.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: MFSizes.sm,
                    ),
                    Text(
                      "Order Date: ${order.orderDate} ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: MFSizes.sm,
                    ),
                    Text(
                      "Order Status: ${order.status} ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: MFSizes.sm,
                    ),
                    Text(
                      "Delivered Date: ${order.deliveryDate} ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: MFSizes.sm,
                    ),
                    Text(
                      "Total Amount: ${order.totalAmount} ",
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
              RoundedContainer(
                width: double.infinity,
                padding: const EdgeInsets.all(MFSizes.md),
                radius: 10,
                backgroundColor: dark ? MFColors.darkContainer : MFColors.primaryBackground,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name: ${order.address?.name} ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: MFSizes.sm,
                    ),
                    Text(
                      "Postal code:  ${order.address?.postal} ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: MFSizes.sm,
                    ),
                    Text(
                      "City Name:  ${order.address?.city}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: MFSizes.sm,
                    ),
                    Text(
                      "Country Name:  ${order.address?.country} ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: MFSizes.sm,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: MFSizes.spaceBtwItems,
              ),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                    onPressed: () {
                      deleteOrder(order.userId, order.id);
                    },
                    child: const Text("Cancel Order")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
