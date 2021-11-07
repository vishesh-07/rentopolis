import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  late TextEditingController currentPasswordController, newPasswordController;
  var currentPassword = ''.obs, newPassword = ''.obs;
  var currentPasswordVisible = false.obs, newPasswordVisible = false.obs;
  @override
  void onInit() {
    currentPassword = ''.obs;
    currentPasswordController = TextEditingController();
    newPassword = ''.obs;
    newPasswordController = TextEditingController();
    currentPasswordVisible = false.obs;
    newPasswordVisible = false.obs;
    super.onInit();
    update();
  }

  void updateText(var variable, String text) {
    variable.value = text;
    update();
  }

  currentPasswordChangeIcon() {
    if (currentPasswordVisible.isTrue) {
      currentPasswordVisible.toggle();
      update();
    } else {
      currentPasswordVisible.toggle();
      update();
    }
  }

  newPasswordChangeIcon() {
    if (newPasswordVisible.isTrue) {
      newPasswordVisible.toggle();
      update();
    } else {
      newPasswordVisible.toggle();
      update();
    }
  }

  @override
  void onClose() {
    currentPassword = ''.obs;
    currentPasswordController.clear();
    newPassword = ''.obs;
    newPasswordController.clear();
    currentPasswordVisible = false.obs;
    newPasswordVisible = false.obs;
    super.onClose();
    update();
  }
}
