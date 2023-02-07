import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../utils/utils_widgets.dart';

class Background extends StatelessWidget {
  final Widget child;
  bool isDashboard;

  Background({
    Key? key,
    this.isDashboard = false,
    required this.child,
    this.topImage = "assets/images/main_top.png",
    this.bottomImage = "assets/images/login_bottom.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                topImage,
                width: 120,
              ),
            ),
            isDashboard
                ? Positioned(
                    right: 20,
                    top: 50,
                    child: InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: '',
                            content: loading(),
                            barrierDismissible: false);
                        authController.signOut().then((value) {
                          Get.back();
                        }).catchError((error) {
                          print(error);
                          Get.back();
                        });
                      },
                      child: IgnorePointer(
                        child: Card(
                          elevation: 10.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Column(
                              children: const [
                                Icon(Icons.logout),
                                // Text('Logout', style: TextStyle(fontSize: 10),),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
            // Positioned(
            //   bottom: 0,
            //   right: 0,
            //   child: Image.asset(bottomImage, width: 120),
            // ),
            SafeArea(child: child),
          ],
        ),
      ),
    );
  }
}
