import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/models/applied_house_model.dart';
import 'package:rentopolis/models/house_model.dart';

import 'common_dialog.dart';

class DataController extends GetxController {
  @override
  void onInit() {
    totalAppliedTenants=[];
    totalData = [];
    markers = {};
    getUplodedHousesbyLandlord();
    super.onInit();
  }

  onMapCreated(lat, long, title, snippet) {
    markers.add(
      Marker(
          markerId: MarkerId('abc'),
          position: LatLng(lat, long),
          infoWindow: InfoWindow(title: title, snippet: snippet)),
    );
    Future.delayed(Duration(milliseconds: 20), () {
      update();
    });
  }

  @override
  void onClose() {
    totalAppliedTenants=[];
    totalData = [];
    markers = {};
    super.onClose();
  }

  Set<Marker> markers = {};

  // @override
  // void onReady() {
  //   totalData=[];
  //   getUplodedHousesbyLandlord();
  //   super.onReady();
  // }
  final firebaseInstance = FirebaseFirestore.instance;
  AuthController authController = Get.find();
  List<HouseModel> totalData = [];
  List<AppliedHouseModel>totalAppliedTenants=[];
  Future<void> getUplodedHousesbyLandlord() async {
    print("loginUserData YEs ${totalData.length}");
    totalData = [];
    try {
      CommanDialog.showLoading();
      final List<HouseModel> lodadedHouses = [];
      var response = await firebaseInstance
          .collection('houses')
          .where('uid', isEqualTo: authController.userId)
          .get();

      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) {
            print(result.data());
            print("Product ID  ${result.id}");
            lodadedHouses.add(
              HouseModel(
                about: result['about'],
                address: result['address'],
                area: int.parse(result['area']),
                bathroom: int.parse(result['bathroom']),
                bedroom: int.parse(result['bedroom']),
                houseid: result['houseid'],
                images: result['image'],
                name: result['name'],
                rent: int.parse(result['rent']),
                uid: result['uid'],
                latilong: result['latilong'],
              ),
            );
          },
        );
      }
      totalData.addAll(lodadedHouses);
      update();
      CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }

  Future<void> getUplodedHouses() async {
    print("loginUserData YEs ${totalData.length}");
    totalData = [];
    try {
      CommanDialog.showLoading();
      final List<HouseModel> lodadedHouses = [];
      var response = await firebaseInstance.collection('houses').get();

      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) {
            print(result.data());
            // print("Product ID  ${result.id}");
            lodadedHouses.add(
              HouseModel(
                about: result['about'],
                address: result['address'],
                area: int.parse(result['area']),
                bathroom: int.parse(result['bathroom']),
                bedroom: int.parse(result['bedroom']),
                houseid: result['houseid'],
                images: result['image'],
                name: result['name'],
                rent: int.parse(result['rent']),
                uid: result['uid'],
                latilong: result['latilong'],
              ),
            );
          },
        );
      }
      totalData.addAll(lodadedHouses);
      update();
      CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }

  void getAppliedTenants(String houseId) async {
    totalAppliedTenants = [];
    try {
      CommanDialog.showLoading();
      final List<AppliedHouseModel> loadedAppliedTenants = [];
      var response = await firebaseInstance
          .collection('houses')
          .doc(houseId)
          .collection('applied')
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) {
            print(result.data());
            // print("Product ID  ${result.id}");
            loadedAppliedTenants.add(
              AppliedHouseModel(
                  aadharBack: result['aadharBack'],
                  aadharFront: result['aadharFront'],
                  appliedBy: result['appliedBy'],
                  email: result['email'],
                  name: result['name'],
                  phone: result['phone']),
            );
          },
        );
      }
      totalAppliedTenants.addAll(loadedAppliedTenants);
      update();
      CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog(description: '$e');
      // print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      
       CommanDialog.showErrorDialog(description: '$error');
    }
  }
}
