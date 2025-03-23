import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/views/splashscreen/splashscreen.dart';
import 'package:shopwithme/controllers/auth_controller.dart';
import 'package:shopwithme/controllers/cart_controller.dart';
import 'package:shopwithme/controllers/home_controller.dart';
import 'package:shopwithme/common_widgets/error_widgets.dart' as app_errors;
import 'package:shopwithme/routes/app_routes.dart';
import 'firebase_options.dart';
import 'package:shopwithme/design_system/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp( 
      options: DefaultFirebaseOptions.currentPlatform,
    );
    
    Get.put(AuthController());
    Get.put(CartController());
    Get.put(HomeController());
    
    // Uncomment this line to force logout for testing
    // await authController.forceLogout();
    
    runApp(const MyApp());
  } catch (e) {
    // Handle initialization errors
    runApp(ErrorApp(error: e.toString()));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopWithMe',
      theme: AppTheme.light,
      home: const Splashscreen(), // Start with splash screen
      defaultTransition: Transition.cupertino,
      getPages: AppRoutes.routes(),
      // Add global error handling
      builder: (context, widget) {
        // Add error boundary
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return Material(
            child: app_errors.ErrorWidget.server(
              onRetry: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const Splashscreen()),
              ),
            ),
          );
        };
        
        return widget!;
      },
    );
  }
}

class ErrorApp extends StatelessWidget {
  final String error;
  
  const ErrorApp({super.key, required this.error});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 64,
                ),
                SizedBox(height: 16),
                Text(
                  'Failed to initialize app',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  error,
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    // Attempt to restart the app
                    main();
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
