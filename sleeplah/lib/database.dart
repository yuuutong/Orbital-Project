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
  // late CollectionReference wakeUpTimeCollection;
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

  int getYear(String date) {
    List<String> fullDate = date.split("-");
    String year = fullDate.first;
    int intYear = int.parse(year);
    return intYear;
  }

  int getDay(String date) {
    List<String> fullDate = date.split("-");
    String day = fullDate.last;
    int intDay = int.parse(day);
    return intDay;
  }

  int getMonth(String date) {
    List<String> fullDate = date.split("-");
    String month = fullDate.elementAt(1);
    int intMonth = int.parse(month);
    return intMonth;
  }

  int getHour(String time) {
    List<String> fullTime = time.split("");
    List<String> hour = fullTime.sublist(10, 12);
    String hourString = hour.join();
    int intHour = int.parse(hourString);
    return intHour;
  }

  int getMinute(String time) {
    List<String> fullTime = time.split("");
    List<String> minute = fullTime.sublist(13, 15);
    String minuteString = minute.join();
    int intMinute = int.parse(minuteString);
    return intMinute;
  }

  Future<DateTime> convertToDateTime(String date, String time) async {
    return DateTime(getYear(date), getMonth(date), getDay(date), getHour(time), getMinute(time));
  }

  Future<num> sleepDuration(String wake, String sleep, String date) async {
    DateTime wakeTime = DateTime(getYear(date), getMonth(date), getDay(date), getHour(wake), getMinute(wake));
    DateTime sleepTime = DateTime(getYear(date), getMonth(date), getDay(date), getHour(sleep), getMinute(sleep));
    Duration whenAwake = sleepTime.difference(wakeTime);
    Duration whenInSleep = const Duration(hours: 24, minutes: 0) - whenAwake;
    num numOfHours = whenInSleep.inHours; // int
    num fractionInHours = num.parse((whenInSleep.inMinutes / 60).toStringAsFixed(1)); // num
    num totalDuration = numOfHours + fractionInHours;
    return totalDuration;
  }
}
