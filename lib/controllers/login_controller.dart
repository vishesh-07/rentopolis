import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginConroller extends GetxController{
  final FirebaseAuth _auth=FirebaseAuth.instance;
   final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var email=''.obs,password=''.obs;
  void updateText(var variable,String text){
    variable.value=text;
    update();
    print(email);
  }
}