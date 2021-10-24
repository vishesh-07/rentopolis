import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rxn<User> _firebaseUser = Rxn<User>();

  @override
  void onInit() {
    _firebaseUser.bindStream(_auth.authStateChanges());
  }

  void signUpUser(String name, String email, String password, String phone,
      String userType) {
    try {
      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(value.user?.uid)
            .set({
          'name': name,
          'email': email,
          'phone': phone,
          'uid': value.user?.uid,
          'userType': userType
        });
      });
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: grey,
          colorText: primaryWhite);
    }
  }

  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user?.uid;
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: grey,
          colorText: primaryWhite);
    }
  }
}
