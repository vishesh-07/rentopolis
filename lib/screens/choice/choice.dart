import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';
import 'package:rentopolis/screens/login/landlord_login.dart';
import 'package:rentopolis/screens/login/tenant_login.dart';

class Choice extends StatelessWidget {
  const Choice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    // var x='s'
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ChoiceButton(size: _size, text: 'Tenant'),
          ChoiceButton(size: _size, text: 'Landlord'),
          ChoiceButton(size: _size, text: 'Admin'),
        ],
      ),
    );
  }
}

class ChoiceButton extends StatelessWidget {
  const ChoiceButton({
    Key? key,
    required Size size,
    required this.text,
  })  : _size = size,
        super(key: key);

  final Size _size;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
          width: _size.width * .8,
          height: _size.height * .07,
          child: ElevatedButton(
              onPressed: () {
                if(text=='Tenant'){
                  Get.to(TenantLogin());
                }else if(text=='Landlord'){
                  Get.to(LandlordLogin());
                }
              },
              child: Text(
                text,
                style: mainFont(fontSize: 15, color: primaryWhite),
              ))),
    );
  }
}
