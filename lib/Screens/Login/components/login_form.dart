import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../components/already_have_account.dart';
import '../../../constants.dart';
import '../../../utils/utils_widgets.dart';
import '../../Signup/signup_screen.dart';
import 'package:flutter_auth/constants.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final Map<String, dynamic> formData = {
      'name': null,
      'email': null,
    };

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {
              formData['email'] = email;
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email cannot be empty';
              }
              if (!GetUtils.isEmail(value.toString())) {
                return 'Email is incorrect';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              onSaved: (password) {
                formData['password'] = password;
              },
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'Incorrect Password!!';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState == null) return;
                if (_formKey.currentState!.validate()) {
                  debugPrint("Form is Validated");
                  _formKey.currentState!.save();
                  Get.defaultDialog(
                      title: '', content: loading(), barrierDismissible: false);
                  authController
                      .login(formData['email'], formData['password'])
                      .then((value) {
                    Get.back();
                  }).catchError((onError) {
                    print(onError.toString());
                    Get.back();
                  });
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
