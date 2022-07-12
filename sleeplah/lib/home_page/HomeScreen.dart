import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:sleeplah/constant.dart';
import 'package:sleeplah/friend_system/friendboard_page.dart';
// import 'package:sleeplah/flower_collection/FlowerCollection.dart';
import 'package:sleeplah/login_page/LoginScreen.dart';
import 'package:sleeplah/NeighbourhoodScreen.dart';
import 'package:sleeplah/main.dart';
import 'package:sleeplah/settings/settings.dart';
import 'package:sleeplah/flowerCollectionHandbook/collection.dart';
import 'package:sleeplah/shop/shop_page.dart';
import 'package:sleeplah/statistics_page/StatisticsScreen.dart';
import 'package:sleeplah/home_page/TimePicker.dart';
import 'package:sleeplah/garden_page/gardenStats.dart';
import 'package:sleeplah/statistics_page/test_time_chart.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'sleepWakeButtons.dart';

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
    SizeConfig().init(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Homepage"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        Column(children: [
          Spacer(flex: 2),
          Flexible(fit: FlexFit.tight, flex: 4, child: TimePicker()),
          Spacer(flex: 1),
          Flexible(fit: FlexFit.tight, flex: 2, child: sleepWakeButtons()),
          Spacer(flex: 1),
          Flexible(
            fit: FlexFit.tight,
            flex: 9,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: const <Widget>[
                  Image(
                    image: AssetImage("assets/images/sunflower_field.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ],
              ),
            ),
          )
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
                color: primaryColor,
              ),
              child: Text('SleepLah!'),
            ),
            // ListTile(
            //   title: const Text('Flower Collection'),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const FlowerCollection()));
            //   },
            // ),
            ListTile(
              title: const Text('Flower Shop'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Shop()));
              },
            ),
            ListTile(
              title: const Text('Garden Statistics Dashboard'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const gardenStats()));
              },
            ),
            ListTile(
              title: const Text('Sleeping Statistics'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Statistics()));
              },
            ),
            ListTile(
              title: const Text('Leaderboard'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Friendboard()));
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
              title: const Text('Flower Collection Handbook'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Collection()));
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('test time chart'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => timeChart([
                            DateTimeRange(
                              start: DateTime(2021, 2, 24, 23, 15),
                              end: DateTime(2021, 2, 25, 7, 30),
                            ),
                            DateTimeRange(
                              start: DateTime(2021, 2, 22, 1, 55),
                              end: DateTime(2021, 2, 22, 9, 12),
                            ),
                            DateTimeRange(
                              start: DateTime(2021, 2, 20, 0, 25),
                              end: DateTime(2021, 2, 20, 7, 34),
                            ),
                            DateTimeRange(
                              start: DateTime(2021, 2, 17, 21, 23),
                              end: DateTime(2021, 2, 18, 4, 52),
                            ),
                            DateTimeRange(
                              start: DateTime(2021, 2, 13, 6, 32),
                              end: DateTime(2021, 2, 13, 13, 12),
                            ),
                            DateTimeRange(
                              start: DateTime(2021, 2, 1, 9, 32),
                              end: DateTime(2021, 2, 1, 15, 22),
                            ),
                            DateTimeRange(
                              start: DateTime(2021, 1, 22, 12, 10),
                              end: DateTime(2021, 1, 22, 16, 20),
                            ),
                          ])),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
