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
import 'package:sleeplah/models/flowers.dart';
import 'dart:math';

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
      'flowers': user.flowers,
      'coins': user.coins,
      'friends': user.friends,
      'numOfDays': user.numOfDays
    }).then((value) {
      print("User added");
    }).catchError((error) => print("Failed to add user: $error"));

    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    bedTimeCollection = userCollection.doc(uid).collection('bedTimeCollection');
    await bedTimeCollection
        .doc(today)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      bedTimeCollection.doc(today).set({"sleep": "", "wake": ""});
    });

    actualTimeCollection =
        userCollection.doc(uid).collection('actualTimeCollection');
    await actualTimeCollection
        .doc(today)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      actualTimeCollection.doc(today).set({"sleep": "", "wake": ""});
    });
  }

  Future<List<String>> getList(String databaseField, String userId) async {
    late List<String> requestList;
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
        count = documentSnapshot.get("coins");
      }
    });
    return count;
  }

  Future<void> updateCoin(int amt) async {
    int count = await getCoins();
    userDoc.update({"coins": count + amt});
  }

  // pick flowers that have already been unlocked
  Future<Flower> pickExistingFlower() async {
    var userFlowers = await getFlowerList(user!.uid);
    List<Flower> unlockedFlowers = [];
    for (var Flower in FlowerList) {
      if (userFlowers[int.parse(Flower.id)] != "0") unlockedFlowers.add(Flower);
      // if num != 0 for a particular variant in current list of flower, then it is unlocked. add it to unlocked list
    }

    var _random = Random();

    return unlockedFlowers.length == 0
        ? FlowerList.first
        : unlockedFlowers[_random.nextInt(unlockedFlowers.length)];
  }

  // add 1 to a flower variant that has alr been unlocked, and add 10 coins
  Future<void> claimReward(String date, String userID) async {
    if (await check().compareTime(date)) {
      //var flowerList = await getFlowerList(userID);
      var selectedFlower = await pickExistingFlower();
      addFlower(user!.uid, selectedFlower.id);
      updateCoin(10);
    }
  }

  // days
  Future<int> getDays(String userId) async {
    int count = 0;
    DocumentReference docRef = userCollection.doc(userId);
    await docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        count = documentSnapshot.get("numOfDays");
      }
    });
    return count;
  }

  Future<void> updateDays(int amt, String userId) async {
    int count = await getDays(userId);
    DocumentReference docRef = userCollection.doc(userId);
    docRef.update({"days": count + amt});
  }

  // flower
  Future<List<String>> getFlowerList(String userId) {
    return getList("flowers", userId);
  }

  Future<void> addFlower(String userId, String flowerId) async {
    List<String> flowerList = await getFlowerList(userId);
    var doc = userCollection.doc(userId);
    // add 1 more flower to the variant specified by ID
    flowerList[int.parse(flowerId)] =
        (int.parse(flowerList[int.parse(flowerId)]) + 1).toString();
    doc.update({"flowers": flowerList});
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

  Future<Map> getTimeCollectionDoc(String docDate) async {
    Map result = {};
    DocumentReference docRef = userCollection
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('timeCollection')
        .doc(docDate);
    await docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        result = documentSnapshot.data();
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
