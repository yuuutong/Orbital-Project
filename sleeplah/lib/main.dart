import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'FirebaseOptions.dart';
import 'package:sleeplah/home_page/HomeScreen.dart';
import 'package:sleeplah/login_page/LoginScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          fontFamily: 'IndieFlower',
          primarySwatch: Colors.blue,
        ),
        home: 
          LoginScreen(), 
          //HomeScreen(),
        );
  }
}
