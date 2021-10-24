import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:rentopolis/screens/tenant/tenant_home_details.dart';
import 'package:rentopolis/widgets/custom_chipper.dart';
import 'package:rentopolis/widgets/house_row_rent.dart';
import 'package:svg_icon/svg_icon.dart';

class TenantHome extends StatelessWidget {
  const TenantHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : TenantHomeScreen()),
    );
  }
}

class TenantHomeScreen extends StatelessWidget {
  const TenantHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: _size.height * .01,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {}, icon: SvgIcon('assets/icons/menu.svg')),
                IconButton(onPressed: () {}, icon: Icon(Icons.sort_sharp)),
              ],
            ),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                child: Text('Hello User',
                    style: mainFont(fontSize: 20, color: primaryBlack)),
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 4.0),
              child: Text(
                'Find your sweet home',
                style: mainFont(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FilterChip(
                  size: _size,
                  text: '2 Bedrooms',
                ),
                FilterChip(
                  size: _size,
                  text: 'Independent House',
                ),
                FilterChip(
                  size: _size,
                  text: 'Full Furnished',
                ),
                FilterChip(
                  size: _size,
                  text: 'Under 15000',
                ),
                FilterChip(
                  size: _size,
                  text: 'Near Hospital',
                ),
              ],
            ),
          ),
          Column(
            children: [
              //! 1st house
              HouseContainer(size: _size),
              HouseContainer(size: _size),
              HouseContainer(size: _size),
              HouseContainer(size: _size),
              //! 2nd house
            ],
          ),
        ],
      ),
    );
  }
}

class HouseContainer extends StatelessWidget {
  const HouseContainer({
    Key? key,
    required Size size,
  })  : _size = size,
        super(key: key);

  final Size _size;

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
                child: Image.network('https://placeimg.com/640/480/any')),
            HouseRowRent(name: 'Luxury House',rent: '20000',),
            Row(children: <Widget>[
              Icon(
                Icons.location_on,
                color: grey,
              ),
              Text(
                "1.5 km from you",
                style: mainFont(fontSize: 15, color: grey),
              )
            ]),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(TenantHomeDetails());
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



class FilterChip extends StatelessWidget {
  const FilterChip({Key? key, required Size size, required String text})
      : _size = size,
        text = text,
        super(key: key);

  final Size _size;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: double.infinity,
          minHeight: _size.height * .04,
          minWidth: _size.width * .22,
          maxWidth: double.infinity,
        ),
        child: Center(
            child: Text(
          text,
          style: mainFont(
              fontSize: 12, fontWeight: FontWeight.bold, color: darkGrey),
        )),
        decoration: BoxDecoration(
            color: filterGrey,
            borderRadius: BorderRadius.circular(5.0),
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              BoxShadow(color: grey, blurRadius: 2.0, offset: Offset(2.0, 2.0))
            ]),
      ),
    );
  }
}
