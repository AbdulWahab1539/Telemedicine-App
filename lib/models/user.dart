import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';



extension CustomGetters on DocumentSnapshot {
  int getInt(key) {
    return data().toString().contains(key) ? get(key) : 0;
  }
  double getDouble(key) {
    return data().toString().contains(key) ? get(key) : 0.0;
  }
  String getString(key) {
    return data().toString().contains(key) ? get(key) : '';
  }
}

class CustomerUser {
  String? documentId;
  late String name;
  late String email;
  late String password;
  late String address;
  late String phone;
  late int age;
  late double weight;
  late double height;
  late String bloodGroup;
  late String specialization;
  late String experience;
  late String accountType;


  CustomerUser(
      this.documentId,
      this.name,
      this.email,
      this.password,
      this.age,
      this.weight,
      this.height,
      this.bloodGroup,
      this.specialization,
      this.experience,
      this.accountType);

  // late Timestamp createdOn;
  // late bool isDone;





CustomerUser.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    documentId = documentSnapshot.getString('id');
    name = documentSnapshot.getString('name');
    email = documentSnapshot.getString('email');
    password = documentSnapshot.getString('password');
    age = documentSnapshot.getInt('age');
    weight = documentSnapshot.getDouble('weight');
    height = documentSnapshot.getDouble('height');
    bloodGroup = documentSnapshot.getString('bloodGroup');
    specialization = documentSnapshot.getString('specialization');
    experience = documentSnapshot.getString('experience');
    accountType = documentSnapshot.getString('accountType');
  }
}