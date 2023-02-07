import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';
import 'package:lottie/lottie.dart';

class ActionCard extends StatelessWidget {
  final String title;
  final String anim;
  final VoidCallback voidCallback;
  double width;
  double height;

  ActionCard(
      {Key? key,
      this.width = 120,
      this.height = 120,
      required this.title,
      required this.anim,
      required this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: voidCallback,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Lottie.asset('assets/animations/$anim.json',
                  height: height, width: width),
              Text(title, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
