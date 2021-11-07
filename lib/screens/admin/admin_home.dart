import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/admin/reported_landlord.dart';
import 'package:rentopolis/screens/admin/reported_tenant.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : const AdminHomeScreen()),
    );
  }
}

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: _size.height * .03,
        ),
        Center(
          child: Text(
            'Admin',
            style: mainFont(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: _size.height * .3,
          child: Lottie.asset('assets/gif/admin.json'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Get.to(const ReportedTenant());
            },
            child: Center(
              child: Text(
                'Reported Tenant',
                style: mainFont(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryWhite),
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: teal,
                elevation: 10,
                minimumSize: Size(double.infinity, _size.height * .07)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Get.to(const ReportedLandlord());
            },
            child: Center(
              child: Text(
                'Reported Landlord',
                style: mainFont(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: primaryWhite),
              ),
            ),
            style: ElevatedButton.styleFrom(
                primary: teal,
                elevation: 10,
                minimumSize: Size(double.infinity, _size.height * .07)),
          ),
        ),
        const Spacer()
      ],
    );
  }
}
