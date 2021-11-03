import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/controllers/landlord_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';

class TenantVerification extends StatelessWidget {
  const TenantVerification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : TenantVerificationScreen()),
    );
  }
}

class TenantVerificationScreen extends StatelessWidget {
  TenantVerificationScreen({Key? key}) : super(key: key);
  LandlordController landlordController = Get.put(LandlordController());
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    landlordController.selectedDateString.value = '';
    var _args = Get.arguments;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: _size.height * .05,
            ),
            Text(
              'Tenant Verificartion',
              style: mainFont(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Aadhar Card Front Side',
                  style: mainFont(fontSize: 20, color: primaryBlack),
                ),
              ),
            ),
            CachedNetworkImage(
              imageUrl: _args[3],
              // height: _size.height * .4,
              // width: _size.width*.8,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Aadhar Card Back Side',
                  style: mainFont(fontSize: 20, color: primaryBlack),
                ),
              ),
            ),
            CachedNetworkImage(
              imageUrl: _args[4],
              // height: _size.height * .4,
              // width: _size.width*.8,
              fit: BoxFit.cover,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: _size.width * .8,
                  child: ElevatedButton(
                      onPressed: () {
                        landlordController.openTenantVerificationURL();
                      },
                      child: Text('Verify Tenant'))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: _size.height * .2,
                    width: _size.width * .2,
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://www.logolynx.com/images/logolynx/2a/2a71ec307740510ce1e7300904131154.png',
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )),
                ElevatedButton(
                    onPressed: () {
                      landlordController.chooseImage();
                    },
                    child: Text('Upload SS of Tenant Verification')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Obx(() => Text('${landlordController.selectedDateString}')),
                ElevatedButton(
                    onPressed: () {
                      landlordController.selectDate(context);
                    },
                    child: Text('Select Renting Date')),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  landlordController.giveHouseOnRent(
                      _args[7],
                      _args[6],
                      _args[5],
                      _args[0],
                      _args[1],
                      _args[2],
                      _args[3],
                      _args[4]);
                },
                child: Text('Give House on Rent'))
          ],
        ),
      ),
    );
  }
}
