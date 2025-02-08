import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;

  // You can add validation methods
  bool isValidEmail() {
    return GetUtils.isEmail(emailController.value.text);
  }

  bool isValidPassword() {
    return passwordController.value.text.length >= 6;
  }

  // Login method
  void loginUser() {
    if (isValidEmail() && isValidPassword()) {
      // Add your login logic here
      Get.snackbar(
        "Success",
        "Logged in successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Error",
        "Please enter valid email and password",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    emailController.value.dispose();
    passwordController.value.dispose();
    super.onClose();
  }
}
