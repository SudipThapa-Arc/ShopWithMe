import 'package:get/get.dart';

class AuthController extends GetxController {
  var isCheck = false.obs; // Observable boolean for checkbox

  void toggleCheckbox() {
    isCheck.value = !isCheck.value;
  }
}
