import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/radio_group.dart';
import 'package:flutter_auth/Screens/Signup/controller/radio_controller.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/repo/user_db.dart';
import 'package:get/get.dart';

import '../../../components/already_have_account.dart';
import '../../../constants.dart';
import '../../../utils/utils_widgets.dart';
import '../../Login/login_screen.dart';
import 'package:flutter_auth/constants.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String password = '';
    final Map<String, dynamic> formData = {
      'name': null,
      'email': null,
      'password': null,
      'confirmPassword': null,
      'age': null,
      'accountType': null,
      'experience': null,
      'specialization': null,
      'weight': null,
      'height': null,
      'bloodGroup': null,
    };

    return Form(
      key: _formKey,
      child: Column(
        children: [
          RadioGroup(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              cursorColor: kPrimaryColor,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Full Name cannot be empty';
                }
                return null;
              },
              onSaved: (value) {
                formData['name'] = value;
              },
              decoration: const InputDecoration(
                hintText: "Full Name",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.person),
                ),
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email cannot be empty';
              }
              if (!GetUtils.isEmail(value.toString())) {
                return 'Email is incorrect';
              }
              if (!value.contains('gmail')) {
                return 'Enter valid email i.e. name@gmai.com';
              }
              return null;
            },
            onSaved: (value) {
              formData['email'] = value;
            },
            decoration: const InputDecoration(
              hintText: "name@gmai.com",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.email),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.next,
              obscureText: true,
              cursorColor: kPrimaryColor,
              validator: (value) {
                if (value!.isEmpty || value.length < 6) {
                  return 'Please Enter at least 6 digits Password';
                }
                return null;
              },
              onSaved: (value) {
                formData['password'] = value;
              },
              decoration: const InputDecoration(
                hintText: "Password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            obscureText: true,
            cursorColor: kPrimaryColor,
            onSaved: (value) {
              formData['confirmPassword'] = value;
            },
            onFieldSubmitted: (value) {
              password = value;
            },
            validator: (value) {
              if (value!.isEmpty || value.length < 6) {
                return 'Confirm password should match with password';
              }
              print('${value.toString().trim()} , ${password.trim()}');
              if (value.toString().trim() != password.trim()) {
                return 'Password and Confirm Password do not match';
              }
              return null;
            },
            decoration: const InputDecoration(
              hintText: "Confirm Password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          GetBuilder<RadioController>(builder: (radioController) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: defaultPadding),
              child: radioController.id.value == 1
                  ? Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            cursorColor: kPrimaryColor,
                            onSaved: (value) {
                              formData['age'] = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Age",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(defaultPadding),
                                child: Icon(Icons.date_range),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: defaultPadding / 2),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            cursorColor: kPrimaryColor,
                            onSaved: (value) {
                              formData['weight'] = value;
                            },
                            decoration: const InputDecoration(
                              hintText: "Weight",
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(defaultPadding),
                                child: Icon(Icons.monitor_weight),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      cursorColor: kPrimaryColor,
                      onSaved: (value) {
                        formData['experience'] = value;
                      },
                      decoration: const InputDecoration(
                        hintText: "Experience",
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(defaultPadding),
                          child: Icon(Icons.workspace_premium),
                        ),
                      ),
                    ),
            );
          }),
          GetBuilder<RadioController>(builder: (radioController) {
            return radioController.id.value == 1
                ? Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          cursorColor: kPrimaryColor,
                          onSaved: (value) {
                            formData['height'] = value;
                          },
                          decoration: const InputDecoration(
                            hintText: "Height",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.height),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: defaultPadding / 2),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          cursorColor: kPrimaryColor,
                          onSaved: (value) {
                            formData['bloodGroup'] = value;
                          },
                          decoration: const InputDecoration(
                            hintText: "Blood Group",
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(defaultPadding),
                              child: Icon(Icons.bloodtype),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    cursorColor: kPrimaryColor,
                    onSaved: (value) {
                      formData['specialization'] = value;
                    },
                    decoration: const InputDecoration(
                      hintText: "Specialization",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.card_giftcard),
                      ),
                    ),
                  );
          }),
          const SizedBox(height: defaultPadding * 2),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState == null) return;
              if (_formKey.currentState!.validate()) {
                debugPrint("Form is Validated");
                _formKey.currentState!.save();
                Get.defaultDialog(
                    title: '', content: loading(), barrierDismissible: false);
                bool isCreated = await authController.register(
                    formData['email'], formData['password']);
                if (isCreated) {
                  final customUser = CustomerUser(
                      authController.firebaseUser.value?.uid,
                      formData['name'],
                      formData['email'],
                      formData['password'],
                      formData['age'] == '' || formData['age'] == null
                          ? 0
                          : int.parse(formData['age']),
                      formData['weight'] == '' || formData['weight'] == null
                          ? 0.0
                          : double.parse(formData['weight']),
                      formData['height'] == '' || formData['height'] == null
                          ? 0.0
                          : double.parse(formData['height']),
                      formData['bloodGroup'] ?? '',
                      formData['specialization'] ?? '',
                      formData['experience'] ?? '',
                      Get.put(RadioController()).id.value == 1
                          ? typePatient
                          : typeDoctor);
                  UserDb.postUser(customUser).then((value) {
                    Get.back();
                  }).catchError((onError) {
                    Get.back();
                    print(onError.toString());
                  });
                } else {
                  Get.back();
                }
              } else {
                debugPrint('Something is wrong with form');
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
          const SizedBox(height: defaultPadding * 2),
        ],
      ),
    );
  }
}
