import 'package:flutter/material.dart';
import 'package:myfarm/utils/constants/colors.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: MFColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: MFColors.black),
    selectedColor: MFColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: MFColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: MFColors.darkerGrey,
    labelStyle: TextStyle(color: MFColors.white),
    selectedColor: MFColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: MFColors.white,
  );
}
