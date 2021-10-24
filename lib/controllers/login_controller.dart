import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginConroller extends GetxController{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  late TextEditingController emailController,passwordController;
  var email=''.obs,password=''.obs;
  @override
  void onInit() {
    emailController= TextEditingController();
    passwordController= TextEditingController();
    super.onInit();
  }
  void updateText(var variable,String text){
    variable.value=text;
    update();
  }
  @override
  void onClose() {
    email.value='';
    password.value='';
    super.onClose();
  }
}