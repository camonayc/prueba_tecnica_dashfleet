import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prueba_tecnica_dashfleet/app/data/models/models.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getUsers() async {
  List users = [];

  CollectionReference collectionReferenceUsers = db.collection('Users');

  QuerySnapshot querySnapshotUsers = await collectionReferenceUsers.get();

  for (var document in querySnapshotUsers.docs) {
    users.add({'id': document.id, 'data': document.data()});
  }
  // print(jsonEncode(users));
  return users;
}

Future<void> updatePasswordUser({required Users user}) async {
  await db.collection('Users').doc(user.id).update(user.data!.toMap());
}

Future<void> createUser({required Users user}) async {
  await db.collection('Users').add(user.data!.toMap());
}
