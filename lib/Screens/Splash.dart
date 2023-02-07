import 'package:flutter/material.dart';
import 'package:flutter_auth/utils/utils_widgets.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
        headingText('Telemedicine App'),
        Lottie.asset('assets/animations/loading.json', height: 200, width: 200),
      ]),
    );
  }
}
