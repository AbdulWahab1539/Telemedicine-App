import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/constants.dart';
import 'package:get/get.dart';
import 'firebase_exceptions.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String id = 'reset_password';

  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  static final auth = FirebaseAuth.instance;
  static late AuthStatus _status;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<AuthStatus> resetPassword({required String email}) async {
    print('resetPassword');
    await auth
        .sendPasswordResetEmail(email: email)
        .then((value) => _status = AuthStatus.successful)
        .catchError(
            (e) => _status = AuthExceptionHandler.handleAuthException(e));

    return _status;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 16.0, right: 16.0, top: 50.0, bottom: 25.0),
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close),
                  ),
                  const SizedBox(height: 70),
                  const Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter your email address to recover your password.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
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
                    decoration: const InputDecoration(
                      hintText: "name@gmail.com",
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(Icons.email),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Expanded(child: SizedBox()),
                  ElevatedButton(
                    onPressed: () {
                      print('GO Reset Password');
                      if (_key.currentState!.validate()) {
                        // final _status = await resetPassword(
                        //     email: _emailController.text.trim());
                        print(_status);
                        if (_status == AuthStatus.successful) {
                          //your logic
                          print('LInk send successfully');
                          // print();
                        } else {
                          //your logic or show snackBar with error message
                          print('Failed to Send');
                        }
                      }else{
                        print('unable to validate');
                      }
                    },
                    // minWidth: double.infinity,
                    child: const Text(
                      'RECOVER PASSWORD',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  // const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
