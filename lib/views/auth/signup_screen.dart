import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (emailController.text.trim().isNotEmpty &&
                    passwordController.text.trim().isNotEmpty &&
                    passwordController.text == confirmPasswordController.text) {
                  AuthController.instance.registerUser(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    'Please check your inputs',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              child: const Text("Sign Up"),
            ),
            TextButton(
              onPressed: () => Get.back(),
              child: const Text("Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
} 