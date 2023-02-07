import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'auth/auth_controllers.dart';
import 'firebase_options.dart';

const kPrimaryColor = Color(0xFF6F35A5); //6F35A5
const kPrimaryLightColor = Color(0xFFF1E6FF); //#F1E6FF


const typePatient = "Patient";
const typeDoctor = "Doctor";

AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

const double defaultPadding = 16.0;
