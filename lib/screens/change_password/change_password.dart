import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/controllers/change_password_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/controllers/password_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:rentopolis/widgets/edited_password_field.dart';

class ChangePassword extends StatelessWidget {
  ChangePassword({Key? key}) : super(key: key);
  final InternetController _internetController = Get.put(InternetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : ChangePasswordScreen()),
    );
  }
}

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({Key? key}) : super(key: key);
  ChangePasswordController changePasswordController =
      Get.put(ChangePasswordController());
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
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
                'Change Password',
                style: mainFont(fontSize: 30),
              ),
              SizedBox(
                width: _size.width * .1,
              )
            ],
          ),
          SizedBox(
            height: _size.height * .27,
            child: Lottie.asset('assets/gif/change_password.json'),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (value) {
                  changePasswordController.updateText(
                      changePasswordController.currentPassword, value);
                },
                obscureText:
                    !changePasswordController.currentPasswordVisible.value,
                style: mainFont(fontSize: 20),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    hintText: 'Enter Current Password',
                    prefixIcon: Icon(Icons.vpn_key),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: teal,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon:
                          changePasswordController.currentPasswordVisible.value
                              ? Icon(Icons.visibility)
                              : Icon(Icons.visibility_off),
                      onPressed: () {
                        changePasswordController.currentPasswordChangeIcon();
                      },
                    )),
              ),
            ),
          ),
          Obx(
            () => Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextFormField(
                onChanged: (value) {
                  changePasswordController.updateText(
                      changePasswordController.newPassword, value);
                },
                obscureText: !changePasswordController.newPasswordVisible.value,
                style: mainFont(fontSize: 20),
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    hintText: 'Enter New Password',
                    prefixIcon: Icon(Icons.vpn_key),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(
                        color: teal,
                      ),
                    ),
                    suffixIcon: IconButton(
                      icon: changePasswordController.newPasswordVisible.value
                          ? Icon(Icons.visibility)
                          : Icon(Icons.visibility_off),
                      onPressed: () {
                        changePasswordController.newPasswordChangeIcon();
                      },
                    )),
              ),
            ),
          ),
          SizedBox(
            width: _size.width * .8,
            height: _size.height * .07,
            child: ElevatedButton(
              onPressed: () {
                authController
                    .changePassword(changePasswordController.newPassword.value);
              },
              child: Text(
                'Change Password',
                style: mainFont(fontSize: 20, color: primaryWhite),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
