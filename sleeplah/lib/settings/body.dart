import 'package:sleeplah/login_page/LoginScreen.dart';
import 'package:sleeplah/configurations/background.dart';
import 'package:sleeplah/configurations/rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/profile_picking/pick_profile_screen.dart';
import '../constant.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Body extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  _signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
        child: SingleChildScrollView(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundedButton(
            press: () {
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
                /* () async {
              // Update the state of the app
              await _signOut();
              if (_firebaseAuth.currentUser == null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              }
            }, */
            text: 'Log Out',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundedButton(
            press: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => profilePage()));
            },
            text: 'Profile Picture',
          ),
        )
      ],
    )));
  }
}
