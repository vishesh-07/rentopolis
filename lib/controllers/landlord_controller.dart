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
import 'package:url_launcher/url_launcher.dart';

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
  var selectedDateString = ''.obs;
  Future<void> selectDate(BuildContext context) async {
    selectedDateString.value = '';
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(
            DateTime.now().year, DateTime.now().month + 1, DateTime.now().day));
    if (picked != null) {
      selectedDateString.value = '${picked.day}/${picked.month}/${picked.year}';
      update();
      // print(selectedDate);
    }
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    rentController = TextEditingController();
    addressController = TextEditingController();
    bedroomController = TextEditingController();
    bathroomController = TextEditingController();
    areaController = TextEditingController();
    aboutController = TextEditingController();
    selectedDateString = ''.obs;
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
        await FirebaseFirestore.instance
            .collection('houses')
            .doc(rNum.toString())
            .set({
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

  openTenantVerificationURL() async {
    if (await canLaunch('https://citizen.mppolice.gov.in/Login.aspx')) {
      await launch('https://citizen.mppolice.gov.in/Login.aspx');
    } else {
      CommanDialog.showErrorDialog(description: 'Invalid Url');
      throw 'Error';
    }
  }

  Future<void> giveHouseOnRent(
    String landlordUid,
    String houseId,
    String appliedBy,
    String name,
    String phone,
    String email,
    String aadharFront,
    String aadharBack,
  ) async {
    try {
      CommanDialog.showLoading();
      List imagedownloadurl = [];
      var response = await FirebaseFirestore.instance
          .collection('houses')
          .doc(houseId)
          .collection('tenant')
          .get();
      if (response.docs.length == 0) {
        for (var img in _image) {
          var ref = firebase_storage.FirebaseStorage.instance.ref().child(
              'images/$landlordUid/$houseId/tenant/$appliedBy/${Path.basename(img.path)}');
          await ref.putFile(img).whenComplete(() async {
            await ref.getDownloadURL().then((value) async {
              imagedownloadurl.add(value);
            });
          });
        }
        // for (var img in _image) {

        FirebaseFirestore.instance
            .collection('houses')
            .doc(houseId)
            .collection('tenant')
            .doc()
            .set({
          'name': name,
          'phone': phone,
          'email': email,
          'aadharFront': aadharFront,
          'aadharBack': aadharBack,
          'appliedBy': appliedBy,
          'rentDate': selectedDateString.value,
          'tenantVerificationCertificate': imagedownloadurl[0]
        });

        CommanDialog.hideLoading();
        Get.back();
      } else {
        CommanDialog.showErrorDialog(description: 'House Already on Rent');
        CommanDialog.hideLoading();
      }
    } catch (e) {
      CommanDialog.showErrorDialog(description: '$e');
      CommanDialog.hideLoading();
    }
  }

  Future<void> reportTenant(String uid) async {
    try {
      var response = await FirebaseFirestore.instance
          .collection('reports')
          .doc('reporting')
          .collection('tenant')
          .where('reportedBy', isEqualTo: authController.userId)
          .where('reportedTenant', isEqualTo: uid)
          .get();
      if (response.docs.isNotEmpty) {
        CommanDialog.showErrorDialog(
            title: 'Already Reported',
            description: 'Tenant is already reported by you.');
      } else {
        FirebaseFirestore.instance
            .collection('reports')
            .doc('reporting')
            .collection('tenant')
            .doc()
            .set(
                {'reportedBy': authController.userId, 'reportedTenant': uid});
      }
    } catch (e) {
      CommanDialog.showErrorDialog(description: '$e');
    }
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
    selectedDateString.value = '';
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
