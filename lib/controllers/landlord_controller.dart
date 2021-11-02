import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/controllers/common_dialog.dart';
import 'package:rentopolis/screens/landlord/landlord_home.dart';
import 'package:rentopolis/screens/landlord/landlord_home_details.dart';

class LandlordController extends GetxController {
  AuthController authController = Get.put(AuthController());
  late TextEditingController nameController,
      rentController,
      addressController,
      bedroomController,
      bathroomController,
      areaController,
      aboutController;
  late TextEditingController uploadNameController,
      uploadRentController,
      uploadAddressController,
      uploadBedroomController,
      uploadBathroomController,
      uploadAreaController,
      uploadAboutController;
  var name = ''.obs,
      rent = ''.obs,
      address = ''.obs,
      bedroom = ''.obs,
      bathroom = ''.obs,
      area = ''.obs,
      about = ''.obs;
  var uploadName = ''.obs,
      uploadRent = ''.obs,
      uploadAddress = ''.obs,
      uploadBathroom = ''.obs,
      uploadBedroom = ''.obs,
      uploadArea = ''.obs,
      uploadAbout = ''.obs;
  RxList _image = [].obs;
  ImagePicker picker = ImagePicker();
  @override
  void onInit() {
    nameController = TextEditingController();
    rentController = TextEditingController();
    addressController = TextEditingController();
    bedroomController = TextEditingController();
    bathroomController = TextEditingController();
    areaController = TextEditingController();
    aboutController = TextEditingController();

    uploadNameController = TextEditingController();
    uploadRentController = TextEditingController();
    uploadAddressController = TextEditingController();
    uploadBedroomController = TextEditingController();
    uploadBathroomController = TextEditingController();
    uploadAreaController = TextEditingController();
    uploadAboutController = TextEditingController();
    super.onInit();
  }

  void updateText(var variable, String text) {
    variable.value = text;
    update();
  }

  chooseImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile!.path != null) {
      File pickedImage = File(pickedFile.path);
    }
    // final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    _image.add(File(pickedFile.path));
    update();
  }

  // Future<void> retrieveLostData() async {
  //   final LostDataResponse response = await picker.retrieveLostData();
  //   if (response.isEmpty) {
  //     return;
  //   }
  //   if (response.file != null) {
  //     _image.add(File(response.file!.path));
  //   } else {
  //     print(response.file);
  //   }
  // }

  Future<void> upload() async {
    int min = 1000000; //min and max values act as your 6 digit range
    int max = 9999999;
    var randomizer = Random();
    var rNum = min + randomizer.nextInt(max - min);
    List imagedownloadurl = [];
    CommanDialog.showLoading();
    for (var img in _image) {
      var ref = firebase_storage.FirebaseStorage.instance.ref().child(
          'images/${authController.userId}/$rNum/images/${Path.basename(img.path)}');
      await ref.putFile(img).whenComplete(() async {
        await ref.getDownloadURL().then((value) async {
          imagedownloadurl.add(value);
        });
      });
    }
    GeoCode geoCode = GeoCode();
    try {
      Coordinates coordinates =
          await geoCode.forwardGeocoding(address: uploadAddress.value);
      var latilong = [coordinates.latitude, coordinates.longitude];
      try {
        await FirebaseFirestore.instance.collection('houses').doc(rNum.toString()).set({
          'name': uploadName.value,
          'rent': uploadRent.value,
          'bedroom': uploadBedroom.value,
          'bathroom': uploadBathroom.value,
          'area': uploadArea.value,
          'about': uploadAbout.value,
          'address': uploadAddress.value,
          'uid': authController.userId,
          'image': imagedownloadurl,
          'houseid': rNum,
          'latilong': latilong,
        });
      } catch (e) {
        CommanDialog.showErrorDialog(description: '$e');
      }
    } catch (e) {
      Get.snackbar("Error", 'Enter valid address');
    }

    CommanDialog.hideLoading();
    Get.back();
    // Get.to(LandlordHome());
  }

  @override
  void onClose() {
    name = ''.obs;
    rent = ''.obs;
    address = ''.obs;
    bathroom = ''.obs;
    bedroom = ''.obs;
    area = ''.obs;
    about = ''.obs;
    nameController.dispose();
    rentController.dispose();
    addressController.dispose();
    bathroomController.dispose();
    bedroomController.dispose();
    areaController.dispose();
    aboutController.dispose();

    uploadNameController.dispose();
    uploadRentController.dispose();
    uploadAddressController.dispose();
    uploadBathroomController.dispose();
    uploadBedroomController.dispose();
    uploadAreaController.dispose();
    uploadAboutController.dispose();
    uploadName = ''.obs;
    uploadRent = ''.obs;
    uploadAddress = ''.obs;
    uploadBathroom = ''.obs;
    uploadBedroom = ''.obs;
    uploadArea = ''.obs;
    uploadAbout = ''.obs;
    super.onClose();
  }
}
