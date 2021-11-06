import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/auth_controller.dart';

class LandlordDrawerScreen extends StatelessWidget {
  LandlordDrawerScreen({Key? key}) : super(key: key);
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: _size.height * .02),
      color: teal,
      width: _size.width,
      height: _size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '${authController.userData['name']}',
              style: mainFont(fontSize: 20, color: primaryWhite),
            ),
          ),
          CustomListTile(
            name: 'Reported Tenants',
            icon: Icons.report,
            color: teal,
            size: _size,
            onPressed: () {},
          ),
          CustomListTile(
            name: 'Log Out',
            icon: Icons.logout_outlined,
            color: teal,
            size: _size,
            onPressed: () {
              authController.signOut();
            },
          )
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.name,
    required this.icon,
    required this.color,
    required this.size,
    required this.onPressed,
  }) : super(key: key);

  final String name;
  final icon;
  final Color color;
  final Size size;
  final onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: size.width * .6,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  color: color,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: mainFont(
                      fontSize: 15, color: teal, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          style: ElevatedButton.styleFrom(
            primary: primaryWhite,
          ),
        ),
      ),
    );
  }
}
