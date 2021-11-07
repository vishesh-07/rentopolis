import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/auth_controller.dart';
import 'package:rentopolis/controllers/data_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';
import 'package:rentopolis/widgets/text_with_back.dart';

class ReportedTenant extends StatelessWidget {
  const ReportedTenant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : ReportedTenantScreen()),
    );
  }
}

class ReportedTenantScreen extends StatelessWidget {
  ReportedTenantScreen({Key? key}) : super(key: key);
  final DataController dataController = Get.put(DataController());
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      dataController.getReportedTenant();
    });
    var _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: _size.height * .05,
        ),
        TextWithBack(text: 'Reported Tenants', size: _size),
        GetBuilder<DataController>(
          builder: (controller) => controller.totalReportedTenants.isEmpty
              ? Center(
                  child: Text('😔 NO TENANTS FOUND😔'),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: dataController.totalReportedTenants.length,
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
                                                  .totalReportedTenants[index]
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
                                                  .totalReportedTenants[index]
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
                                                  .totalReportedTenants[index]
                                                  .phone,
                                              style: mainFont(
                                                  fontSize: 15,
                                                  color: primaryWhite)),
                                        )
                                      ]),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        authController.launchCaller(
                                            dataController
                                                .totalReportedTenants[index]
                                                .phone);
                                      },
                                      child: Center(
                                        child: Text(
                                          'Call Tenant',
                                          style: mainFont(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          primary: primaryWhite,
                                          elevation: 10,
                                          minimumSize: Size(double.infinity,
                                              _size.height * .05)),
                                    ),
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
