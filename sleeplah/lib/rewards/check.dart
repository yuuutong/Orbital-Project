import 'dart:async';
import 'dart:collection';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/Login/log_in.dart';
import 'package:sleeplah/models/app_user.dart';
import 'package:sleeplah/database.dart';

class check {
  //bool ifOnTime = false;

  Future<bool> compareTime(String date) async {
    String sleepTimeSet = await DB().getSleepTime(date);
    String sleepTimeActual = await DB().getActualSleepTime(date);
    String wakeTimeSet = await DB().getWakeTime(date);
    String wakeTimeActual = await DB().getActualWakeTime(date);

    /* int hourSleepSet = await DatabaseService().getHour(sleepTimeSet);
    int minuteSleepSet = await DatabaseService().getMinute(sleepTimeSet);
    
    int hourSleepActual = await DatabaseService().getHour(sleepTimeActual);
    int minuteSleepActual = await DatabaseService().getMinute(sleepTimeActual);

    int hourWakeActual = await DatabaseService().getHour(wakeTimeActual);
    int minuteWakeActual = await DatabaseService().getMinute(wakeTimeActual);

    int hourWakeSet = await DatabaseService().getHour(wakeTimeSet);
    int minuteWakeSet = await DatabaseService().getMinute(wakeTimeSet); */
    DateTime sleepSet =
        await DB().convertToDateTime(date, sleepTimeSet);
    DateTime sleepActual =
        await DB().convertToDateTime(date, sleepTimeActual);
    DateTime wakeSet =
        await DB().convertToDateTime(date, wakeTimeSet);
    DateTime wakeActual =
        await DB().convertToDateTime(date, wakeTimeActual);
    return ((!sleepActual.isAfter(sleepSet)) && (!wakeActual.isAfter(wakeSet)));
  }
}
