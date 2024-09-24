
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> readCrash() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionRef = firestore.collection('crashed');
  QuerySnapshot querySnapshot = await collectionRef.get();

  // Check if there are any documents
  if (querySnapshot.docs.isNotEmpty) {
    // Assuming you want to return the value from the first document
    DocumentSnapshot doc = querySnapshot.docs.first;
    bool isCrashed = doc['isCrashed'];
    log('Boolean field value: $isCrashed');
    return isCrashed;
  } else {
    // Handle the case where there are no documents
    log('No documents found in the collection.');
    return false; // or any default value you prefer
  }


  
}


Future<bool> readRelogin() async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference collectionRef = firestore.collection('crashed');
  QuerySnapshot querySnapshot = await collectionRef.get();

  // Check if there are any documents
  if (querySnapshot.docs.isNotEmpty) {
    // Assuming you want to return the value from the first document
    DocumentSnapshot doc = querySnapshot.docs.first;
    bool reLogin = doc['relogin'];
    log('Boolean reLogin value: $reLogin');
    return reLogin;
  } else {
    // Handle the case where there are no documents
    log('No documents found in the collection.');
    return false; // or any default value you prefer
  }
}