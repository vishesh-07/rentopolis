import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/models/applied_house_model.dart';
import 'package:rentopolis/models/current_tenant_model.dart';
import 'package:rentopolis/models/house_model.dart';
import 'package:rentopolis/models/reported_model.dart';

import 'common_dialog.dart';

class DataController extends GetxController {
  @override
  void onInit() {
    totalAppliedTenants = [];
    totalData = [];
    currentTenant = [];
    totalFavoriteHouse = [];
    markers = {};
    totalReportedTenants = [];
    totalReportedLandlords = [];
    totalReportedLandlordbyTenant=[];
    totalReportedTenantbyLandlord=[];
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
    totalAppliedTenants = [];
    totalData = [];
    currentTenant = [];
    totalFavoriteHouse = [];
    totalReportedTenants = [];
    totalReportedLandlords = [];
    totalReportedLandlordbyTenant=[];
    totalReportedTenantbyLandlord=[];
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
  List<HouseModel> totalData = [], totalFavoriteHouse = [];
  List<AppliedHouseModel> totalAppliedTenants = [];
  List<CurrentTenantModel> currentTenant = [];
  List<ReportedModel> totalReportedTenants = [], totalReportedLandlords = [],totalReportedLandlordbyTenant=[],totalReportedTenantbyLandlord=[];
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

  void getCurrentTenant(String houseId) async {
    currentTenant = [];
    try {
      CommanDialog.showLoading();
      final List<CurrentTenantModel> loadedCurrentTenant = [];
      var response = await firebaseInstance
          .collection('houses')
          .doc(houseId)
          .collection('tenant')
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) {
            print(result.data());
            // print("Product ID  ${result.id}");
            loadedCurrentTenant.add(
              CurrentTenantModel(
                  aadharBack: result['aadharBack'],
                  aadharFront: result['aadharFront'],
                  appliedBy: result['appliedBy'],
                  email: result['email'],
                  name: result['name'],
                  phone: result['phone'],
                  rentDate: result['rentDate'],
                  tenantCertificate: result['tenantVerificationCertificate']),
            );
          },
        );
      }
      currentTenant.addAll(loadedCurrentTenant);
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

  Future<void> getFavoriteHouses() async {
    totalFavoriteHouse = [];
    try {
      CommanDialog.showLoading();
      final List<HouseModel> loadedFavoriteHouses = [];
      var response = await firebaseInstance
          .collection('favorites')
          .where('uid', isEqualTo: authController.userId)
          .get();

      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) async {
            var res = await firebaseInstance
                .collection('houses')
                .where('houseid', isEqualTo: int.parse(result['houseId']))
                .get();
            if (res.docs.isNotEmpty) {
              res.docs.forEach((ans) {
                print(ans.data());
                print("Product ID  ${ans.id}");
                loadedFavoriteHouses.add(
                  HouseModel(
                    about: ans['about'],
                    address: ans['address'],
                    area: int.parse(ans['area']),
                    bathroom: int.parse(ans['bathroom']),
                    bedroom: int.parse(ans['bedroom']),
                    houseid: ans['houseid'],
                    images: ans['image'],
                    name: ans['name'],
                    rent: int.parse(ans['rent']),
                    uid: ans['uid'],
                    latilong: ans['latilong'],
                  ),
                );
              });
            }
            totalFavoriteHouse.addAll(loadedFavoriteHouses);
            update();
          },
        );
      }

      CommanDialog.hideLoading();
    } on FirebaseException catch (e) {
      CommanDialog.hideLoading();
      print("Error $e");
    } catch (error) {
      CommanDialog.hideLoading();
      print("error $error");
    }
  }

  void getReportedTenant() async {
    totalReportedTenants = [];
    try {
      CommanDialog.showLoading();
      final List<ReportedModel> loadedReportedTenant = [];
      var response = await firebaseInstance
          .collection('reports')
          .doc('reporting')
          .collection('tenant')
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) async {
            var res = await firebaseInstance
                .collection('users')
                .where('uid', isEqualTo: result['reportedTenant'])
                .get();
            if (res.docs.isNotEmpty) {
              res.docs.forEach((ans) {
                print(ans.data());
                print("Product ID  ${ans.id}");
                loadedReportedTenant.add(
                  ReportedModel(
                      email: ans['email'],
                      name: ans['name'],
                      phone: ans['phone'],
                      uid: ans['uid'],
                      userType: ans['userType']),
                );
              });
            }
            totalReportedTenants.addAll(loadedReportedTenant);
            update();
          },
        );
      }
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

  void getReportedLandlord() async {
    totalReportedLandlords = [];
    try {
      CommanDialog.showLoading();
      final List<ReportedModel> loadedReportedLandlords = [];
      var response = await firebaseInstance
          .collection('reports')
          .doc('reporting')
          .collection('landlord')
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) async {
            var res = await firebaseInstance
                .collection('users')
                .where('uid', isEqualTo: result['reportedLandlord'])
                .get();
            if (res.docs.isNotEmpty) {
              res.docs.forEach((ans) {
                print(ans.data());
                print("Product ID  ${ans.id}");
                loadedReportedLandlords.add(
                  ReportedModel(
                      email: ans['email'],
                      name: ans['name'],
                      phone: ans['phone'],
                      uid: ans['uid'],
                      userType: ans['userType']),
                );
              });
            }
            totalReportedLandlords.addAll(loadedReportedLandlords);
            update();
          },
        );
      }
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

  void getPhoneNum(String uid) async {
    var response = await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: uid)
        .get();
    String phone = '';
    if (response.docs.isNotEmpty) {
      response.docs.forEach((result) {
        phone = result['phone'];
      });
    }
    authController.launchCaller(phone);
  }

  void getReportedLandlordbyTenant() async {
    totalReportedLandlordbyTenant = [];
    try {
      CommanDialog.showLoading();
      final List<ReportedModel> loadedReportedLandlordbyTenant = [];
      var response = await firebaseInstance
          .collection('reports')
          .doc('reporting')
          .collection('landlord')
          .where('reportedBy', isEqualTo: authController.userId)
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) async {
            var res = await firebaseInstance
                .collection('users')
                .where('uid', isEqualTo: result['reportedLandlord'])
                .get();
            if (res.docs.isNotEmpty) {
              res.docs.forEach((ans) {
                print(ans.data());
                print("Product ID  ${ans.id}");
                loadedReportedLandlordbyTenant.add(
                  ReportedModel(
                      email: ans['email'],
                      name: ans['name'],
                      phone: ans['phone'],
                      uid: ans['uid'],
                      userType: ans['userType']),
                );
              });
            }
            totalReportedLandlordbyTenant.addAll(loadedReportedLandlordbyTenant);
            update();
          },
        );
      }
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

  void getReportedTenantbyLandlord() async {
    totalReportedTenantbyLandlord = [];
    try {
      CommanDialog.showLoading();
      final List<ReportedModel> loadedReportedTenantbyLandlord = [];
      var response = await firebaseInstance
          .collection('reports')
          .doc('reporting')
          .collection('tenant')
          .where('reportedBy', isEqualTo: authController.userId)
          .get();
      if (response.docs.length > 0) {
        response.docs.forEach(
          (result) async {
            var res = await firebaseInstance
                .collection('users')
                .where('uid', isEqualTo: result['reportedTenant'])
                .get();
            if (res.docs.isNotEmpty) {
              res.docs.forEach((ans) {
                print(ans.data());
                print("Product ID  ${ans.id}");
                loadedReportedTenantbyLandlord.add(
                  ReportedModel(
                      email: ans['email'],
                      name: ans['name'],
                      phone: ans['phone'],
                      uid: ans['uid'],
                      userType: ans['userType']),
                );
              });
            }
            totalReportedTenantbyLandlord.addAll(loadedReportedTenantbyLandlord);
            update();
          },
        );
      }
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
