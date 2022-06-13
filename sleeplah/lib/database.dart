import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:sleeplah/Login/log_in.dart';
import 'package:sleeplah/models/app_user.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  late CollectionReference userCollection;
  late DocumentReference userDoc;
  late CollectionReference bedTimeCollection;
  late CollectionReference wakeUpTimeCollection;
  // late CollectionReference tagsCollection;
  // late CollectionReference townCollection;

  DatabaseService({FirebaseFirestore? instanceInjection}) {
    FirebaseFirestore instance;
    String uid;

    if (instanceInjection == null) {
      instance = FirebaseFirestore.instance;
      uid = user?.uid ?? "0";
    } else {
      instance = instanceInjection;
      uid = "0";
    }

    userCollection = instance.collection('users');
    userDoc = instance.collection('users').doc(uid);
    // bedTimeCollection = instance.collection('users').doc(uid).collection('timings');
  }

  Future<void> addUser(AppUser user, String uid) async {
    await userCollection.doc(uid).set({
      'uid': uid,
      'email': user.email,
      'nickname': user.nickName,
    }).then((value) {
      print("User added");
    }).catchError((error) => print("Failed to add user: $error"));
  }

  Future<String> getUserName(String userId) async {
    late String name;
    DocumentReference docRef = userCollection.doc(userId);
    await docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        name = documentSnapshot.get("nickname");
      } else {
        name = "null";
      }
    });
    return name;
  }

  Future<bool> isUserNameExist(String receiverName) async {
    bool exist = true;
    await userCollection
        .where("nickname", isEqualTo: receiverName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.size == 0) {
        exist = false;
      }
    });
    return exist;
  }

  Future<void> setTimer(
      TimeOfDay timeOfDay, String uid, String sleepOrWake) async {
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    bedTimeCollection = userCollection.doc(uid).collection('bedTimeCollection');
    await bedTimeCollection
        .doc(today)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (!documentSnapshot.exists) {
        bedTimeCollection.doc(today).set({"sleep": "", "wake": ""});
      }
    });
    bedTimeCollection.doc(today).update({sleepOrWake: timeOfDay.toString()});
  }

  Future<String> getSleepTime(String date) async {
    String sleepTime = '';
    await bedTimeCollection.doc(date).get().then((DocumentSnapshot documentSnapshot) {
      sleepTime = documentSnapshot.get("sleep");
    });
    return sleepTime;
  }

  Future<String> getWakeTime(String date) async {
    String wakeTime = '';
    await bedTimeCollection.doc(date).get().then((DocumentSnapshot documentSnapshot) {
      wakeTime = documentSnapshot.get("wake");
    });
    return wakeTime;
  }
}
