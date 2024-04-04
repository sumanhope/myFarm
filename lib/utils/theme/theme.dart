import 'package:flutter/material.dart';
import 'package:myfarm/utils/theme/widget_themes/text_theme.dart';
import 'package:myfarm/utils/theme/widget_themes/appbar_theme.dart';
import 'package:myfarm/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:myfarm/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:myfarm/utils/theme/widget_themes/chip_theme.dart';
import 'package:myfarm/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:myfarm/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:myfarm/utils/theme/widget_themes/text_field_theme.dart';

import '../constants/colors.dart';

class MFAppTheme {
  MFAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: MFColors.grey,
    brightness: Brightness.light,
    primaryColor: MFColors.primary,
    textTheme: TTextTheme.lightTextTheme,
    chipTheme: TChipTheme.lightChipTheme,
    scaffoldBackgroundColor: const Color.fromARGB(235, 255, 255, 255),
    appBarTheme: TAppBarTheme.lightAppBarTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: MFTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: MFColors.grey,
    brightness: Brightness.dark,
    primaryColor: MFColors.primary,
    textTheme: TTextTheme.darkTextTheme,
    chipTheme: TChipTheme.darkChipTheme,
    scaffoldBackgroundColor: MFColors.black,
    appBarTheme: TAppBarTheme.darkAppBarTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: MFTextFormFieldTheme.darkInputDecorationTheme,
  );
}
