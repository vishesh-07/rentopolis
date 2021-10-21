import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';

class LoginSignUpService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void signUpUser(String name, String email, String password, String phone,
      String userType) {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore.instance
            .collection((userType == 'Tenant') ? 'TenantDB' : 'LandlordDB')
            .doc(value.user?.uid)
            .set({'name': name, 'email': email, 'phone': phone});
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: grey,
          colorText: primaryWhite);
    }
  }
}
