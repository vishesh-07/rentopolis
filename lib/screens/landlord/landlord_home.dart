import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';

class LandlordHome extends StatelessWidget {
  const LandlordHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : LandlordHomeScreen()),
    );
  }
}
class LandlordHomeScreen extends StatelessWidget {
  const LandlordHomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Landlord'),
    );
  }
}
