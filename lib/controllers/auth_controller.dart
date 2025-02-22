import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/firebase_consts.dart';
import 'package:myapp/views/home_screen/home.dart';
import 'package:myapp/views/auth_screen/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  var isCheck = false.obs;
  var isLoading = false.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }

    if (!isEmailValid(email)) {
      Get.snackbar(
        "Error",
        "Please enter a valid email address",
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
    
    try {
      isLoading(true);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim()
      );
      
      // Verify if user exists in Firestore
      var userData = await _firestore
          .collection(usersCollection)
          .doc(userCredential.user!.uid)
          .get();
      
      if (!userData.exists) {
        Get.snackbar(
          "Error",
          "User data not found",
          snackPosition: SnackPosition.BOTTOM,
        );
        await _auth.signOut();
        isLoading(false);
        return null;
      }
      
      isLoading(false);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        default:
          errorMessage = e.message ?? 'An error occurred';
      }
      Get.snackbar(
        "Error",
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } catch (e) {
      isLoading(false);
      Get.snackbar(
        "Error",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  Future<UserCredential?> registerUser(String email, String password) async {
    try {
        if (email.trim().isEmpty || password.trim().isEmpty) {
            Get.snackbar(
                "Error",
                "Please fill all fields",
                snackPosition: SnackPosition.BOTTOM,
            );
            return null;
        }

        if (!isEmailValid(email.trim())) {
            Get.snackbar(
                "Error",
                "Please enter a valid email address",
                snackPosition: SnackPosition.BOTTOM,
            );
            return null;
        }

        if (password.trim().length < 6) {
            Get.snackbar(
                "Error",
                "Password must be at least 6 characters",
                snackPosition: SnackPosition.BOTTOM,
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
        );
        return null;
    } catch (e) {
        Get.snackbar(
            "Error",
            e.toString(),
            snackPosition: SnackPosition.BOTTOM,
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
      print("Error during force logout: $e");
    }
  }
}
