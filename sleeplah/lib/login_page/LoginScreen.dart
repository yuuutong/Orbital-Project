import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'LogIn.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
// late User? user;
User? user;

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    auth.userChanges().listen((event) => setState(() => user = event));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LogIn(),
    );
  }
}