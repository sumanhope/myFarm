import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/utils/constants/colors.dart';
import 'package:myfarm/utils/helpers/helper_functions.dart';

class MFLoader {
  static hideSnackBar() => ScaffoldMessenger.of(Get.overlayContext!).hideCurrentMaterialBanner();

  static currentToast({required message}) {
    ScaffoldMessenger.of(Get.overlayContext!).showSnackBar(
      SnackBar(
        content: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: MFHelperFunctions.isDarkMode(Get.context!) ? MFColors.darkerGrey.withOpacity(0.9) : MFColors.grey.withOpacity(0.9),
          ),
          child: Center(
              child: Text(
            message,
            style: Theme.of(Get.context!).textTheme.labelLarge,
          )),
        ),
      ),
    );
  }

  static sucessSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: MFColors.primary,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(10),
      icon: const Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  static warningSnackBar({required title, message = '', duration = 3}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: MFColors.warning,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: const EdgeInsets.all(20),
      icon: const Icon(
        Icons.warning,
        color: Colors.white,
      ),
    );
  }

  static errorSnackBar({required title, message = ''}) {
    Get.snackbar(
      title,
      message,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: Colors.red.shade500,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(20),
      icon: const Icon(
        Icons.warning_amber,
        color: Colors.white,
      ),
    );
  }
}
