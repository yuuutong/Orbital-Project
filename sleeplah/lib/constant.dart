import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 147, 184, 248);
const themePrimaryColor = Color.fromARGB(255, 123, 170, 251);
const themeSecondaryColor = Color.fromARGB(255, 174, 245, 254);
const darkColor = Colors.blue;
const String flower_profile_path = "assets/images/";
String date =
    "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
String selectedFlower = '0';
DateTime todoStartDate = DateTime.now();