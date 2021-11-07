import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/controllers/tenant_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:rentopolis/screens/tenant/tenant_home.dart';
import 'package:rentopolis/screens/tenant/tenant_home_details.dart';
import 'package:rentopolis/widgets/text_with_back.dart';

class TenantRentForm extends StatelessWidget {
  const TenantRentForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : TenantRentFormScreen()),
    );
  }
}

class TenantRentFormScreen extends StatelessWidget {
  TenantRentFormScreen({Key? key}) : super(key: key);

  TenantController tenantController = Get.put(TenantController());
  @override
  Widget build(BuildContext context) {
    var _args = Get.arguments;
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: _size.height * .08,
            ),
           TextWithBack(text: 'Upload Aadhar Card', size: _size),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {
                    tenantController.chooseImage();
                  }, child: Text('Upload Front Side')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () {tenantController.chooseImage();}, child: Text('Upload Back Side')),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: _size.width * .8,
                child: ElevatedButton(
                  child: Text('Apply For Rent'),
                  onPressed: () {
                   tenantController.upload(_args[1], _args[0]);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
