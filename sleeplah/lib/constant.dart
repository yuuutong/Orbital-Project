import 'package:flutter/material.dart';

const primaryColor = Colors.blue;
const themePrimaryColor = Colors.blueAccent;
const themeSecondaryColor = Colors.cyan;
const String flower_profile_path = "assets/images/";
String date =
    "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
String selectedFlower = '0';
DateTime todoStartDate = DateTime.now();