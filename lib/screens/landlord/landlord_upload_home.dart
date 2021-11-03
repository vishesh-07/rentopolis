import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/controllers/landlord_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:rentopolis/widgets/edited_text_field.dart';

class LandlordUploadHome extends StatelessWidget {
  const LandlordUploadHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : LandlordUploadHomeScreen()),
    );
  }
}

class LandlordUploadHomeScreen extends StatelessWidget {
  LandlordUploadHomeScreen({Key? key}) : super(key: key);
  LandlordController landlordController = Get.put(LandlordController());
  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        reverse: true,
        child: Column(
          children: [
            SizedBox(
              height: _size.height * .01,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(onPressed: () {
                    Get.back();
                  }, icon: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: _size.width * .15,
                  ),
                  Text(
                    'Upload Home',
                    style: mainFont(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            EditedTextField(
                hintText: 'Enter House Name',
                prefixIcon: Icon(Icons.house),
                textEditingController: landlordController.uploadNameController,
                inputType: TextInputType.name,
                variable: landlordController.uploadName,
                fromWhich: 'landlord'),
            EditedTextField(
                hintText: 'Enter Rent',
                prefixIcon: Icon(Icons.monetization_on_outlined),
                textEditingController: landlordController.uploadRentController,
                inputType: TextInputType.number,
                variable: landlordController.uploadRent,
                fromWhich: 'landlord'),
            EditedTextField(
                hintText: 'Enter Address',
                prefixIcon: Icon(Icons.location_on),
                textEditingController:
                    landlordController.uploadAddressController,
                inputType: TextInputType.streetAddress,
                variable: landlordController.uploadAddress,
                fromWhich: 'landlord'),
            EditedTextField(
                hintText: 'Enter No of Bedroom',
                prefixIcon: Icon(Icons.bed),
                textEditingController:
                    landlordController.uploadBedroomController,
                inputType: TextInputType.number,
                variable: landlordController.uploadBedroom,
                fromWhich: 'landlord'),
            EditedTextField(
                hintText: 'Enter No of Bathroom',
                prefixIcon: Icon(Icons.bathtub),
                textEditingController:
                    landlordController.uploadBathroomController,
                inputType: TextInputType.number,
                variable: landlordController.uploadBathroom,
                fromWhich: 'landlord'),
            EditedTextField(
                hintText: 'Enter Area (in SQFT)',
                prefixIcon: Icon(Icons.height),
                textEditingController: landlordController.uploadAreaController,
                inputType: TextInputType.number,
                variable: landlordController.uploadArea,
                fromWhich: 'landlord'),
            EditedTextField(
              hintText: 'Enter About',
              prefixIcon: Icon(Icons.info_outline),
              textEditingController: landlordController.uploadAboutController,
              inputType: TextInputType.name,
              variable: landlordController.uploadAbout,
              fromWhich: 'landlord',
              multi: null,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: _size.height * .2,
                    width: _size.width * .4,
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
                    child: Text('Upload Images'))
              ],
            ),
            SizedBox(
              width: _size.width * .8,
              child: ElevatedButton(
                  onPressed: () {
                    // landlordController
                    //     .getCoordinates(landlordController.uploadAddress.value);
                    landlordController.upload();
                  },
                  child: Text('Upload Home')),
            )
          ],
        ));
  }
}
