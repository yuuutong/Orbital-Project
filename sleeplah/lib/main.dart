import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sleeplah/Screens/Home_Screen.dart';

import 'login/log_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SleepLah!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen()//LoginScreen(),
    );
  }
}
