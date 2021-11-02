import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/data_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
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

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class TenantHomeDetailsScreen extends StatelessWidget {
  TenantHomeDetailsScreen({Key? key}) : super(key: key);
  var _args = Get.arguments;
  DataController dataController = Get.put(DataController());
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
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_outline),
                        label: Text('Add to Favourites')),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: _size.height * .3,
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
                      width: _size.width * .4,
                      height: _size.height * .07,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Chat'),
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
                          Get.to(TenantRentForm(), arguments: [
                            _args[5],//houseId
                            _args[9]//uid
                          ]);
                        },
                        child: Text('Rent'),
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
