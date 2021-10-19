import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/controllers/signup_controller.dart';
import 'package:email_auth/email_auth.dart';

class OtpController extends GetxController {
  SignUpController signUpController = Get.put(SignUpController());
  late TextEditingController pinPutController;
  late FocusNode pinPutFocusNode;
  late EmailAuth emailAuth;
  var submitValid = false.obs;
  @override
  void onInit() {
    pinPutController = TextEditingController();
    pinPutFocusNode = FocusNode();
    emailAuth = new EmailAuth(
      sessionName: "Rentopolis",
    );
    super.onInit();
    update();
  }

  void sendOTP() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: signUpController.email.value, otpLength: 6);
    if (result) {
      submitValid.value = true;
      update();
    }
  }

  void verify() {
    
  }

  @override
  void onClose() {
    pinPutController.dispose();
    pinPutController.clear();
    super.onClose();
  }
}
