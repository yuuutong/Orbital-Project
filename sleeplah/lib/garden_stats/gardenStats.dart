import 'package:flutter/material.dart';
import 'package:sleeplah/garden_stats/garden_details.dart';
import '../database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class gardenStats extends StatefulWidget {
  const gardenStats({Key? key}) : super(key: key);

  @override
  State<gardenStats> createState() => _gardenStatsState();
}

class _gardenStatsState extends State<gardenStats> {
  /* Future<int> getNumOfSunflower() async {
    return await DatabaseService().getFlowerNum("sunflower");
  } */
  //int numOfSunflower = await DatabaseService().getFlowerNum("sunflower");
  /* @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    await DatabaseService().getFlowerNum("sunflower");
    setState(() {});
  } */ 

  late int numOfSunflower = 0;
  late int numOfRose = 0;
  late int numOfDaisy = 0;
  late int numOfLilac = 0;

  void getDataFlower() async {
    try {
      int data1 = await DB().getFlowerNum("sunflower", FirebaseAuth.instance.currentUser.uid);
      int data2 = await DB().getFlowerNum("rose", FirebaseAuth.instance.currentUser.uid);
      int data3 = await DB().getFlowerNum("daisy", FirebaseAuth.instance.currentUser.uid);
      int data4 = await DB().getFlowerNum("lilac", FirebaseAuth.instance.currentUser.uid);
      setState(() {
        numOfSunflower = data1;
        numOfRose = data2;
        numOfDaisy = data3;
        numOfLilac = data4;
      });
    } catch (ex) {
      print("aabcdefg");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    getDataFlower();
    // return FutureBuilder()
    return Scaffold(
      appBar: AppBar(
        title: const Text("Garden Statistics Dashboard"),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: Stack(children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            detail("Sunflower", "sunflower.png", numOfSunflower),
            detail("Rose", "rose.png", 0),//numOfRose),
            detail("Daisy", "daisy.png", 0),//numOfDaisy),
            detail("Lilac", "lilac.png", 0),//numOfLilac),
            detail("Coins", "coin.png", 0),
            detail("Days of Consecutive Sleep", "shanna_asleep.png", 0)
          ],
        )
      ]),
    );
  }
}
