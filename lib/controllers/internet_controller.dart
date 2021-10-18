import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class InternetController extends GetxController {
  var connectionType = 0.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;
  @override
  void onInit() {
    GetConnectionType();
     _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
    super.onInit();
  }

  Future<void> GetConnectionType() async {
    var connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      Get.snackbar("Error",'$e');
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType = 1.obs;
        update();
        break;
      case ConnectivityResult.mobile:
        connectionType = 2.obs;
        update();
        break;
      case ConnectivityResult.none:
        connectionType = 0.obs;
        update();
        break;
      default:
        Get.snackbar('Network Error', 'Failed to get Network Status');
        break;
    }
  }

  @override
  void onClose() {
    //stop listening to network state when app is closed
    _streamSubscription.cancel();
  }
}
