import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  final signUpFormKey=GlobalKey<FormState>();
  late TextEditingController emailController,nameController, passwordController,phoneController;
  var email=''.obs,name=''.obs,password=''.obs,phone=''.obs;
  @override
  void onInit() {
    nameController=TextEditingController();
    emailController=TextEditingController();
    passwordController=TextEditingController();
    phoneController=TextEditingController();
    super.onInit();
    update();
  }
  void updateText(var variable,String text){
    variable.value=text;
    print(text);
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