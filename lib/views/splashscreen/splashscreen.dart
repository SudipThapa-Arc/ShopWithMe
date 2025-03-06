import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/constants/colors.dart';
import 'package:shopwithme/constants/strings.dart';
import 'package:shopwithme/views/auth_screen/login_screen.dart';
import 'package:shopwithme/views/home_screen/home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> 
    with SingleTickerProviderStateMixin {
  
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));

    // Start animation
    _controller.forward();

    // Add debug prints to check auth state
    Future.delayed(const Duration(seconds: 3), () {
      final currentUser = FirebaseAuth.instance.currentUser;
      print("Current user: ${currentUser?.email}"); // Debug print
      
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        print("Auth state changed. User: ${user?.email}"); // Debug print
        if (user == null) {
          print("No user logged in, navigating to login screen"); // Debug print
          Get.off(() => const Loginscreen());
        } else {
          print("User is logged in, navigating to home screen"); // Debug print
          Get.off(() => const Home());
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo or App Icon
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.shopping_bag_outlined,
                  size: 60,
                  color: redColor,
                ),
              ),
              
              const SizedBox(height: 20),
              
              // App Name
              Text(
                appname,
                style: const TextStyle(
                  color: whiteColor,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              
              const SizedBox(height: 10),
              
              // Tagline
              const Text(
                "Your Ultimate Shopping Destination",
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 16,
                  letterSpacing: 1,
                ),
              ),
              
              const SizedBox(height: 50),
              
              // Loading Indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(whiteColor),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
