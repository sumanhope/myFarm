import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:myfarm/features/personalization/controllers/favcontroller.dart';
import 'package:myfarm/features/store/screens/cart.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class FavoriteIcon extends StatelessWidget {
  const FavoriteIcon({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    final controller = Get.put(FavoriteController());
    return Obx(
      () => CircularIcon(
        width: 40,
        height: 40,
        icon: controller.isFav(productId) ? EvaIcons.heart : EvaIcons.heart_outline,
        backgroundColor: dark ? MFColors.darkContainer : MFColors.primary.withOpacity(0.5),
        iconColor: controller.isFav(productId) ? MFColors.error : null,
        size: MFSizes.lg,
        func: () => controller.toggleFav(productId),
      ),
    );
  }
}
