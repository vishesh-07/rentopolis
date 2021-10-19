import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/forget_password_controller.dart';
import 'package:rentopolis/controllers/login_controller.dart';
import 'package:rentopolis/controllers/signup_controller.dart';

class EditedTextField extends StatelessWidget{
  late String hintText;
  late Icon prefixIcon;
  late TextEditingController textEditingController;
  late TextInputType inputType;
  late var variable;
  late String fromWhich;
  EditedTextField(
      {required this.hintText,
      required this.prefixIcon,
      required this.textEditingController,
      required this.inputType,required this.variable,required this.fromWhich});
      SignUpController signUpController=Get.put(SignUpController());
      LoginConroller loginConroller=Get.put(LoginConroller());
      ForgetPasswordController forgetPasswordController=Get.put(ForgetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        onChanged: (value){
          (fromWhich=='signup')? signUpController.updateText(variable,value):((fromWhich=='login')?loginConroller.updateText(variable, value):forgetPasswordController.updateText(variable, value));
        },
        maxLength:
            (inputType == TextInputType.phone) ? 10 : TextField.noMaxLength,
        keyboardType: inputType,
        style: mainFont(fontSize: 20),
        decoration: InputDecoration(
          counterText: "",
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
        ),
      ),
    );
  }
}
