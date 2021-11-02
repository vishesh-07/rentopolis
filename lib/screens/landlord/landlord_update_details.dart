import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/controllers/landlord_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:rentopolis/widgets/edited_text_field.dart';

class LandlordUpdateDetails extends StatelessWidget {
  const LandlordUpdateDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());

    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : (LandlordUpdateDetailsScreen())),
    );
  }
}

class LandlordUpdateDetailsScreen extends StatelessWidget {
  LandlordUpdateDetailsScreen({Key? key}) : super(key: key);
  LandlordController landlordUpdateDetailsController =
      Get.put(LandlordController());
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: _size.width * .15,
                  ),
                  Text(
                    'Update Home Details',
                    style: mainFont(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            EditedTextField(
                hintText: 'Enter Name',
                prefixIcon: Icon(Icons.person),
                textEditingController:
                    landlordUpdateDetailsController.nameController,
                inputType: TextInputType.name,
                variable: landlordUpdateDetailsController.name,
                fromWhich: 'landlordUpdateDetails'),
            EditedTextField(
                hintText: 'Enter Rent',
                prefixIcon: Icon(Icons.monetization_on_outlined),
                textEditingController:
                    landlordUpdateDetailsController.rentController,
                inputType: TextInputType.number,
                variable: landlordUpdateDetailsController.rent,
                fromWhich: 'landlordUpdateDetails'),
            EditedTextField(
                hintText: 'Enter Address',
                prefixIcon: Icon(Icons.location_on),
                textEditingController:
                    landlordUpdateDetailsController.addressController,
                inputType: TextInputType.streetAddress,
                variable: landlordUpdateDetailsController.address,
                fromWhich: 'landlordUpdateDetails'),
            EditedTextField(
                hintText: 'Enter No of Bedroom',
                prefixIcon: Icon(Icons.bed),
                textEditingController:
                    landlordUpdateDetailsController.bedroomController,
                inputType: TextInputType.number,
                variable: landlordUpdateDetailsController.bedroom,
                fromWhich: 'landlordUpdateDetails'),
            EditedTextField(
                hintText: 'Enter No of Bathroom',
                prefixIcon: Icon(Icons.bathtub),
                textEditingController:
                    landlordUpdateDetailsController.bathroomController,
                inputType: TextInputType.number,
                variable: landlordUpdateDetailsController.bathroom,
                fromWhich: 'landlordUpdateDetails'),
            EditedTextField(
                hintText: 'Enter Area (in SQFT)',
                prefixIcon: Icon(Icons.height),
                textEditingController:
                    landlordUpdateDetailsController.areaController,
                inputType: TextInputType.number,
                variable: landlordUpdateDetailsController.area,
                fromWhich: 'landlordUpdateDetails'),
            EditedTextField(
              hintText: 'Enter About',
              prefixIcon: Icon(Icons.info_outline),
              textEditingController:
                  landlordUpdateDetailsController.aboutController,
              inputType: TextInputType.name,
              variable: landlordUpdateDetailsController.about,
              fromWhich: 'landlordUpdateDetails',
              multi: null,
            ),
            SizedBox(
              width: _size.width * .8,
              child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Update Details')),
            )
          ],
        ));
  }
}

// Get.bottomSheet(
//                               SingleChildScrollView(
//                                 child: Column(
//                                   children: [
                                   
                                  //  EditedTextField(
                                  //       hintText: 'Enter Rent',
                                  //       prefixIcon: Icon(Icons.monetization_on_outlined),
                                  //       textEditingController:
                                  //           landlordUpdateDetailsController
                                  //               .rentController,
                                  //       inputType: TextInputType.number,
                                  //       variable:
                                  //           landlordUpdateDetailsController
                                  //               .rent,
                                  //       fromWhich: 'landlordUpdateDetails'),
//                                   ],
//                                 ),
//                               ),
//                               isDismissible: true,
//                               isScrollControlled: true,
//                               backgroundColor: primaryWhite);