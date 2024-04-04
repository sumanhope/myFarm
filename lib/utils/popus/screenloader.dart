import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenLoader {
  static void openLoadingDialog(String text) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static stopLoadingDialog() {
    Navigator.of(Get.overlayContext!).pop();
  }
}
