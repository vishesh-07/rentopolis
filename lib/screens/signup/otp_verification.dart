import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/controllers/otp_controller.dart';
import 'package:rentopolis/controllers/radio_button_controller.dart';
import 'package:rentopolis/controllers/signup_controller.dart';
import 'package:rentopolis/main.dart';
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
  final RadioButtonController radioButtonController =
      Get.put(RadioButtonController());
  final OtpController otpController = Get.put(OtpController());
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: const Color.fromRGBO(235, 236, 237, 1),
      borderRadius: BorderRadius.circular(5.0),
    );
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
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Get.back();
                },
                color: teal,
              ),
              Text(
                'OTP Verificaton',
                style: mainFont(fontSize: 30, color: primaryBlack),
              ),
              SizedBox(
                width: _size.width * .1,
              )
            ],
          ),
          Text(
            'An 6 digit OTP has been sent to',
            style: mainFont(fontSize: 15, color: primaryBlack),
          ),
          Text(
            '${signUpController.email}',
            style: mainFont(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: _size.height * .3,
            child: Lottie.network(
                'https://assets10.lottiefiles.com/packages/lf20_gysrp57x.json'),
          ),
          SizedBox(
            height: _size.height * .05,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: PinPut(
                // obscureText: ,
                fieldsCount: 6,
                withCursor: true,
                textStyle: const TextStyle(fontSize: 25.0, color: Colors.black),
                eachFieldWidth: _size.width * .1,
                eachFieldHeight: _size.height * .07,
                // onSubmit: (value){
                //   otpController.verify();
                // },
                focusNode: otpController.pinPutFocusNode,
                controller: otpController.pinPutController,
                submittedFieldDecoration: pinPutDecoration,
                selectedFieldDecoration: pinPutDecoration,
                followingFieldDecoration: pinPutDecoration,
                pinAnimationType: PinAnimationType.fade,
              ),
            ),
          ),
          SizedBox(
            width: _size.width * .8,
            height: _size.height * .07,
            child: ElevatedButton(
              onPressed: () {
                // print(otpController.pinPutController.text);
                // otpController.verify();
                if (otpController.verify() == true) {
                  authController.signUpUser(
                      signUpController.name.value,
                      signUpController.email.value,
                      signUpController.password.value,
                      signUpController.phone.value,
                      radioButtonController
                          .userType[radioButtonController.selectedIndex.value]);
                  Get.snackbar(
                      "Success", 'You are now registered to rentopolis.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: grey,
                      colorText: primaryWhite);
                  Future.delayed(Duration(seconds: 2), () {
                    Get.offAll(InternetCheck());
                  });
                } else {
                  Get.snackbar(
                      "Invalid OTP", 'You have entered an invalid OTP.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: grey,
                      colorText: primaryWhite);
                }
              },
              child: Text(
                'Verify OTP',
                style: mainFont(fontSize: 20, color: primaryWhite),
              ),
            ),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                    onPressed: () {
                      otpController.sendOtp();
                      Get.snackbar("Email Verification",
                          "A 6 digit pin has been sent to your email\n ${signUpController.email}",
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: grey,
                          colorText: primaryWhite);
                    },
                    child: Text(
                      'Resend OTP',
                      style: mainFont(fontSize: 15),
                    )),
              ))
        ],
      ),
    );
  }
}
