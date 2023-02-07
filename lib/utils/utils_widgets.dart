import 'package:flutter/material.dart';
import 'package:flutter_auth/constants.dart';

Widget loading() {
  return Column(
    children: const [
      CircularProgressIndicator.adaptive(),
      SizedBox(
        height: defaultPadding / 2,
      ),
      Text('Please Wait'),
    ],
  );
}

Widget headingText(String title) {
  return Text(
    title,
    style: const TextStyle(
        color: kPrimaryColor, fontSize: 25, fontFamily: 'LobsterTwo'),
  );
}
