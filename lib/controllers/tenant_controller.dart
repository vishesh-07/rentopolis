import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/controllers/common_dialog.dart';
import 'package:path/path.dart' as Path;
import 'package:rentopolis/screens/tenant/tenant_home.dart';

class TenantController extends GetxController {
  @override
  void onInit() {
    _image.value = [];
    super.onInit();
  }

  @override
  void onClose() {
    _image.value = [];
    super.onClose();
  }

  var path;
  ImagePicker picker = ImagePicker();
  AuthController authController = Get.put(AuthController());
  RxList _image = [].obs;
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

  Future<void> upload(String landlordUid, String houseId) async {
    try {
      CommanDialog.showLoading();
      List imagedownloadurl = [];
      var response = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: authController.userId)
          .get();
      if (response.docs.length > 0) {
        for (var img in _image) {
          var ref = firebase_storage.FirebaseStorage.instance.ref().child(
              'images/$landlordUid/$houseId/applied/${authController.userId}/${Path.basename(img.path)}');
          await ref.putFile(img).whenComplete(() async {
            await ref.getDownloadURL().then((value) async {
              imagedownloadurl.add(value);
            });
          });
        }
        FirebaseFirestore.instance
            .collection('houses')
            .doc(houseId)
            .collection('applied')
            .doc()
            .set({
          'name': response.docs[0]['name'],
          'phone': response.docs[0]['phone'],
          'email': response.docs[0]['email'],
          'aadharFront': imagedownloadurl[0],
          'aadharBack': imagedownloadurl[1],
          'appliedBy': response.docs[0]['uid']
        });

        CommanDialog.hideLoading();
        Get.back();
      } else {
        print('shfksaf jdjjdjd 1111 3333 33213');
      }
    } catch (e) {
      CommanDialog.showErrorDialog(description: '$e');
    }

    CommanDialog.hideLoading();
  }
}
