import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/controllers/signup_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';

class OTPVerification extends StatelessWidget {
  OTPVerification({Key? key}) : super(key: key);
  final InternetController _internetController = Get.put(InternetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : OTPWidget()),
    );
  }
}

class OTPWidget extends StatelessWidget {
  OTPWidget({Key? key}) : super(key: key);
  final SignUpController signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('${Get.arguments.length}',
            style: mainFont(fontSize: 30)),
      ),
    );
  }
}