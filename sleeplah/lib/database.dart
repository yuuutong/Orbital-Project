import 'dart:async';
import 'dart:collection';
import 'dart:core';
import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
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

    // .then((value) {
    //   bedTimeCollection =
    //       userCollection.doc(uid).collection('bedTimeCollection');
    //   print("User added");
    // }).catchError((error) => print("Failed to add user: $error"));
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
