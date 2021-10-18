import 'package:get/get.dart';

class RadioButtonController extends GetxController {
  var userType = ['Tenant', 'Landlord'].obs;
  var selectedIndex = 0.obs;
  @override
  void onInit() {
    selectedIndex = 0.obs;
    update();
    super.onInit();
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
    update();
  }

  @override
  void onClose() {
    selectedIndex = 0.obs;
    update();
    super.onClose();
  }
}
