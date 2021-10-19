import 'package:get/get.dart';
import 'package:rentopolis/controllers/forget_password_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/controllers/login_controller.dart';
import 'package:rentopolis/controllers/password_controller.dart';
import 'package:rentopolis/controllers/radio_button_controller.dart';
import 'package:rentopolis/controllers/signup_controller.dart';

class NetworkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InternetController>(() => InternetController());
    Get.lazyPut<PasswordController>(() => PasswordController());
    Get.lazyPut<RadioButtonController>(() => RadioButtonController());
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<LoginConroller>(() => LoginConroller());
    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController());
  }
}
