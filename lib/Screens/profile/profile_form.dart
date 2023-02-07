import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Signup/components/radio_group.dart';
import 'package:flutter_auth/auth/reset_password.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_auth/repo/user_db.dart';
import 'package:get/get.dart';

import '../../../constants.dart';
import '../../../utils/utils_widgets.dart';

class ProfileForm extends StatelessWidget {
  const ProfileForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final Map<String, dynamic> formData = {
      'name': null,
      'age': null,
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
          TextFormField(
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
            initialValue: authController.user.value!.name,
            decoration: const InputDecoration(
              hintText: "Full Name",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: authController.user.value?.accountType == typePatient
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
                          initialValue:
                              authController.user.value!.age.toString(),
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
                          initialValue:
                              authController.user.value!.weight.toString(),
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
                    initialValue: authController.user.value!.experience,
                    decoration: const InputDecoration(
                      hintText: "Experience",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.workspace_premium),
                      ),
                    ),
                  ),
          ),
          authController.user.value?.accountType == typePatient
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
                        initialValue:
                            authController.user.value!.height.toString(),
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
                        initialValue: authController.user.value!.bloodGroup,
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
                  keyboardType: TextInputType.text,
                  cursorColor: kPrimaryColor,
                  onSaved: (value) {
                    formData['specialization'] = value;
                  },
                  initialValue: authController.user.value!.specialization,
                  decoration: const InputDecoration(
                    hintText: "Specialization",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.card_giftcard),
                    ),
                  ),
                ),
          const SizedBox(height: defaultPadding * 2),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () => Get.to(const ResetPasswordScreen()),
                  child: Text(
                    "Reset Password".toUpperCase(),
                  ),
                ),
              ),
              const SizedBox(width: defaultPadding / 2),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    print('Check form please');
                    if (_formKey.currentState == null) return;
                    if (_formKey.currentState!.validate()) {
                      print("Form is Validated");
                      _formKey.currentState!.save();
                      Get.defaultDialog(
                          title: '',
                          content: loading(),
                          barrierDismissible: false);
                      final customUser = CustomerUser(
                          authController.firebaseUser.value?.uid,
                          formData['name'],
                          authController.user.value!.email,
                          authController.user.value!.password,
                          formData['age'] == '' || formData['age'] == null
                              ? authController.user.value!.age
                              : int.parse(formData['age']),
                          formData['weight'] == '' || formData['weight'] == null
                              ? authController.user.value!.weight
                              : double.parse(formData['weight']),
                          formData['height'] == '' || formData['height'] == null
                              ? authController.user.value!.height
                              : double.parse(formData['height']),
                          formData['bloodGroup'] ??
                              authController.user.value!.bloodGroup,
                          formData['specialization'] ??
                              authController.user.value!.specialization,
                          formData['experience'] ??
                              authController.user.value!.experience,
                          authController.user.value!.accountType);
                      UserDb.updateUser(customUser).then((value) {
                        print('not failed');
                        Get.back();
                        Get.snackbar('Profile Updated', 'Profile has been updated successfully', overlayColor: Colors.green);
                      }).catchError((onError) {
                        Get.back();
                        Get.snackbar('Profile Failed', 'Profile update failed', overlayColor: Colors.red);
                        print(onError.toString());
                      });
                    } else {
                      print('Something is wrong with form');
                    }
                  },
                  child: Text("Update Profile".toUpperCase()),
                ),
              ),
            ],
          ),
          const SizedBox(height: defaultPadding * 2),
        ],
      ),
    );
  }
}
