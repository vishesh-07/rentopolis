import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController{
  late TextEditingController emailController;
  var email=''.obs;
  @override
  void onInit() {
    emailController=TextEditingController();
    super.onInit();
    update();
  }
  void updateText(var variable,String text){
    variable.value=text;
    update();
  }
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}