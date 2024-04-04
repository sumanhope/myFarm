import 'package:flutter/material.dart';
import 'package:myfarm/utils/constants/sizes.dart';

class MFSpacingStyle {
  static const EdgeInsetsGeometry paddingWithAppBarHeight = EdgeInsets.only(
    top: MFSizes.appBarHeight,
    left: MFSizes.defaultSpace,
    bottom: MFSizes.defaultSpace,
    right: MFSizes.defaultSpace,
  );
}
