import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/profile/Profile.dart';
import 'package:flutter_auth/components/background.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../components/action_card.dart';
import '../utils/utils_widgets.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      isDashboard: true,
      child: SingleChildScrollView(
        child: Responsive(
          mobile: MobileDoctorDash(),
          desktop: Text(typePatient),
        ),
      ),
    );
  }
}

class MobileDoctorDash extends StatelessWidget {
  const MobileDoctorDash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Lottie.asset('assets/animations/dash.json', fit: BoxFit.fill),
        const SizedBox(height: defaultPadding / 2),
        headingText('Welcome ${authController.user.value?.name}'),
        const SizedBox(height: defaultPadding / 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionCard(
                height: 120,
                width: 120,
                title: 'Pending Appointments',
                anim: 'pending_app',
                voidCallback: () {}),
            const SizedBox(width: defaultPadding / 2),
            ActionCard(
                title: 'View Appointments',
                anim: 'appointment',
                voidCallback: () {})
          ],
        ),
        const SizedBox(height: defaultPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ActionCard(title: 'Profile', anim: 'profile', voidCallback: () => Get.to(const Profile())),
            const SizedBox(width: defaultPadding / 2),
            ActionCard(title: 'History', anim: 'history', voidCallback: () {}),
          ],
        )
      ],
    );
  }
}
