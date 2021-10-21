import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/controllers/otp_controller.dart';
import 'package:rentopolis/controllers/password_controller.dart';
import 'package:rentopolis/controllers/radio_button_controller.dart';
import 'package:rentopolis/controllers/signup_controller.dart';
import 'package:rentopolis/screens/login/login.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:rentopolis/screens/signup/otp_verification.dart';
import 'package:rentopolis/widgets/edited_password_field.dart';
import 'package:rentopolis/widgets/edited_text_field.dart';

class Signup extends GetWidget<SignUpController> {
  Signup({Key? key}) : super(key: key);
  final InternetController _internetController = Get.put(InternetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : SignupWidget()),
    );
  }
}

class SignupWidget extends StatelessWidget {
  SignupWidget({
    Key? key,
  }) : super(key: key);
  final PasswordController passwordController = Get.put(PasswordController());
  final SignUpController signUpController = Get.put(SignUpController());
  final RadioButtonController radioButtonController =
      Get.put(RadioButtonController());
  final OtpController otpController = Get.put(OtpController());
  TextEditingController email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      reverse: true,
      child: Form(
        key: signUpController.signUpFormKey,
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
                  'Sign Up',
                  style: mainFont(fontSize: 30, color: primaryBlack),
                ),
                SizedBox(
                  width: _size.width * .1,
                )
              ],
            ),
            SizedBox(
              height: _size.height * .3,
              child: Lottie.asset('assets/gif/signup.json'),
            ),
            EditedTextField(
              hintText: 'Enter Name',
              prefixIcon: Icon(Icons.person),
              textEditingController: signUpController.nameController,
              inputType: TextInputType.name,
              variable: signUpController.name,
              fromWhich: 'signup',
            ),
            EditedTextField(
              hintText: 'Enter Email ID',
              prefixIcon: Icon(Icons.mail),
              textEditingController: signUpController.emailController,
              inputType: TextInputType.emailAddress,
              variable: signUpController.email,
              fromWhich: 'signup',
            ),
            Obx(() => EditedPasswordField(
                  hintText: 'Enter Password',
                  prefixIcon: Icon(Icons.vpn_key),
                  textEditingController: signUpController.passwordController,
                  suffixIcon1: Icon(Icons.visibility),
                  suffixIcon2: Icon(Icons.visibility_off),
                  obscureText: passwordController.passwordVisible.value,
                  variable: signUpController.password,
                  fromWhich: 'signup',
                )),
            EditedTextField(
              hintText: 'Enter Phone No.',
              prefixIcon: Icon(Icons.phone),
              textEditingController: signUpController.phoneController,
              inputType: TextInputType.phone,
              variable: signUpController.phone,
              fromWhich: 'signup',
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "I'm a",
                style: mainFont(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() => customRadio(radioButtonController.userType[0], 0)),
                  Obx(() => customRadio(radioButtonController.userType[1], 1)),
                ],
              ),
            ),
            SizedBox(
              width: _size.width * .8,
              height: _size.height * .07,
              child: ElevatedButton(
                onPressed: () {
                  signUpController.isEmailValid(signUpController.email.value);
                  signUpController.isNameValid(signUpController.name.value);
                  signUpController
                      .isPasswordValid(signUpController.password.value);
                  signUpController.isPhoneValid(signUpController.phone.value);
                  if (signUpController.emailVaild == true &&
                      signUpController.nameVaild == true &&
                      signUpController.passwordValid == true &&
                      signUpController.phoneValid == true) {
                    otpController.sendOtp();
                    Get.snackbar("Email Verification",
                        "A 6 digit pin has been sent to your email\n ${signUpController.email}",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: grey,
                        colorText: primaryWhite);
                    Future.delayed(Duration(seconds: 2), () {
                      Get.to(OTPVerification());
                    });
                  } else {
                    bool email, name, phone, password;
                    email = !signUpController.emailVaild.value;
                    name = !signUpController.nameVaild.value;
                    phone = !signUpController.phoneValid.value;
                    password = !signUpController.passwordValid.value;
                    String msg = '';
                    msg += name ? 'Invalid Name\n' : '';
                    msg += email ? 'Invalid Email ID\n' : '';
                    msg += password ? 'Invalid Password\n' : '';
                    msg += phone ? 'Invalid Phone Number\n' : '';
                    Get.snackbar("Invalid Details", msg,
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: grey,
                        colorText: primaryWhite);
                  }

                  // print(signUpController.email.value.l);
                },
                child: Text(
                  'Sign Up',
                  style: mainFont(fontSize: 20, color: primaryWhite),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: mainFont(fontSize: 15, color: grey),
                ),
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Login',
                      style: mainFont(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: teal),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget customRadio(String txt, int index) {
    return OutlinedButton(
      onPressed: () {
        radioButtonController.changeIndex(index);
      },
      style: OutlinedButton.styleFrom(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor:
            radioButtonController.selectedIndex == index ? teal : primaryWhite,
        // backgroundColor: Colors.grey,
      ),
      child: Text(
        txt,
        style: mainFont(
          fontSize: 15,
          color: radioButtonController.selectedIndex == index
              ? primaryWhite
              : teal,
        ),
      ),
    );
  }
}
