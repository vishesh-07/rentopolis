import 'package:cached_network_image/cached_network_image.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/controllers/data_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/landlord/landlord_drawer.dart';
import 'package:rentopolis/screens/landlord/landlord_home_details.dart';
import 'package:rentopolis/screens/landlord/landlord_upload_home.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:rentopolis/widgets/custom_chipper.dart';
import 'package:rentopolis/widgets/house_row_rent.dart';
import 'package:svg_icon/svg_icon.dart';

class LandlordHome extends StatelessWidget {
  const LandlordHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Press back again to Exit'),
        ),
        child: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : ZoomDrawer(
                  style: DrawerStyle.Style2,
                  mainScreen: LandlordHomeScreen(),
                  menuScreen: LandlordDrawerScreen(),
                  showShadow: true,
                ),
        ),
      ),
    );
  }
}

class LandlordHomeScreen extends StatelessWidget {
  LandlordHomeScreen({Key? key}) : super(key: key);
  final DataController dataController = Get.put(DataController());
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      dataController.getUplodedHousesbyLandlord();
    });
    var _size = MediaQuery.of(context).size;
    return Container(
      height: _size.height,
      width: _size.width,
      color: primaryWhite,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          height: _size.height * .01,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    ZoomDrawer.of(context)!.toggle();
                  },
                  icon: SvgIcon('assets/icons/menu.svg')),
              IconButton(
                  onPressed: () {
                    Get.offAll(LandlordHome());
                  },
                  icon: Icon(Icons.refresh)),
              IconButton(
                  onPressed: () {
                    Get.to(LandlordUploadHome());
                  },
                  icon: Icon(Icons.add)),
            ],
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0),
              child: Text('Hello ${authController.userData['name']}',
                  style: mainFont(fontSize: 20, color: primaryBlack)),
            )),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 4.0),
            child: Text(
              'Your Homes',
              style: mainFont(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        GetBuilder<DataController>(
          builder: (controller) => controller.totalData.isEmpty
              ? Center(
                  child: Text('😔 NO DATA FOUND PLEASE ADD DATA 😔'),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: dataController.totalData.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          HouseContainer(
                              size: _size,
                              images: dataController.totalData[index].images,
                              name: dataController.totalData[index].name,
                              rent: dataController.totalData[index].rent
                                  .toString(),
                              bedroom: dataController.totalData[index].bedroom
                                  .toString(),
                              bathroom: dataController.totalData[index].bathroom
                                  .toString(),
                              sqft: dataController.totalData[index].area
                                  .toString(),
                              about: dataController.totalData[index].about,
                              address: dataController.totalData[index].address,
                              houseid: dataController.totalData[index].houseid,
                              uid: dataController.totalData[index].uid),
                        ]);
                      }),
                ),
        ),
      ]),
    );
  }
}

class HouseContainer extends StatelessWidget {
  const HouseContainer(
      {Key? key,
      required Size size,
      required List images,
      required String name,
      required String rent,
      required String bedroom,
      required String bathroom,
      required String sqft,
      required String about,
      required String address,
      required int houseid,
      required String uid})
      : _size = size,
        _images = images,
        _name = name,
        _rent = rent,
        _bedroom = bedroom,
        _bathroom = bathroom,
        _sqft = sqft,
        _about = about,
        _address = address,
        _houseid = houseid,
        _uid = uid,
        super(key: key);

  final Size _size;
  final List _images;
  final String _name, _rent, _bedroom, _bathroom, _sqft, _about, _address, _uid;
  final int _houseid;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: primaryWhite,
            borderRadius: BorderRadius.circular(20.0),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(color: grey, blurRadius: 2.0, offset: Offset(2.0, 2.0))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0)),
              child: CachedNetworkImage(
                imageUrl: _images[0],
                height: _size.height * .4,
                width: double.infinity,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            HouseRowRent(
              name: _name,
              rent: _rent,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomChipper(
                  size: _size,
                  icon: const Icon(
                    Icons.bed,
                    size: 20,
                    color: teal,
                  ),
                  text: _bedroom,
                ),
                CustomChipper(
                  size: _size,
                  icon: const Icon(
                    Icons.bathtub,
                    size: 20,
                    color: teal,
                  ),
                  text: _bathroom,
                ),
                CustomChipper(
                  size: _size,
                  icon: const Icon(
                    Icons.height,
                    size: 20,
                    color: teal,
                  ),
                  text: _sqft,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(const LandlordHomeDetails(), arguments: [
                    _about, //0
                    _address, //1
                    _sqft, //2
                    _bathroom, //3
                    _bedroom, //4
                    _houseid, //5
                    _images, //6
                    _name, //7
                    _rent, //8
                    _uid //9
                  ]);
                },
                child: Text('View the house'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
