import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/utils/constants/sizes.dart';
import 'package:myfarm/utils/device/device_utility.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class MFAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MFAppBar({
    super.key,
    this.title,
    required this.showBackArrow,
    this.leadingIcon,
    this.actions,
    this.func,
  });

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? func;

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MFSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  CupertinoIcons.arrow_left,
                  color: dark ? Colors.white : Colors.black,
                ),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: func,
                    icon: Icon(
                      leadingIcon,
                      color: dark ? Colors.white : Colors.black,
                    ),
                  )
                : null,
        title: title,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MFDeviceUtils.getAppBarHeight());
}
