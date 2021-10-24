import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:rentopolis/widgets/custom_chipper.dart';
import 'package:rentopolis/widgets/house_row_rent.dart';

class TenantHomeDetails extends StatelessWidget {
  const TenantHomeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : TenantHomeDetailsScreen()),
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
  const TenantHomeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: _size.height * .4,
            viewportFraction: 1,
          ),
          items: imgList
              .map((item) => Center(
                      child: Image.network(
                    item,
                  )))
              .toList(),
        ),
        Container(
          child: Column(
            children: [
              HouseRowRent(
                name: 'Luxury House',
                rent: '20000',
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Bypass Rd Behind, Square, Malwa County',
                    style: mainFont(fontSize: 15, color: grey),
                  ),
                ),
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
                    text: '3',
                  ),
                  CustomChipper(
                    size: _size,
                    icon: const Icon(
                      Icons.bathtub,
                      size: 20,
                      color: teal,
                    ),
                    text: '2',
                  ),
                  CustomChipper(
                    size: _size,
                    icon: const Icon(
                      Icons.height,
                      size: 20,
                      color: teal,
                    ),
                    text: '1200 sqft',
                  ),
                ],
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
                child: Text(
                    'A house is a single-unit residential building, which may range in complexity from a rudimentary hut to a complex structure of wood, masonry, concrete or other material, outfitted with plumbing, electrical, and heating, ventilation, and air conditioning systems.'),
              ),
              
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
                        onPressed: () {},
                        child: Text('Rent'),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}