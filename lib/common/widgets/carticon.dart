import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/store/controllers/cartcontroller.dart';
import 'package:myfarm/features/store/screens/cart.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class CartCounterItem extends StatelessWidget {
  const CartCounterItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CartController());
    final dark = MFHelperFunctions.isDarkMode(context);
    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => const CartScreen()),
          icon: Icon(
            CupertinoIcons.cart,
            color: dark ? Colors.white : MFColors.black,
          ),
        ),
        Positioned(
          right: 3,
          top: 3,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Obx(
                () => Text(
                  controller.noofCartItems.value.toString(),
                  style: Theme.of(context).textTheme.labelLarge!.apply(
                        color: MFColors.light,
                        fontSizeFactor: 0.9,
                      ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
