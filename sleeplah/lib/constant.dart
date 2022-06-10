import 'package:flutter/material.dart';

const primaryColor = Color.fromARGB(255, 59, 53, 114);
const themePrimaryColor = Color.fromARGB(255, 80, 53, 169);
const themeSecondaryColor = Color.fromARGB(255, 194, 188, 243);
const distinctPurple = Color.fromARGB(255, 128, 2, 255);
// const String animal_profile_path = "assets/image/animal_profile/";
String date =
    "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}";
// String selectedAnimal = '0';
DateTime todoStartDate = DateTime.now();