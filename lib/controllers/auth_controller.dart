import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late Rx<User?> _user;
  var isCheck = false.obs;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(_auth.currentUser);
    _user.bindStream(_auth.userChanges());
  }

  Future<void> registerUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar(
        'Error creating account',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      Get.snackbar(
        'Error logging in',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void logout() async {
    await _auth.signOut();
  }

  void toggleCheckbox() {
    isCheck.value = !isCheck.value;
  }
}
