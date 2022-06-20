import 'dart:async';
import 'dart:collection';
import 'dart:core';
import 'dart:ffi';
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
  late CollectionReference actualTimeCollection;
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
    bedTimeCollection =
        instance.collection('users').doc(uid).collection('bedTimeCollection');
  }

  Future<void> addUser(AppUser user, String uid) async {
    await userCollection.doc(uid).set({
      'uid': uid,
      'email': user.email,
      'nickname': user.nickName,
    }).then((value) {
      bedTimeCollection =
          userCollection.doc(uid).collection('bedTimeCollection');
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

  Future<void> recordActualTime(
      TimeOfDay timeOfDay, String uid, String sleepOrWake) async {
    String today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    actualTimeCollection =
        userCollection.doc(uid).collection('actualTimeCollection');
    await actualTimeCollection
        .doc(today)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (!documentSnapshot.exists) {
        actualTimeCollection.doc(today).set({"sleep": "", "wake": ""});
      }
    });
    actualTimeCollection.doc(today).update({sleepOrWake: timeOfDay.toString()});
  }

  Future<bool> doesDateExist(String date) async {
    bool exist = false;
    try {
      DocumentSnapshot documentSnapshot =
          bedTimeCollection.doc(date).get() as DocumentSnapshot;
      exist = documentSnapshot.exists;
    } catch (e) {
      print("date problem");
    }
    return exist;
  }

  // Future<bool> doesDateExist(String date) async {
  //   bool exists = false;
  //   await bedTimeCollection.doc(date).get().then(
  //       (DocumentSnapshot documentSnapshot) =>
  //           exists = documentSnapshot.exists);
  //   return exists;
  // }

  Future<String> getSleepTime(String date) async {
    String sleepTime = '';
    await bedTimeCollection
        .doc(date)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      sleepTime = documentSnapshot.get("sleep");
    });
    return sleepTime;
  }

  Future<String> getActualSleepTime(String date) async {
    String sleepTime = '';
    await actualTimeCollection
        .doc(date)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      sleepTime = documentSnapshot.get("sleep");
    });
    return sleepTime;
  }

  Future<String> getSleep(String date) async {
    String time = '';
    DocumentReference docRef = bedTimeCollection.doc(date);
    if (await doesDateExist(date)) {
      bedTimeCollection
          .doc(date)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        time = documentSnapshot.get("sleep");
      });
    }
    print("my getSleep() returns: " + time);
    return time;
  }

  Future<String> getWakeTime(String date) async {
    String wakeTime = '';
    await bedTimeCollection
        .doc(date)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      wakeTime = documentSnapshot.get("wake");
    });
    return wakeTime;
  }

  Future<String> getActualWakeTime(String date) async {
    String wakeTime = '';
    await actualTimeCollection
        .doc(date)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      wakeTime = documentSnapshot.get("wake");
    });
    return wakeTime;
  }

  Future<String> getWake(String date) async {
    String time = '';
    DocumentReference docRef = bedTimeCollection.doc(date);
    if (await doesDateExist(date)) {
      bedTimeCollection
          .doc(date)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        time = documentSnapshot.get("wake");
      });
    }
    print("my getWake() returns: " + time);
    return time;
  }

  Future<int> getYear(String date) async {
    List<String> fullDate = date.split("-");
    String year = fullDate.first;
    int intYear = int.parse(year);
    return intYear;
  }

  Future<int> getDay(String date) async {
    List<String> fullDate = date.split("-");
    String day = fullDate.last.substring(0, 1);
    int intDay = int.parse(day);
    return intDay;
  }

  Future<int> getMonth(String date) async {
    List<String> fullDate = date.split("-");
    String month = fullDate.elementAt(1);
    int intMonth = int.parse(month);
    return intMonth;
  }

  Future<int> getHour(String time) async {
    List<String> fullTime = time.split("");
    List<String> hour = fullTime.sublist(10, 12);
    String hourString = hour.join();
    int intHour = int.parse(hourString);
    return intHour;
  }

  Future<int> getMinute(String time) async {
    List<String> fullTime = time.split("");
    List<String> minute = fullTime.sublist(13, 15);
    String minuteString = minute.join();
    int intMinute = int.parse(minuteString);
    return intMinute;
  }

  Future<DateTime> convertToDateTime(String date, String time) async {
    return DateTime(await getYear(date), await getMonth(date),
        await getDay(date), await getHour(time), await getMinute(time));
  }

  Future<double> sleepDuration(String wake, String sleep, String date) async {
    DateTime wakeTime = DateTime(await getYear(date), await getMonth(date),
        await getDay(date), await getHour(wake), await getMinute(wake));
    DateTime sleepTime = DateTime(await getYear(date), await getMonth(date),
        await getDay(date), await getHour(sleep), await getMinute(sleep));
    Duration whenAwake = sleepTime.difference(wakeTime);
    Duration whenInSleep = const Duration(hours: 24, minutes: 0) - whenAwake;
    num numOfHours = whenInSleep.inHours; // int
    num fractionInHours =
        num.parse((whenInSleep.inMinutes / 60).toStringAsFixed(1)); // num
    num totalDuration = numOfHours + fractionInHours;
    return totalDuration as double;
  }

  String nDaysAgo(int n) {
    DateTime pastDate = DateTime.now().subtract(new Duration(days: n));
    return pastDate.toString();
  }

  Future<double> getSleepDurationOnDate(int n) async {
    String date = nDaysAgo(n);
    double totalDuration = 0;
    // String wake = '';
    // String sleep = '';
    // getWake(date).then((value) => setState(() {String wake = value;}));
    // getSleep(date).then((value) => String sleep = value);
    sleepDuration(await getWake(date), await getSleep(date), date)
        .then((value) {
      totalDuration = value;
    });
    return totalDuration;
  }

  
}
