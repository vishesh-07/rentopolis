import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/controllers/data_controller.dart';
import 'package:rentopolis/controllers/internet_controller.dart';
import 'package:rentopolis/screens/landlord/tenant_verification.dart';
import 'package:rentopolis/screens/no_internet/no_internet.dart';

class ViewAppliedTenants extends StatelessWidget {
  const ViewAppliedTenants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final InternetController _internetController =
        Get.put(InternetController());
    return Scaffold(
      // body: Obx(()=>_internetController.current==_internetController.noInternet?NoInternet():LoginScreen()),
      body: GetBuilder<InternetController>(
          builder: (builder) => (_internetController.connectionType == 0.obs)
              ? const NoInternet()
              : ViewAppliedTenantsScreen()),
    );
  }
}

class ViewAppliedTenantsScreen extends StatelessWidget {
  ViewAppliedTenantsScreen({Key? key}) : super(key: key);
  final DataController dataController = Get.put(DataController());
  @override
  Widget build(BuildContext context) {
    var _args = Get.arguments;
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      dataController.getAppliedTenants(_args[0]);
    });
    var _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: _size.height * .05,
        ),
        Center(
          child: Text(
            'Interested Tenants',
            style: mainFont(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        GetBuilder<DataController>(
          builder: (controller) => controller.totalAppliedTenants.isEmpty
              ? Center(
                  child: Text('😔 NO TENANTS FOUND😔'),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: dataController.totalAppliedTenants.length,
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
                                                  .totalAppliedTenants[index]
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
                                                  .totalAppliedTenants[index]
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
                                                  .totalAppliedTenants[index]
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
                                        Get.to(TenantVerification(),
                                            arguments: [
                                              dataController.totalAppliedTenants[index].name, //0
                                              dataController.totalAppliedTenants[index].phone, //1
                                              dataController.totalAppliedTenants[index].email, //2
                                              dataController.totalAppliedTenants[index].aadharFront, //3
                                              dataController.totalAppliedTenants[index].aadharBack, //4
                                              dataController.totalAppliedTenants[index].appliedBy, //5
                                              _args[0],//houseId //6
                                              _args[1]//uid  //7
                                            ]);
                                      },
                                      child: Center(
                                        child: Text(
                                          'Rent The House',
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
                                  )
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
