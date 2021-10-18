import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/login_controller.dart';
import 'package:rentopolis/controllers/password_controller.dart';
import 'package:rentopolis/controllers/signup_controller.dart';

class EditedPasswordField extends StatelessWidget {
  final PasswordController passwordController = Get.put(PasswordController());
  late String hintText;
  late Icon prefixIcon;
  late TextEditingController textEditingController;
  late Icon suffixIcon1;
  late Icon suffixIcon2;
  late bool obscureText;
  late var variable;
  late String fromWhich;
  EditedPasswordField(
      {required this.hintText,
      required this.prefixIcon,
      required this.textEditingController,
      required this.suffixIcon1,
      required this.suffixIcon2,
      required this.obscureText,
      required this.variable,
      required this.fromWhich});
  SignUpController signUpController = Get.put(SignUpController());
  LoginConroller loginConroller = Get.put(LoginConroller());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        onChanged: (value) {
          (fromWhich == 'signup')
              ? signUpController.updateText(variable, value)
              : loginConroller.updateText(variable, value);
        },
        obscureText: !obscureText,
        style: mainFont(fontSize: 20),
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: Colors.blue,
              ),
            ),
            hintText: hintText,
            prefixIcon: prefixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: const BorderSide(
                color: teal,
              ),
            ),
            // suffixIcon: IconButton(
            //   icon: Get.find<PasswordController>().passwordVisible.value == true
            //       ? suffixIcon1
            //       : suffixIcon2,
            //   onPressed: () {
            //     Get.find<PasswordController>().changeIcon();
            //   },
            suffixIcon: IconButton(
              icon: obscureText ? suffixIcon1 : suffixIcon2,
              onPressed: () {
                passwordController.changeIcon();
              },
            )

            // suffixIcon: (GetBuilder<PasswordController>(
            //     init: PasswordController(),
            //     builder: (controller) => IconButton(
            //           icon: (controller.passwordVisible == true.obs)
            //               ? suffixIcon1
            //               : suffixIcon2,
            //           onPressed: () {
            //             controller.changeIcon();
            //           },
            //         ))),
            ),
      ),
    );
  }
}
