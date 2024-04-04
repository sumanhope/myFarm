import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class TOutlinedButtonTheme {
  TOutlinedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: MFColors.dark,
      side: const BorderSide(width: 3, color: MFColors.primary),
      textStyle: const TextStyle(fontSize: 16, color: MFColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: MFSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MFSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: MFColors.light,
      side: const BorderSide(width: 3, color: MFColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: MFColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: MFSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MFSizes.buttonRadius)),
    ),
  );
}
