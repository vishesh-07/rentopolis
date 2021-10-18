import 'package:get/get.dart';

class PasswordController extends GetxController {
  var passwordVisible = false.obs;
  @override
  void onInit() {
    passwordVisible = false.obs;
    update();
    super.onInit();
  }

  changeIcon() {
    //  passwordVisible=passwordVisible.toggle();
    if (passwordVisible.isTrue) {
      passwordVisible.toggle();
      update();
    } else {
      passwordVisible.toggle();
      update();
    }
  }

  @override
  void onClose() {
    passwordVisible = false.obs;
    update();
    super.onClose();
  }
}
