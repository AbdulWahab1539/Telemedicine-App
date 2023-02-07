import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/signup_form.dart';
import 'package:flutter_auth/Screens/profile/profile_form.dart';
import 'package:flutter_auth/auth/reset_password.dart';
import 'package:flutter_auth/components/background.dart';
import 'package:flutter_auth/responsive.dart';
import 'package:flutter_auth/utils/utils_widgets.dart';

import '../../constants.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: ProfileMobile(),
          desktop: Placeholder(),
        ),
      ),
    );
  }
}

class ProfileMobile extends StatelessWidget {
  const ProfileMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        headingText('Profile'),
        const Text('Consider updating your profile for better'),
        const SizedBox(height: defaultPadding),
        Container(margin: const EdgeInsets.all(defaultPadding), child: const ProfileForm()),
      ],
    );
  }
}
