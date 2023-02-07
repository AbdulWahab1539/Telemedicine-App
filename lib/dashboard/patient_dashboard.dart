import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/profile/Profile.dart';
import 'package:flutter_auth/components/background.dart';
import 'package:flutter_auth/constants.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../components/action_card.dart';
import '../utils/utils_widgets.dart';

class PatientDashboard extends StatelessWidget {
  const PatientDashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      isDashboard: true,
      child: const SingleChildScrollView(
        child: Responsive(
          mobile: MobilePatientDash(),
          desktop: Text(typePatient),
        ),
      ),
    );
  }
}

class MobilePatientDash extends StatelessWidget {
  const MobilePatientDash({Key? key}) : super(key: key);

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
                title: 'Search Doctor', anim: 'search_dr', voidCallback: () {}),
            const SizedBox(
              width: defaultPadding / 2,
            ),
            ActionCard(
                title: 'View Appointments',
                anim: 'appointment',
                voidCallback: () {}),
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
