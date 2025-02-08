import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/strings.dart';
import 'package:myapp/consts/styles.dart';
import 'package:myapp/views/splashscreen/splashscreen.dart';

void main() {
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
        ),
        fontFamily: regular,
      ),
      debugShowCheckedModeBanner: false,
      home: const Splashscreen(),
    );
  }
}
