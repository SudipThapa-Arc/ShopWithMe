import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/views/auth/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (emailController.text.trim().isNotEmpty &&
                    passwordController.text.trim().isNotEmpty) {
                  AuthController.instance
                      .login(emailController.text.trim(), 
                            passwordController.text.trim());
                }
              },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () => Get.to(() => SignupScreen()),
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
} 