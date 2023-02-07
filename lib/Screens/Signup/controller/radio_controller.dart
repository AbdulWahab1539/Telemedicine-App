import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RadioController extends GetxController {
  var id = 1.obs;

  updateAccountType(int selection) {
    id = selection.obs;
    update();
  }
}
