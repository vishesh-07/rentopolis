import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentopolis/config/configuration.dart';

class TextWithBack extends StatelessWidget {
  const TextWithBack({
    Key? key,
    required this.text,
    required Size size,
  }) : _size = size, super(key: key);

  final String text;
  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
          color: teal,
        ),
        Text(
          text,
          style: mainFont(fontSize: 25,fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: _size.width * .1,
        )
      ],
    );
  }
}
