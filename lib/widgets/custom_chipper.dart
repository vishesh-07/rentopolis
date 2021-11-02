import 'package:flutter/material.dart';
import 'package:rentopolis/config/configuration.dart';

class CustomChipper extends StatelessWidget {
  const CustomChipper(
      {Key? key, required Size size, required icon, required String text})
      : _size = size,
        icon = icon,
        text = text,
        super(key: key);

  final Size _size;
  final  icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chip(
        elevation: 8.0,
        padding: EdgeInsets.all(2.0),
        avatar: CircleAvatar(backgroundColor: transparent, child: icon),
        label: Text(
          text,
          style: mainFont(fontSize: 15, fontWeight: FontWeight.bold, color: grey),
        ),
        backgroundColor: primaryWhite,
        shape: StadiumBorder(
            side: BorderSide(
          width: _size.width * .005,
          color: teal,
        )),
      ),
    );
  }
}