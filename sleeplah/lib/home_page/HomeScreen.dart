import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/constant.dart';
import 'package:sleeplah/friend_system/friendboard_page.dart';
import 'package:sleeplah/settings/settings.dart';
import 'package:sleeplah/flowerCollectionHandbook/collection.dart';
import 'package:sleeplah/shop/shop_page.dart';
import 'package:sleeplah/statistics_page/body.dart';
import 'package:sleeplah/home_page/TimePicker.dart';
import 'package:sleeplah/garden_page/gardenStats.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'package:sleeplah/home_page/actualSleepWake.dart';
import 'package:sleeplah/statistics_page/stats.dart';

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
          const Spacer(flex: 2),
          Flexible(fit: FlexFit.tight, flex: 4, child: TimePicker()),
          const Spacer(flex: 1),
          const Flexible(fit: FlexFit.tight, flex: 2, child: Actual()),
          const Spacer(flex: 1),
          Flexible(
            fit: FlexFit.tight,
            flex: 8,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Color.fromARGB(255, 48, 146, 226),
                            spreadRadius: 5)
                      ],
                    ),
                    child: const CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage("assets/images/hp4.gif"),
                      radius: 200,
                    ),
                  )
                ],
              ),
            ),
          ),
          const Spacer(flex: 1),
        ])
      ]),
      drawer: Drawer(
        backgroundColor: darkColor,
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              color: themePrimaryColor,
              child: const DrawerHeader(
                child: FittedBox(child: Text('SleepLah!')),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.shopify_sharp),
              title: const Text('Flower Shop'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Shop()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Garden Statistics Dashboard'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const gardenStats()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.bed),
              title: const Text('Sleeping Statistics'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => stats()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.leaderboard),
              title: const Text('Leaderboard'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Friendboard()));
              },
            ),
            /* ListTile(
              title: const Text('Neighbourhood'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Neighbourhood()));
              },
            ), */
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Flower Collection Handbook'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Collection()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Update the state of the app
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
                // Then close the drawer
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
