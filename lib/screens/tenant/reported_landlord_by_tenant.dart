import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/controllers/data_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:rentopolis/widgets/text_with_back.dart';

class ReportedLandlordByTenant extends StatelessWidget {
  const ReportedLandlordByTenant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : ReportedLandlordByTenantScreen()),
    );
  }
}

class ReportedLandlordByTenantScreen extends StatelessWidget {
  ReportedLandlordByTenantScreen({Key? key}) : super(key: key);
  final DataController dataController = Get.put(DataController());
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      dataController.getReportedLandlordbyTenant();
    });
    var _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: _size.height * .05,
        ),
        TextWithBack(text: 'Reported Landlords', size: _size),
        GetBuilder<DataController>(
          builder: (controller) => controller.totalReportedLandlordbyTenant.isEmpty
              ? Center(
                  child: Text('😔 NO LANDLORDS FOUND😔'),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: dataController.totalReportedLandlordbyTenant.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: teal,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color: grey,
                                        blurRadius: 2.0,
                                        offset: Offset(2.0, 2.0))
                                  ]),
                              child: Column(
                                children: [
                                  Table(
                                    // border: TableBorder.all(),
                                    children: [
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Name',
                                            style: mainFont(
                                                fontSize: 15,
                                                color: primaryWhite,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              dataController
                                                  .totalReportedLandlordbyTenant[
                                                      index]
                                                  .name,
                                              style: mainFont(
                                                  fontSize: 15,
                                                  color: primaryWhite)),
                                        )
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Email',
                                            style: mainFont(
                                                fontSize: 15,
                                                color: primaryWhite,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              dataController
                                                  .totalReportedLandlordbyTenant[
                                                      index]
                                                  .email,
                                              style: mainFont(
                                                  fontSize: 12,
                                                  color: primaryWhite)),
                                        )
                                      ]),
                                      TableRow(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'Phone',
                                            style: mainFont(
                                                fontSize: 15,
                                                color: primaryWhite,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                              dataController
                                                  .totalReportedLandlordbyTenant[
                                                      index]
                                                  .phone,
                                              style: mainFont(
                                                  fontSize: 12,
                                                  color: primaryWhite)),
                                        )
                                      ]),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]);
                      }),
                ),
        ),
      ],
    );
  }
}
