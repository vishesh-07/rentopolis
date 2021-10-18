import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:rentopolis/screens/login/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // var _connection=Get.find()
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Get.snackbar('Error', '${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.teal,
            ),
            debugShowCheckedModeBanner: false,
            // home: const NoInternet(),
            home: InternetCheck(),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class InternetCheck extends StatelessWidget {
  InternetCheck({Key? key}) : super(key: key);
  final InternetController _internetController = Get.put(InternetController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? NoInternet()
              : LoginScreen()),
      // body: GetX<InternetController>(
      //   builder: (controller){
      //     return  controller.current==controller.noInternet.obs?const NoInternet():const LoginScreen();
      //   },
      // ),
    );
  }
}
// class InternetCheck extends StatefulWidget {
//   const InternetCheck({ Key? key }) : super(key: key);

//   @override
//   _InternetCheckState createState() => _InternetCheckState();
// }

// class _InternetCheckState extends State<InternetCheck> {
//   ConnectivityResult _result=ConnectivityResult.none,_hasConnection=ConnectivityResult.none;

//   @override
//   void initState() {
//     super.initState();
//     Connectivity().onConnectivityChanged.listen((result) {
//       setState(()=>this._result=result);
//      });
//   }
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: _result==_hasConnection?const NoInternet():const LoginScreen(),
//     );
//   }
// }
