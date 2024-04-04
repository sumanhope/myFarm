import 'package:flutter/material.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/device/device_utility.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class MFTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MFTabBar({super.key, required this.tabs});

  final List<Widget> tabs;
  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return Material(
      child: TabBar(
        isScrollable: true,
        indicatorColor: MFColors.primary,
        labelColor: dark ? MFColors.white : MFColors.primary,
        tabs: tabs,
        unselectedLabelColor: MFColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(MFDeviceUtils.getAppBarHeight());
}
