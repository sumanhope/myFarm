import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: MFColors.light,
      backgroundColor: MFColors.primary,
      disabledForegroundColor: MFColors.darkGrey,
      disabledBackgroundColor: MFColors.buttonDisabled,
      side: const BorderSide(color: MFColors.primary),
      padding: const EdgeInsets.symmetric(vertical: MFSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: MFColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MFSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: MFColors.light,
      backgroundColor: MFColors.primary,
      disabledForegroundColor: MFColors.darkGrey,
      disabledBackgroundColor: MFColors.darkerGrey,
      side: const BorderSide(color: MFColors.primary),
      padding: const EdgeInsets.symmetric(vertical: MFSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: MFColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MFSizes.buttonRadius)),
    ),
  );
}
