import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // new
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';           // new
import 'firebase_options.dart';                    // new
// import 'src/authentication.dart';                  // new
// import 'src/widgets.dart';

import 'package:sleeplah/Screens/Home_Screen.dart';
import 'package:sleeplah/Screens/Login_Screen.dart';

void main()async {
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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: HomeScreen() //LoginScreen(),
    );
  }
}