import 'package:flutter/material.dart';
import 'package:rentopolis/config/configuration.dart';

class HouseRowRent extends StatelessWidget {
  const HouseRowRent({
    Key? key,required String name,required String rent
  }) : name=name,rent=rent,super(key: key);
  final String name;
  final String rent;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Luxary Appartment',
            style: mainFont(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: darkGrey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '\u{20B9} 12000',
            style: mainFont(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}