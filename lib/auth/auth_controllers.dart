import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Screens/Welcome/components/welcome_image.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_auth/dashboard/doctor_dashboard.dart';
import 'package:flutter_auth/dashboard/patient_dashboard.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/repo/user_db.dart';
import 'package:get/get.dart';
import 'package:flutter_auth/constants.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  late Rx<CustomerUser?> user;

  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there

    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => const WelcomeScreen());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      print('_setInitialScreen: ${user.uid.toString()}');
      UserDb.getUser(user.uid).then((value) {
        this.user = value.obs;
        debugPrint(user.uid.toString());
        print(auth.currentUser);
        if (this.user.value == null) const WelcomeScreen();
        this.user.value?.accountType == typePatient
            ? Get.offAll(() => const PatientDashboard())
            : Get.offAll(() => const DoctorDashboard());
      }).catchError((onError) {
        print('Auth Controller: ${onError.toString()}');
      });
    }
  }

  Future<bool> register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return true;
    } catch (firebaseAuthException) {
      debugPrint(firebaseAuthException.toString());
      // Get.showSnackbar(const GetSnackBar(
      //   title: 'Error',
      // ));
      return false;
    }
  }

  Future<void> login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (firebaseAuthException) {
      print(firebaseAuthException.toString());
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
