import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/controllers/data_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/controllers/tenant_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rentopolis/screens/tenant/tenant_rent_form.dart';
import 'package:rentopolis/widgets/custom_chipper.dart';
import 'package:rentopolis/widgets/house_row_rent.dart';

class TenantHomeDetails extends StatelessWidget {
  const TenantHomeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    var x = 0;
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : (TenantHomeDetailsScreen())),
    );
  }
}

class TenantHomeDetailsScreen extends StatelessWidget {
  TenantHomeDetailsScreen({Key? key}) : super(key: key);
  final _args = Get.arguments;
  DataController dataController = Get.put(DataController());
  TenantController tenantController = Get.put(TenantController());
  AuthController authController = Get.put(AuthController());
  @override
  // void initState() {
  //   tenantController.isFavourite(authController.userId, _args[5]);
  // }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              height: _size.height * .4,
              viewportFraction: 1,
            ),
            items: _args[6]
                .map<Widget>(
                  (item) => Center(
                    child: CachedNetworkImage(
                      imageUrl: item,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                )
                .toList(),
          ),
          Column(
            children: [
              HouseRowRent(
                name: _args[7],
                rent: _args[8],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _args[1],
                    style: mainFont(fontSize: 15, color: grey),
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomChipper(
                      size: _size,
                      icon: const Icon(
                        Icons.bed,
                        size: 20,
                        color: teal,
                      ),
                      text: _args[4],
                    ),
                    CustomChipper(
                        size: _size,
                        icon: const Icon(
                          Icons.bathtub,
                          size: 20,
                          color: teal,
                        ),
                        text: _args[3]),
                    CustomChipper(
                      size: _size,
                      icon: const Icon(
                        Icons.height,
                        size: 20,
                        color: teal,
                      ),
                      text: '${_args[2]} sqft',
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'About',
                    style: mainFont(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryBlack),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(_args[0]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'House Id: ${_args[5]}',
                      style: mainFont(fontSize: 15),
                    ),
                  ),
                  //           var response = await FirebaseFirestore.instance
                  // .collection('favorites')
                  // .where('uid', isEqualTo: uid)
                  // .where('houseId', isEqualTo: houseId)
                  // .get();
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('favorites')
                        .where('uid', isEqualTo: authController.userId)
                        .where('houseId', isEqualTo: _args[5])
                        .snapshots(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null) {
                        return const Text("");
                      }
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: transparent,
                          child: IconButton(
                            onPressed: () => snapshot.data.docs.length == 0
                                ? tenantController.addToFavourite(
                                    authController.userId, _args[5])
                                : tenantController.removeFromFavourite(
                                    authController.userId, _args[5]),
                            icon: snapshot.data.docs.length == 0
                                ? const Icon(
                                    Icons.favorite_outline,
                                    color: Colors.red,
                                  )
                                : const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: _size.height * .2,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20)),
                  child: GoogleMap(
                    onMapCreated: dataController.onMapCreated(
                        _args[10][0], _args[10][1], _args[7], _args[1]),
                    markers: dataController.markers,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(_args[10][0], _args[10][1]),
                      zoom: 20,
                    ),
                  ),
                ),
              ),
              // Text(_args[10][0].toString()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: _size.width * .2,
                      height: _size.height * .07,
                      child: ElevatedButton(
                        onPressed: () {
                          dataController.getPhoneNum(_args[9]);
                        },
                        child: const Text('Call'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: _size.width * .2,
                      height: _size.height * .07,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.to(const TenantRentForm(), arguments: [
                            _args[5], //houseId
                            _args[9] //uid
                          ]);
                        },
                        child: const Text('Rent'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: _size.width * .4,
                      height: _size.height * .07,
                      child: ElevatedButton(
                        onPressed: () {
                          tenantController.reportLandlord(_args[9]);
                        },
                        child: const Text('Report Landlord'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
