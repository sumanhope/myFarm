import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/features/store/controllers/cartcontroller.dart';
import 'package:myfarm/features/store/models/cartmodel.dart';
import 'package:myfarm/features/store/screens/checkout.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;

    //final dark = MFHelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: MFAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const SizedBox();
        } else {
          return Padding(
            padding: const EdgeInsets.all(MFSizes.defaultSpace),
            child: ElevatedButton(
              onPressed: () => Get.to(() => const CheckOutScreen()),
              child: Obx(() => Text("Checkout Rs.${controller.totalCartPrice.value}")),
            ),
          );
        }
      }),
      body: Obx(() {
        if (controller.cartItems.isEmpty) {
          return const Center(
            child: Text("No item in carts"),
          );
        } else {
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(MFSizes.defaultSpace),
              child: AllCartItem(),
            ),
          );
        }
      }),
    );
  }
}

class AllCartItem extends StatelessWidget {
  const AllCartItem({
    this.showAddandRemovebuttons = true,
    super.key,
  });

  final bool showAddandRemovebuttons;

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(
          height: MFSizes.spaceBtwSections,
        ),
        itemCount: cartController.cartItems.length,
        itemBuilder: (_, index) {
          return Obx(() {
            final item = cartController.cartItems[index];
            return Column(
              children: [
                CartItem(
                  cartitem: item,
                ),
                if (showAddandRemovebuttons)
                  const SizedBox(
                    height: MFSizes.spaceBtwItems,
                  ),
                if (showAddandRemovebuttons)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 90,
                          ),
                          ProductAddRemove(
                            quantity: item.quantity,
                            add: () => cartController.addOneToCart(item),
                            remove: () => cartController.removeoneFromCart(item),
                          ),
                        ],
                      ),
                      Text(
                        "Rs. ${(item.price * item.quantity).toStringAsFixed(1)}",
                        style: Theme.of(context).textTheme.titleLarge,
                      )
                    ],
                  )
              ],
            );
          });
        },
      ),
    );
  }
}

class ProductAddRemove extends StatelessWidget {
  const ProductAddRemove({
    super.key,
    required this.quantity,
    this.add,
    this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularIcon(
          backgroundColor: dark ? MFColors.darkContainer : MFColors.buttonSecondary,
          height: 32,
          width: 32,
          icon: Icons.remove,
          iconColor: Colors.white,
          func: remove,
        ),
        const SizedBox(
          width: MFSizes.spaceBtwItems,
        ),
        Text(
          quantity.toString(),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: MFSizes.spaceBtwItems,
        ),
        CircularIcon(
          backgroundColor: MFColors.primary,
          height: 32,
          width: 32,
          icon: Icons.add,
          iconColor: Colors.white,
          func: add,
        ),
      ],
    );
  }
}

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key,
    required this.width,
    required this.height,
    this.size = MFSizes.md,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.func,
  });

  final double width, height;
  final double size;

  final IconData icon;
  final Color? backgroundColor, iconColor;
  final VoidCallback? func;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(100)),
      child: Center(
        child: IconButton(
          onPressed: func,
          icon: Icon(
            icon,
            size: size,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartitem,
  });

  final CartItemModel cartitem;

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        RoundedImage(
          backgroundColor: dark ? MFColors.darkerGrey : MFColors.light,
          imageurl: cartitem.image ?? "",
          height: 80,
          width: 90,
          padding: const EdgeInsets.all(MFSizes.sm),
        ),
        const SizedBox(
          width: MFSizes.spaceBtwItems,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  cartitem.title,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.w800),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                ),
              ),
              Text(
                "Stock: ${cartitem.quantity} ",
                style: Theme.of(context).textTheme.bodyLarge,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
              Text(
                "Rs. ${cartitem.price} ",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    this.width = 50,
    this.height = 50,
    this.padding = const EdgeInsets.all(MFSizes.sm),
    required this.imageurl,
    required this.backgroundColor,
  });

  final double? width, height;
  final EdgeInsetsGeometry? padding;

  final String imageurl;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageurl),
          fit: BoxFit.cover,
        ),
        color: backgroundColor,
      ),
    );
  }
}
