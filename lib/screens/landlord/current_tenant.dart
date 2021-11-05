import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/data_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';

class CurrentTenant extends StatelessWidget {
  const CurrentTenant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : CurrentTenantScreen()),
    );
  }
}

class CurrentTenantScreen extends StatelessWidget {
  const CurrentTenantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DataController dataController = Get.put(DataController());
    var _args = Get.arguments;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      dataController.getCurrentTenant(_args[0]);
    });
    var _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: _size.height * .05,
        ),
        Center(
          child: Text(
            'Current Tenant',
            style: mainFont(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        GetBuilder<DataController>(
          builder: (controller) => controller.currentTenant.isEmpty
              ? Center(
                  child: Text('😔 NO TENANTS FOUND😔'),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      color: teal,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Table(
                            children: [
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Name',
                                      style: mainFont(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: primaryWhite),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${dataController.currentTenant[0].name}',
                                      style: mainFont(
                                          fontSize: 15, color: primaryWhite),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Email',
                                      style: mainFont(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: primaryWhite),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${dataController.currentTenant[0].email}',
                                      style: mainFont(
                                          fontSize: 15, color: primaryWhite),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Phone',
                                      style: mainFont(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: primaryWhite),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${dataController.currentTenant[0].phone}',
                                      style: mainFont(
                                          fontSize: 15, color: primaryWhite),
                                    ),
                                  ),
                                ],
                              ),
                              TableRow(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Rent Date',
                                    style: mainFont(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: primaryWhite),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${dataController.currentTenant[0].rentDate}',
                                    style: mainFont(
                                        fontSize: 15, color: primaryWhite),
                                  ),
                                ),
                              ]),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Aadhar Front Side',
                              style: mainFont(
                                  fontSize: 20,
                                  color: primaryWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${dataController.currentTenant[0].aadharFront}',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Aadhar Back Side',
                              style: mainFont(
                                  fontSize: 20,
                                  color: primaryWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${dataController.currentTenant[0].aadharBack}',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Tenant Verification Certificate',
                              style: mainFont(
                                  fontSize: 20,
                                  color: primaryWhite,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${dataController.currentTenant[0].tenantCertificate}',
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
