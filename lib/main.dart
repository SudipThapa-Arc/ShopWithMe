import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/strings.dart';
import 'package:myapp/constants/styles.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/views/splashscreen/splashscreen.dart';

import 'constants/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appname,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: darkFontGrey),
        ),
        fontFamily: regular,
      ),
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
    );
  }
}
