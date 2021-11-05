import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  late TextEditingController emailController;
  var email = ''.obs;
  @override
  void onInit() {
    email = ''.obs;
    emailController = TextEditingController();
    super.onInit();
    update();
  }

  void updateText(var variable, String text) {
    variable.value = text;
    update();
  }

  @override
  void onClose() {
    email = ''.obs;
    emailController.clear();
    super.onClose();
    update();
  }
}
