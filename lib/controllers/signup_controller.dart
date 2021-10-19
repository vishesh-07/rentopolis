import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final signUpFormKey = GlobalKey<FormState>();
  late TextEditingController emailController,
      nameController,
      passwordController,
      phoneController;
  var email = ''.obs, name = ''.obs, password = ''.obs, phone = ''.obs;
  var emailVaild = false.obs,
      nameVaild = false.obs,
      passwordValid = false.obs,
      phoneValid = false.obs;
  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
    emailVaild = false.obs;
    nameVaild = false.obs;
    passwordValid = false.obs;
    phoneValid = false.obs;
    super.onInit();
    update();
  }

  void updateText(var variable, String text) {
    variable.value = text;
    update();
  }

  void isEmailValid(String emailIdX) {
    GetUtils.isEmail(emailIdX)
        ? emailVaild.value = true
        : emailVaild.value = false;
    update();
  }

  void isNameValid(String nameX) {
    RegExp('[a-zA-Z]').hasMatch(nameX)
        ? nameVaild.value = true
        : nameVaild.value = false;
    update();
  }

  void isPasswordValid(String passwordX) {
    (passwordX.length) > 6
        ? passwordValid.value = true
        : passwordValid.value = false;
    update();
  }

  void isPhoneValid(String phoneX) {
    GetUtils.isPhoneNumber(phoneX)
        ? phoneValid.value = true
        : phoneValid.value = false;
    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.onClose();
    update();
  }
}
