  import 'package:news/util/_string.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SnackbarController snackbar(String message, Color color) {
    return Get.snackbar(
      padding: const EdgeInsets.all(12),
      Strings.error,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
    );
  }