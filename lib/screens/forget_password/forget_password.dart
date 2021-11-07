import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/controllers/forget_password_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:get/get.dart';
import 'package:rentopolis/widgets/edited_text_field.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  final InternetController _internetController = Get.put(InternetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : ForgetPasswordWidget()),
    );
  }
}

class ForgetPasswordWidget extends StatelessWidget {
  ForgetPasswordWidget({
    Key? key,
  }) : super(key: key);
  ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    forgetPasswordController.email.value = '';
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: _size.height * .05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
                color: teal,
              ),
              Text(
                'Forget Password',
                style: mainFont(fontSize: 30, color: primaryBlack),
              ),
              SizedBox(
                width: _size.width * .1,
              )
            ],
          ),
          SizedBox(
            height: _size.height * .27,
            child: Lottie.asset('assets/gif/forget_password.json'),
          ),
          EditedTextField(
            hintText: 'Enter Email ID',
            prefixIcon: Icon(Icons.mail),
            textEditingController: forgetPasswordController.emailController,
            inputType: TextInputType.emailAddress,
            variable: forgetPasswordController.email,
            fromWhich: 'forgetpassword',
          ),
          SizedBox(
            height: _size.height * .05,
          ),
          SizedBox(
            width: _size.width * .8,
            height: _size.height * .07,
            child: ElevatedButton(
              onPressed: () {
                // print(forgetPasswordController.email);
                authController
                    .resetPassword(forgetPasswordController.email.value.trim());
              },
              child: Text(
                'Reset Password',
                style: mainFont(fontSize: 20, color: primaryWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
