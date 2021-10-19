import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/login_controller.dart';
import 'package:rentopolis/controllers/password_controller.dart';
import 'package:rentopolis/screens/forget_password/forget_password.dart';
import 'package:rentopolis/screens/signup/signup.dart';
import 'package:rentopolis/widgets/edited_password_field.dart';
import 'package:rentopolis/widgets/edited_text_field.dart';

class LoginScreen extends GetWidget<LoginConroller> {
  LoginScreen({Key? key}) : super(key: key);

  final PasswordController passwordController = Get.put(PasswordController());
  final LoginConroller loginConroller = Get.put(LoginConroller());
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return Center(
      child: SingleChildScrollView(
        reverse: true,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _size.height * .05,
            ),
            Text('Login', style: mainFont(fontSize: 30, color: primaryBlack)),
            SizedBox(
              height: _size.height * .3,
              child: Lottie.asset(
                  'assets/gif/login.json'),
            ),
            // SizedBox(
            //   height: _size.height * .1,
            // ),
            EditedTextField(
              hintText: 'Enter Email ID',
              prefixIcon: Icon(Icons.mail),
              textEditingController: loginConroller.emailController,
              inputType: TextInputType.emailAddress,
              variable: loginConroller.email,
              fromWhich: 'login',
            ),
            Obx(
              () => EditedPasswordField(
                hintText: 'Enter Password',
                prefixIcon: Icon(Icons.vpn_key),
                textEditingController: loginConroller.passwordController,
                suffixIcon1: Icon(Icons.visibility),
                suffixIcon2: Icon(Icons.visibility_off),
                obscureText: passwordController.passwordVisible.value,
                variable: loginConroller.password,
                fromWhich: 'login',
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Get.to(ForgetPassword());
                },
                child: Text(
                  'Forget Password?',
                  style: mainFont(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              width: _size.width * .8,
              height: _size.height * .07,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Login',
                  style: mainFont(fontSize: 20, color: primaryWhite),
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have account?",
                  style: mainFont(fontSize: 15, color: grey),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(Signup());
                    },
                    child: Text(
                      'Create a new account',
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
}
