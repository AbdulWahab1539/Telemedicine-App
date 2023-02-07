import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_auth/constants.dart';

import '../models/user.dart';

class UserDb {
  static Future<void> postUser(CustomerUser user) async {
    await firestore.collection('Users').doc(auth.currentUser!.uid).set({
      'id': auth.currentUser!.uid,
      'name': user.name,
      'email': user.email,
      'password': user.password,
      'accountType': user.accountType,
      'age': user.accountType == typePatient ? user.age : 0,
      'height': user.accountType == typePatient ? user.height : 0.0,
      'weight': user.accountType == typePatient ? user.weight : 0.0,
      'bloodGroup': user.accountType == typePatient ? user.bloodGroup : '',
      'experience': user.accountType == typeDoctor ? user.experience : '',
      'specialization':
          user.accountType == typeDoctor ? user.specialization : '',
    });
  }

  static Future<CustomerUser?> getUser(String userId) async {
    try {
      final userData = await firestore.collection('Users').doc(userId).get();
      print('GetUser: ${userData.data()}');
      return CustomerUser.fromDocumentSnapshot(documentSnapshot: userData);
    } catch (error) {
      return null;
    }
  }

  // static Stream<List<TodoModel>> todoStream() {
  //   return firestore
  //       .collection('users')
  //       .doc(auth.currentUser!.uid)
  //       .collection('todos')
  //       .snapshots()
  //       .map((QuerySnapshot query) {
  //     List<TodoModel> todos = [];
  //     for (var todos in query.docs) {
  //       final todoModel =
  //       TodoModel.fromDocumentSnapshot(documentSnapshot: todos);
  //       todos.add(todoModel);
  //     }
  //     return todos;
  //   });
  // }

  static Future<void> updateUser(CustomerUser user) async {
    await firestore
        .collection('Users')
        .doc(auth.currentUser!.uid)
        .update(
      {
        'name': user.name,
        'age': user.age,
        'height': user.height,
        'weight': user.weight,
        'bloodGroup': user.bloodGroup,
        'experience': user.experience,
        'specialization': user.specialization,
      },
    );
  }

  static deleteTodo(String documentId) {
    firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('todos')
        .doc(documentId)
        .delete();
  }
}
