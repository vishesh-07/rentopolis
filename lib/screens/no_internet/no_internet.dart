import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Lottie.asset('assets/gif/no_internet.json')
    );
  }
}
