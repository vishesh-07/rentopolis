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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    final PasswordController passwordController = Get.put(PasswordController());
    var x='';
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
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_vwCDpL.json'),
            ),
            // SizedBox(
            //   height: _size.height * .1,
            // ),
            EditedTextField(
              hintText: 'Enter Email ID',
              prefixIcon: Icon(Icons.mail),
              textEditingController: _emailController,
              inputType: TextInputType.emailAddress,
              variable: x,
            ),
            Obx(
              () => EditedPasswordField(
                  hintText: 'Enter Password',
                  prefixIcon: Icon(Icons.vpn_key),
                  textEditingController: _passwordController,
                  suffixIcon1: Icon(Icons.visibility),
                  suffixIcon2: Icon(Icons.visibility_off),
                  obscureText: passwordController.passwordVisible.value),
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
