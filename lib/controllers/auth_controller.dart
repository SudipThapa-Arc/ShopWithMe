import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/constants/firebase_consts.dart';
import 'package:shopwithme/views/home_screen/home.dart';
import 'package:shopwithme/views/auth_screen/login_screen.dart';
import 'package:shopwithme/models/user_model.dart';
import 'package:shopwithme/services/user_service.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  var isCheck = false.obs;
  var isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final UserService _userService = UserService();

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
  }

  // Email validation method
  bool isEmailValid(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email.trim());
  }

  Future<UserCredential?> login(String email, String password) async {
    try {
      // First validate inputs before attempting login
      if (email.isEmpty || password.isEmpty) {
        Get.snackbar(
          "Error",
          "Please fill all fields",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withAlpha(178),
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          borderRadius: 10,
        );
        return null;
      }

      if (!isEmailValid(email)) {
        Get.snackbar(
          "Error",
          "Please enter a valid email address",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withAlpha(178),
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          borderRadius: 10,
        );
        return null;
      }
      
      isLoading(true);
      
      // Attempt to sign in with existing credentials
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim()
      );
      
      // If login successful, verify user data exists
      if (userCredential.user != null) {
        final userData = await _firestore
            .collection(usersCollection)
            .doc(userCredential.user!.uid)
            .get();
        
        if (userData.exists) {
          // User exists in Firestore, return credentials
          return userCredential;
        } else {
          // User exists in Auth but not in Firestore
          await _auth.signOut();
          Get.snackbar(
            "Error",
            "User data not found. Please register first.",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withAlpha(178),
            colorText: Colors.white,
          );
          return null;
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email format';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many login attempts. Try again later';
          break;
        default:
          errorMessage = e.message ?? 'Authentication failed';
      }
      
      Get.snackbar(
        "Login Failed",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(178),
        colorText: Colors.white,
      );
      return null;
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unexpected error occurred: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(178),
        colorText: Colors.white,
      );
      return null;
    } finally {
      isLoading(false);
    }
    return null;
  }

  Future<UserCredential?> registerUser(String email, String password) async {
    try {
        if (email.trim().isEmpty || password.trim().isEmpty) {
            Get.snackbar(
                "Error",
                "Please fill all fields",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.withAlpha(178),
                colorText: Colors.white,
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                borderRadius: 10,
            );
            return null;
        }

        if (!isEmailValid(email.trim())) {
            Get.snackbar(
                "Error",
                "Please enter a valid email address",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.withAlpha(178),
                colorText: Colors.white,
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                borderRadius: 10,
            );
            return null;
        }

        if (password.trim().length < 6) {
            Get.snackbar(
                "Error",
                "Password must be at least 6 characters",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Colors.red.withAlpha(178),
                colorText: Colors.white,
                margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                borderRadius: 10,
            );
            return null;
        }
    
        isLoading(true);
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim()
        );
        return userCredential;
    } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
            case 'email-already-in-use':
                errorMessage = 'Email is already registered';
                break;
            case 'invalid-email':
                errorMessage = 'Invalid email address';
                break;
            case 'weak-password':
                errorMessage = 'Password is too weak';
                break;
            default:
                errorMessage = e.message ?? 'An error occurred';
        }
        Get.snackbar(
            "Error",
            errorMessage,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withAlpha(178),
            colorText: Colors.white,
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            borderRadius: 10,
        );
        return null;
    } catch (e) {
        Get.snackbar(
            "Error",
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red.withAlpha(178),
            colorText: Colors.white,
            margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
            borderRadius: 10,
        );
        return null;
    } finally {
        isLoading(false);
    }
  }

  Future<void> storeUserData({
    required String email,
    required String password,
    required String name,
    required String uid,
  }) async {
    try {
      DocumentReference store = _firestore.collection(usersCollection).doc(uid);
      await store.set({
        'name': name,
        'password': password,
        'email': email,
        'uid': uid,
        'imageUrl': '',
        'cart_count': "00",
        'wishlist_count': "00",
        'order_count': "00",
        'created_at': DateTime.now(),
      });
    } catch (e) {
      debugPrint('Error storing user data: $e');
      Get.snackbar(
        "Error",
        "Failed to store user data: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(178),
        colorText: Colors.white,
      );
      rethrow;
    }
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const Home());
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(178),
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        borderRadius: 10,
      );
    }
  }

  void toggleCheckbox() {
    isCheck.value = !isCheck.value;
  }

  Future<void> forceLogout() async {
    try {
      await _auth.signOut();
      Get.offAll(() => const Loginscreen());
    } catch (e) {
      debugPrint("Error during force logout: $e");
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create auth user
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // Create user model
        final UserModel newUser = UserModel(
          id: userCredential.user!.uid,
          name: name,
          email: email,
        );

        // Save user data to Firestore
        await _userService.createUser(newUser);

        Get.snackbar(
          'Success',
          'Account created successfully',
          backgroundColor: Colors.green.withAlpha(178),
          colorText: Colors.white,
          margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
          borderRadius: 10,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red.withAlpha(178),
        colorText: Colors.white,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        borderRadius: 10,
      );
      rethrow;
    }
  }

  // Add method to get current user data
  Future<UserModel?> getCurrentUser() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final userData = await _userService.getUser(user.uid);
        if (userData == null) {
          debugPrint('No user data found for uid: ${user.uid}');
        }
        return userData;
      }
      debugPrint('No authenticated user found');
      return null;
    } catch (e) {
      debugPrint('Error in getCurrentUser: $e');
      return null;
    }
  }

  Future<void> refreshUserData() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();
        
        if (userDoc.exists) {
          // Update any local state if needed
          update(); // This will notify GetX listeners
        }
      }
    } catch (e) {
      debugPrint('Error refreshing user data: $e');
    }
  }
}
