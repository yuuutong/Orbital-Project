import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/Component/startSleepingButton.dart';
import 'package:sleeplah/Component/wakeUpButton.dart';
import 'package:sleeplah/Screens/Garden.dart';
import 'package:sleeplah/login/log_in.dart';
import 'package:sleeplah/Screens/Neighbourhood.dart';
import 'package:sleeplah/Screens/Settings.dart';
import 'package:sleeplah/Screens/Statistics.dart';
import 'package:sleeplah/Component/time_picker.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

_signOut() async {
  await _firebaseAuth.signOut();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: Stack(children: [
        const Positioned.fill(
            child: Image(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.fitHeight,
        )),
        Column(children: [
          Flexible(fit: FlexFit.tight, flex: 1, child: TimePicker()),
          Flexible(fit: FlexFit.tight, flex: 1, child: startSleepingButton("Sleep Now")),
          Flexible(fit: FlexFit.tight, flex: 1, child: wakeUpButton("I'm awake!")),
          Flexible(
              fit: FlexFit.tight,
              flex: 3,
              child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Image(
                      image: AssetImage("assets/images/field.png"))))
        ])
      ]),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('SleepLah!'),
            ),
            ListTile(
              title: const Text('Garden'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Garden()));
              },
            ),
            ListTile(
              title: const Text('Statistics'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Statistics()));
              },
            ),
            ListTile(
              title: const Text('Neighbourhood'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Neighbourhood()));
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Settings()));
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                // Update the state of the app
                await _signOut();
                if (_firebaseAuth.currentUser == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
