import 'dart:async';
import 'dart:collection';
import 'dart:core';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:sleeplah/constant.dart';
import 'package:sleeplah/login_page/LoginScreen.dart';
import 'package:sleeplah/models/AppUser.dart';
import 'package:intl/intl.dart';
import 'package:sleeplah/garden_page/check.dart';

class DB {
  late CollectionReference userCollection;
  late DocumentReference userDoc;

  late CollectionReference timeCollection;

  DB({FirebaseFirestore? instanceInjection}) {
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
  }

  Future<void> addUser(AppUser user, String uid) async {
    await userCollection.doc(uid).set({
      'uid': uid,
      'email': user.email,
      'nickname': user.nickName,
    });
  }

  Future<List<String>> getList(String databaseField, String userId) async {
    //late List<String> requestList;
    late List<String> requestList = [];
    DocumentReference docRef = userCollection.doc(userId);
    await docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        var requestListRaw = [];
        try {
          requestListRaw = documentSnapshot.get(databaseField);
        } catch (StateError) {
          print("rq list does not exist");
        }

        requestList = List<String>.from(requestListRaw);
      }
    });

    return requestList;
  }

  // coins
  Future<int> getCoins() async {
    int count = 0;
    await userDoc.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        //var map = documentSnapshot.data();
        //count = map[FirebaseString.bio]
        count = documentSnapshot.get("coins");
      }
    });
    
    return count;
  }

  Future<void> updateCoin(int amt) async {
    int count = await getCoins();
    userDoc.update({"coins": count + amt});
  }

  /* Future<void> claimReward(int index, String date, String userID) async {
      if (check().compareTime(date)) {
        await userDoc.update({
      "flowers": getFlowerList(userID)});
    });
      }
    String curr = '$index-$date';
    
    updateCoin(10);
  } */

  // days
  Future<int> getDays() async {
    int count = 0;
    await userDoc.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        count = documentSnapshot.get("days");
      }
    });
    return count;
  }

  Future<void> updateDays(int amt) async {
    int count = await getDays();
    userDoc.update({"days": count + amt});
  }

  // flower
  Future<List<String>> getFlowerList(String userId) {
    return getList("flowers", userId);
  }

  Future<void> addFlower(String userId, String flowerId) async {
    var flowerList = await getFlowerList(userId);
    var doc = userCollection.doc(userId);
    if (!flowerList.contains(flowerId)) flowerList.add(flowerId);

    doc.update({"flowers": flowerList});
  }

  /* Future<List<String>> updateFlowerNum(String userId, String flowerId) async {
      List<String> newList = await getFlowerList(userId).removeAt();

      return getList("flowers", userId);
    } */

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

  Future<Map> getTimeCollectionDoc(String docDate) async {
    Map result = {};
    DocumentReference docRef = userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('timeCollection')
        .doc(docDate);
    await docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        result = documentSnapshot.data() as Map;
      }
    });
    return result;
  }

  Future<void> updateTimeCollection(
      String docDate, String fieldName, DateTime updatedValue) async {
    timeCollection = userDoc.collection('timeCollection');
    await timeCollection
        .doc(docDate)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (!documentSnapshot.exists) {
        timeCollection.doc(docDate).set({
          "sleepSet": "",
          "wakeSet": "",
          "sleepActual": "",
          "wakeActual": ""
        });
      }
    });
    timeCollection.doc(docDate).update({fieldName: updatedValue.toString()});
  }

  static DateTime convertTimeOfDayToDateTime(TimeOfDay t) {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, t.hour, t.minute);
  }

  Future<void> setTime(DateTime dateTime, String fieldName) async {
    String docDate = DateFormat("yyyy-MM-dd").format(dateTime);
    updateTimeCollection(docDate, fieldName, dateTime);
  }
}
