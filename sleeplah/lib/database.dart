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
  late CollectionReference bedTimeCollection;
  late CollectionReference actualTimeCollection;
  late CollectionReference flowerCollection;
  late CollectionReference daysCollection;
  late CollectionReference coinCollection;

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

    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    bedTimeCollection = userCollection.doc(uid).collection('bedTimeCollection');
    await bedTimeCollection
        .doc(today)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      bedTimeCollection.doc(today).set({"sleep": "", "wake": ""});
    });

    timeCollection = userCollection.doc(uid).collection('timeCollection');
    await timeCollection
        .doc(today)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      timeCollection.doc(today).set(
          {"sleepSet": "", "wakeSet": "", "sleepActual": "", "wakeActual": ""});
    });

    flowerCollection = userCollection.doc(uid).collection('flowerCollection');
    await flowerCollection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      flowerCollection
          .doc(uid)
          .set({"sunflower": 1, "rose": 0, "daisy": 0, "lilac": 0});
    });

    coinCollection = userCollection.doc(uid).collection('coinCollection');
    await coinCollection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      coinCollection.doc(uid).set({"Number of Coins": 0});
    });

    daysCollection = userCollection.doc(uid).collection('daysCollection');
    await daysCollection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      daysCollection.doc(uid).set({"Days of consecutive sleeping on time": 0});
    });
  }

  //flower
  // Future<void> setFlower(String uid) async {
  //   flowerCollection = userCollection.doc(uid).collection('flowerCollection');
  //   // await flowerCollection
  //   //     .doc(uid)
  //   //     .get()
  //   //     .then((DocumentSnapshot documentSnapshot) {
  //   //   if (!documentSnapshot.exists) {
  //   //     flowerCollection
  //   //         .doc(uid)
  //   //         .set({"sunflower": 1, "rose": 0, "daisy": 0, "lilac": 0});
  //   //   }
  //   // });
  //   flowerCollection.doc(uid).update({
  //     "sunflower": getFlowerNum("sunflower", uid),
  //     "rose": getFlowerNum("rose", uid),
  //     "daisy": getFlowerNum("daisy", uid),
  //     "lilac": getFlowerNum("lilac", uid)
  //   });
  // }

  Future<int> getFlowerNum(String flowerName, String uid) async {
    flowerCollection = userCollection.doc(uid).collection('flowerCollection');
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    bool increase = await check().compareTime(today);
    late int count;
    await flowerCollection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (!increase) {
        count = documentSnapshot.get(flowerName) - 1;
      } else {
        count = documentSnapshot.get(flowerName) + 1;
      }
      print(count.toString() + "herherhehr");
    });
    return count;
  }

  /* Future<void> updateFlower(String flowerName, String uid) async {
    flowerCollection = userCollection.doc(uid).collection('flowerCollection');
    int count = await getFlowerNum(flowerName, uid);
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    bool increase = await check().compareTime(today);
    if (increase) {
      flowerCollection.doc(today).update({flowerName: count + 1});
    } else {
      flowerCollection.doc(today).update({flowerName: count - 1});
    }
  } */

  // num of days of consecutive sleeping on time
  // Future<void> setDays(String uid) async {
  //   daysCollection = userCollection.doc(uid).collection('daysCollection');
  //   await daysCollection
  //       .doc(uid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (!documentSnapshot.exists) {
  //       daysCollection
  //           .doc(uid)
  //           .set({"Days of consecutive sleeping on time": 0});
  //     }
  //   }).catchError((e) => ErrorWidget(e));
  //   daysCollection.doc(uid).update(
  //       {"Days of consecutive sleeping on time": getNumOfConsecutiveDays(uid)});
  // }

  Future<int> getNumOfConsecutiveDays(String uid) async {
    late int count;
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    daysCollection = userCollection.doc(uid).collection('daysCollection');
    bool increase = await check().compareTime(today);
    await daysCollection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (!increase) {
        count = documentSnapshot.get("Days of consecutive sleeping on time");
      } else {
        count =
            documentSnapshot.get("Days of consecutive sleeping on time") + 1;
      }
    });
    return count;
  }

  // // coins
  // Future<void> setNumOfCoins(String uid) async {
  //   coinCollection = userCollection.doc(uid).collection('coinCollection');
  //   await coinCollection
  //       .doc(uid)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (!documentSnapshot.exists) {
  //       coinCollection.doc(uid).set({"Number of Coins": 0});
  //     }
  //   });
  //   coinCollection.doc(uid).update({"Number of Coins": getNumOfCoins(uid)});
  // }

  Future<int> getNumOfCoins(String uid) async {
    late int count;
    int numOfDays = await getNumOfConsecutiveDays(uid);
    coinCollection = userCollection.doc(uid).collection('coinCollection');
    await daysCollection
        .doc(uid)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (numOfDays > 6) {
        count = documentSnapshot.get("Number of Coins") + 10;
      } else {
        count = documentSnapshot.get("Number of Coins");
      }
    });
    return count;
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
