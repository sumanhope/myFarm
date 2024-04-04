import 'package:flutter/material.dart';

import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class MFSettingTile extends StatelessWidget {
  const MFSettingTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.trailing,
    this.onTap,
  });

  final IconData icon;
  final String title, subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = MFHelperFunctions.isDarkMode(context);
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: dark ? MFColors.white : MFColors.black,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium,
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
