import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/views/splashscreen/splashscreen.dart';
import 'package:shopwithme/controllers/auth_controller.dart';
import 'firebase_options.dart';
import 'package:shopwithme/design_system/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( 
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  Get.put(AuthController());
  
  // Uncomment this line to force logout for testing
  // await authController.forceLogout();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: AppTheme.light,
      home: const Splashscreen(), // Start with splash screen
    );
  }
}
