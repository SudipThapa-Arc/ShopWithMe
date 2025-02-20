import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/views/auth/login_screen.dart';
import 'package:myapp/views/home_screen/home_screen.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.off(() => LoginScreen());
        } else {
          Get.off(() => const HomeScreen());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
