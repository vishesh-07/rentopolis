import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:rentopolis/controllers/common_dialog.dart';
import 'package:rentopolis/controllers/data_controller.dart';
import 'package:rentopolis/main.dart';
import 'package:rentopolis/screens/admin/admin_home.dart';
import 'package:rentopolis/screens/landlord/landlord_home.dart';
import 'package:rentopolis/screens/login/login.dart';
import 'package:rentopolis/screens/tenant/tenant_home.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthController extends GetxController {
  var userId;
  final firebaseInstance = FirebaseFirestore.instance;
  // DataController dataController=Get.put(DataController());
  // DataController dataController=DataController();

  Future<void> signUp(email, password, name, phone, userType) async {
    try {
      CommanDialog.showLoading();
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password);
      print(userCredential);
      CommanDialog.hideLoading();
      try {
        CommanDialog.showLoading();
        var response = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': name,
          'email': email,
          'phone': phone,
          'uid': userCredential.user!.uid,
          'userType': userType
        });
        CommanDialog.hideLoading();
        Get.offAll(const Login());
      } catch (exception) {
        CommanDialog.hideLoading();
        print("Error Saving Data at firestore $exception");
      }
      // var response = await FirebaseFirestore.instance.collection('users').add({
      //   'name': name,
      //   'email': email,
      //   'phone': phone,
      //   'uid': userCredential.user!.uid,
      //   'userType': userType
      // });
      // CommanDialog.hideLoading();
      // Get.offAll(InternetCheck());
    } on FirebaseAuthException catch (e) {
      CommanDialog.hideLoading();
      if (e.code == 'weak-password') {
        CommanDialog.showErrorDialog(
            description: 'The password provided is too weak.');
        Get.back();
        // print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CommanDialog.showErrorDialog(
            description: 'The account already exists for that email.');
        Get.back();
        // print('The account already exists for that email.');
      }
    } catch (e) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog(description: '$e');
      // print(e);
    }
  }

  Map userData = {
    'email': '',
    'name': '',
    'phone': '',
    'uid': '',
    'userType': ''
  };
  Future<void> getUserData() async {
    // print("user id ${authController.userId}");
    try {
      var response = await firebaseInstance
          .collection('users')
          .where('uid', isEqualTo: userId)
          .get();

      if (response.docs.length > 0) {
        userData['email'] = response.docs[0]['email'];
        userData['name'] = response.docs[0]['name'];
        userData['phone'] = response.docs[0]['phone'];
        userData['uid'] = response.docs[0]['uid'];
        userData['userType'] = response.docs[0]['userType'];
        if (userData['userType'] == 'Tenant') {
          Get.offAll(const TenantHome());
        } else if (userData['userType'] == 'Landlord') {
          Get.offAll(LandlordHome());
        }
      }
      print(userData);
    } on FirebaseException catch (e) {
      CommanDialog.showErrorDialog(description: '$e');
    } catch (error) {
      CommanDialog.showErrorDialog(description: '$error');
    }
  }

  Future<void> login(email, password) async {
    try {
      if (email == 'rentopolis@gmail.com' && password == 'admin@123') {
        Get.offAll(AdminHome());
      } else {
        CommanDialog.showLoading();
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email.trim(), password: password);

        userId = userCredential.user!.uid;
        getUserData();
        // print(userData['userType']);
        CommanDialog.hideLoading();
      }
    } on FirebaseAuthException catch (e) {
      CommanDialog.hideLoading();
      if (e.code == 'user-not-found') {
        CommanDialog.showErrorDialog(
            description: 'No user found for that email.');

        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        CommanDialog.hideLoading();
        CommanDialog.showErrorDialog(
            description: 'Wrong password provided for that user.');

        // print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(const Login());
    } catch (e) {
      CommanDialog.showErrorDialog(description: '$e');
    }
  }

  Future<void> resetPassword(String email) async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: email)
        .then((value) {
      Get.offAll(const Login());
      CommanDialog.showErrorDialog(
          title: 'Success',
          description: 'Password Reset email link is been sent');
    }).catchError((onError) => CommanDialog.showErrorDialog(
            title: 'Error', description: '${onError.message}'));
  }

  Future<void> changePassword(String newPassword) async {
    try {
      CommanDialog.showLoading();
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      User? currentUser = firebaseAuth.currentUser;
      await currentUser?.updatePassword(newPassword).then((_) {
        Get.back();
        CommanDialog.hideLoading();
      }).catchError((err) {
        CommanDialog.hideLoading();
        CommanDialog.showErrorDialog(description: '$err');
      });
    } catch (e) {
      CommanDialog.hideLoading();
      CommanDialog.showErrorDialog(description: '$e');
    }
  }

  launchCaller(String num) async {
    String url = "tel:+91$num";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      CommanDialog.showErrorDialog(description: "Can't call");
      throw 'Could not launch $url';
    }
  }
}
