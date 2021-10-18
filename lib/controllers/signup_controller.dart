import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  final signUpFormKey=GlobalKey<FormState>();
  late TextEditingController nameController,emailController, passwordController,phoneController;
  var email='',name='',password='',phone='';
  @override
  void onInit() {
    nameController=TextEditingController();
    emailController=TextEditingController();
    passwordController=TextEditingController();
    phoneController=TextEditingController();
    super.onInit();
  }
  void pp(){
    print(nameController.text.toString());
  }
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}