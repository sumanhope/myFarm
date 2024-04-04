import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/widgets/appbar.dart';
import 'package:myfarm/common/widgets/carticon.dart';
import 'package:myfarm/features/personalization/controllers/usercontroller.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    final dark = MFHelperFunctions.isDarkMode(context);
    return MFAppBar(
      showBackArrow: false,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hello there!",
            style: Theme.of(context).textTheme.labelMedium!.apply(color: dark ? MFColors.grey : MFColors.black),
          ),
          Obx(
            () => Text(
              controller.user.value.fullname,
              style: Theme.of(context).textTheme.headlineSmall!.apply(color: dark ? MFColors.white : MFColors.black),
            ),
          )
        ],
      ),
      actions: const [
        CartCounterItem(),
      ],
    );
  }
}
