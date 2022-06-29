import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  static showSnackBar(String? text) {
    Get.snackbar(
      '',
      text ?? '',
      backgroundColor: Colors.red,
    );
  }

  static getBack() => Get.back();
}
