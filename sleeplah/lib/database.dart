import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/login_page/LoginScreen.dart';
import 'package:sleeplah/models/AppUser.dart';
import 'package:intl/intl.dart';
import 'package:sleeplah/models/flowers.dart';
import 'dart:math';

class DB {
  late CollectionReference userCollection;
  late DocumentReference userDoc;

  // late CollectionReference timeCollection;
  late CollectionReference DTRCollection;

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
      'numOfDays': user.numOfDays,
      'profileFlowerID': user.profileFlowerID,
      'sleepTimeSet': user.sleepTimeSet,
      'wakeTimeSet': user.wakeTimeSet,
      'sleeping': user.sleeping,
    }).then((value) {
      print("User added");
    }).catchError((error) => print("Failed to add user: $error"));
    await userCollection
        .doc(uid)
        .collection('DTRCollection')
        .doc('DTR')
        .set({});
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
  Future<int> getCoins(String userId) async {
    int count = 0;
    DocumentReference docRef = userCollection.doc(userId);
    await docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        count = documentSnapshot.get("coins");
      }
    });
    /* await userDoc.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        count = documentSnapshot.get("coins");
      }
    }); */
    return count;
  }

  Future<void> updateCoin(int amt, String uid) async {
    int count = await getCoins(uid);
    DocumentReference docRef = userCollection.doc(uid);
    docRef.update({"coins": count + amt});
  }

  // pick flowers that have already been unlocked
  Future<Flower> pickExistingFlower() async {
    var userFlowers = await getFlowerList();
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

  // add 1 to a flower variant that has alr been unlocked, and add 10 coins, update num of days of sleeping
  Future<void> claimReward(
      //String date,
      String userID) async {
    // if (await check().compareTime(date)) {
    var selectedFlower = await pickExistingFlower();
    addFlower(userID, selectedFlower.id);
    updateCoin(10, userID);
    updateDays(1, userID);
    print("reward claimed");
    // }
    //print("reward never run");
  }

  // Future<void> eligibleForReward(String date, String userID) async {
  //   Map timeDoc = await DB().getTimeCollectionDoc(date);
  //   print(timeDoc.values.toString() + " values are listed in the map");
  //   if (timeDoc["sleepSet"] == "" ||
  //       timeDoc["wakeSet"] == "" ||
  //       timeDoc["sleepActual"] == "" ||
  //       timeDoc["wakeActual"] == "") {
  //     print(
  //         "Missing start/end times: please set your goal timing for sleeping and waking up!");
  //   } else {
  //     DateTime sleepSet = DateTime.parse(timeDoc["sleepSet"]);
  //     DateTime wakeSet = DateTime.parse(timeDoc["wakeSet"]);
  //     DateTime sleepActual = DateTime.parse(timeDoc["sleepActual"]);
  //     DateTime wakeActual = DateTime.parse(timeDoc["wakeActual"]);
  //     if (sleepSet.isAfter(sleepActual) && wakeSet.isAfter(wakeActual)) {
  //       await DB().claimReward(userID);
  //       print("Congratulations! You've kept to your set sleep goal!");
  //     } else {
  //       print("Good job! Though next time, try to keep to the time you set!");
  //     }
  //   }
  // }

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
    docRef.update({"numOfDays": count + amt});
  }

  // flower
  Future<List<String>> getFlowerList() {
    return getList("flowers", FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> addFlower(String userId, String flowerId) async {
    List<String> flowerList = await getFlowerList();
    var doc = userCollection.doc(userId);
    // add 1 more flower to the variant specified by ID
    flowerList[int.parse(flowerId)] =
        (int.parse(flowerList[int.parse(flowerId)]) + 1).toString();
    doc.update({"flowers": flowerList});
  }

  // user name related
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

  Future<String> getUserValue(String userId, String fieldName) async {
    late String value;
    DocumentReference docRef = userCollection.doc(userId);
    await docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        value = documentSnapshot.get(fieldName);
      } else {
        //value = "null";
        value = ""; 
      }
    });
    return value;
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

  // time related
  // // Future<Map> getTimeCollectionDoc(String docDate) async {
  // //   Map result = {};
  // //   DocumentReference docRef = userCollection
  // //       .doc(FirebaseAuth.instance.currentUser!.uid)
  // //       .collection('timeCollection')
  // //       .doc(docDate);
  // //   await docRef.get().then((DocumentSnapshot documentSnapshot) {
  // //     if (documentSnapshot.exists) {
  // //       result = documentSnapshot.data() as Map;
  // //     }
  // //   });
  // //   return result;
  // }

  Future<Map> getDTRdoc() async {
    Map result = {};
    DocumentReference docRef = userCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('DTRCollection')
        .doc('DTR');
    await docRef.get().then(
      (DocumentSnapshot documentSnapshot) {
        result = documentSnapshot.data() as Map;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return result;
  }

  // Future<Map> getLatestDTRField() async {
  //   Map DTRDoc = await getDTRdoc();
  //   return DTRDoc.values.last as Map;
  // }

  // Future<void> updateTimeCollection(
  //     String docDate, String fieldName, DateTime updatedValue) async {
  //   timeCollection = userDoc.collection('timeCollection');
  //   await timeCollection
  //       .doc(docDate)
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (!documentSnapshot.exists) {
  //       timeCollection.doc(docDate).set({
  //         "sleepSet": "",
  //         "wakeSet": "",
  //         "sleepActual": "",
  //         "wakeActual": ""
  //       });
  //     }
  //   });
  //   timeCollection.doc(docDate).update({fieldName: updatedValue.toString()});
  // }

  Future<void> updateDTRCollection(
      String fieldNameInDTR, Map<String, Map> updatedDTRDoc) async {
    DTRCollection = userDoc.collection('DTRCollection');
    print("in updateDTRCollection function...");
    print(DTRCollection);
    print(updatedDTRDoc);
    await DTRCollection.doc('DTR')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      DTRCollection.doc('DTR').set(updatedDTRDoc);
    });
  }

  Future<void> addSleepActual(DateTime dateTime) async {
    Map<String, Map> DTRdoc = Map.from(await getDTRdoc());
    DateTimeRange fieldNameInDTR = await DB().getCurrentDTR();
    if (DTRdoc.containsKey(fieldNameInDTR.toString())) {
      Map sleepWakeEntries = DTRdoc[fieldNameInDTR.toString()] as Map;
      // Map updatedMap = {};
      // updatedMap.addAll(sleepWakeEntries);
      // updatedMap.addAll({dateTime.toString(): ""});
      // DTRdoc[fieldNameInDTR.toString()] = updatedMap;
      sleepWakeEntries[dateTime.toString()] = "";
      DTRdoc[fieldNameInDTR.toString()] = sleepWakeEntries;
    } else {
      DTRdoc.addAll({
        fieldNameInDTR.toString(): {dateTime.toString(): ""}
      });
    }
    print("current order of DTR: " + DTRdoc.toString());
    await updateDTRCollection(fieldNameInDTR.toString(), DTRdoc);
  }

  Future<void> addWakeActual(DateTime dateTime) async {
    Map<String, Map> DTRdoc = Map.from(await getDTRdoc());
    print("DTRdoc: " + DTRdoc.toString());
    String latestDTRField = sortedDTRdocFields(DTRdoc).first.key.toString();
    print("latestDTRField: " + latestDTRField);
    MapEntry correctSleepActual = sortedDTRdocFields(DTRdoc).first.value.entries
        .firstWhere(((element) => element.value == ""));
    // String latestSleepActual = DTRdoc.values.last.keys.last;
    String latestSleepActual = correctSleepActual.key;
    await rewardCheck(DateTime.parse(latestSleepActual), dateTime);
    print("latestSleepActual: " + latestSleepActual);
    DTRdoc[latestDTRField]![latestSleepActual] = dateTime.toString();
    print("DTRdoc: " + DTRdoc.toString());
    await updateDTRCollection(latestDTRField, DTRdoc);
  }

  Future<void> rewardCheck(DateTime start, DateTime end) async {
    DateTime sleepTimeSet = DateTime.parse(await DB().getUserValue(user!.uid, "sleepTimeSet"));
    DateTime wakeTimeSet = DateTime.parse(await DB().getUserValue(user!.uid, "wakeTimeSet"));
    Duration sleepDurationSet = sleepTimeSet.difference(wakeTimeSet);
  }

  static DateTimeRange stringToDateTimeRange(String DTRstring) {
    List<String> DTRsplit = DTRstring.split(" - ");
    DateTime start = DateTime.parse(DTRsplit.first);
    DateTime end = DateTime.parse(DTRsplit.last);
    return DateTimeRange(start: start, end: end);
  }

  static List<MapEntry<DateTimeRange, Map>> sortedDTRdocFields(Map DTRdoc) {
    List<MapEntry<DateTimeRange, Map>> sortedDTRdoc = [];
    Map<DateTimeRange, Map> mappedDTRDoc = DTRdoc.map((key, value) => MapEntry(stringToDateTimeRange(key), value));
    sortedDTRdoc = mappedDTRDoc.entries.toList();
    sortedDTRdoc.sort(((a, b) {
      DateTime aStart = a.key.start;
      DateTime bStart = b.key.start;
      return bStart.compareTo(aStart);
    }));
    return sortedDTRdoc;
  }

  Future<void> updateTimeSet(DateTime newDateTime, String timeField) async {
    await userDoc.update({timeField: newDateTime.toString()});
  }

  Future<DateTimeRange> getCurrentDTR() async {
    DateTime today = DateTime.now();
    print("today is: " + today.toString());
    DateTime sleepTimeSet = DateTime.parse(await DB()
        .getUserValue(FirebaseAuth.instance.currentUser!.uid, "sleepTimeSet"));
    DateTime start = DateTime(today.year, today.month, today.day,
        sleepTimeSet.hour, sleepTimeSet.minute);
    DateTime wakeTimeSet = DateTime.parse(await DB()
        .getUserValue(FirebaseAuth.instance.currentUser!.uid, "wakeTimeSet"));
    DateTime end = DateTime(today.year, today.month, today.day,
        wakeTimeSet.hour, wakeTimeSet.minute);
    if (start.isAfter(end)) {
      end = end.add(const Duration(days: 1));
    }
    return DateTimeRange(start: start, end: end);
  }

  static DateTime convertTimeOfDayToDateTime(TimeOfDay t) {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, t.hour, t.minute);
  }

  // Future<void> setTime(DateTime dateTime, String fieldName) async {
  //   String docDate = DateFormat("yyyy-MM-dd").format(dateTime);
  //   updateTimeCollection(docDate, fieldName, dateTime);
  // }

  Future<bool> hasAGoal(String uid) async {
    return (await getUserValue(uid, "sleepTimeSet") != "") &&
        (await getUserValue(uid, "wakeTimeSet") != "");
  }

  Future<bool> isSleeping(String uid) async {
    bool flag = false;
    DocumentReference docRef = userCollection.doc(uid);
    await docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        flag = documentSnapshot.get("sleeping");
      }
    });
    return flag;
  }

  Future<void> toggleSleeping(String uid) async {
    bool flag = await isSleeping(uid);
    DocumentReference docRef = userCollection.doc(uid);
    docRef.update({"sleeping": !flag});
  }

  //friend system
  Future<List<String>> getFriendList(String userId) {
    return getList("friends", userId);
  }

  Future<bool> sendFriendRequest(String senderId, String receiverName) async {
    bool succ = false;

    //check whether user search himself
    if (await getUserName(senderId) == receiverName) return false;

    await userCollection
        .where("nickname", isEqualTo: receiverName)
        .get()
        .then((QuerySnapshot querySnapshot) async {
      if (querySnapshot.size == 0) return false;

      DocumentReference requestDoc = querySnapshot.docs.first.reference;

      //check whether this is a existed friend
      if (await isFriend(senderId, requestDoc.id)) return false;
      //check whether there is alr an exist request
      if (await isReqeustExist(requestDoc.id, senderId)) return false;

      requestDoc.update({
        "friendRequest": FieldValue.arrayUnion([senderId])
      });

      succ = true;
    });
    return succ;
  }

  Future<void> receiveFriendRequest(String id1, String id2) async {
    if (await isFriend(id1, id2)) return;

    //add 1 to 2
    DocumentReference docRef1 = userCollection.doc(id1);
    var friends1 = await getFriendList(id1);
    friends1.add(id2);
    await docRef1.update({"friends": friends1});

    //add 2 to 1
    DocumentReference docRef2 = userCollection.doc(id2);
    var friends2 = await getFriendList(id2);
    friends2.add(id1);
    await docRef2.update({"friends": friends2});

    //delete 2 from 1 request list
    var reqList = await getList("friendRequest", id1);
    reqList.remove(id2);
    await docRef1.update({"friendRequest": reqList});
  }

  Future<bool> isFriend(String uid, String targetId) async {
    var friendlist = await getFriendList(uid);
    return friendlist.contains(targetId);
  }

  Future<bool> isReqeustExist(String uid, String targetId) async {
    var targetRequestList = await getFriendRequestList(targetId);
    return targetRequestList.contains(uid);
  }

  Future<List<String>> getFriendRequestList(String userId) {
    return getList("friendRequest", userId);
  }

  //user_profile_pic
  Future<String> getProfileFlower(String uid) async {
    String profileFlowerID = "0";
    DocumentReference currUserDoc = userCollection.doc(uid);

    await currUserDoc.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        profileFlowerID = documentSnapshot.get("profileFlowerID");
      }
    });
    return profileFlowerID == "" ? "0" : profileFlowerID;
  }

  Future<void> updateProfileFlower(String uid, String flowerId) async {
    DocumentReference docRef = userCollection.doc(uid);
    docRef.update({"profileFlowerID": flowerId});
  }
}
