import 'package:flutter/material.dart';
import 'package:sleeplah/garden_page/garden_details.dart';
import '../database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class gardenStats extends StatefulWidget {
  const gardenStats({Key? key}) : super(key: key);

  @override
  State<gardenStats> createState() => _gardenStatsState();
}

class _gardenStatsState extends State<gardenStats> {

  late int numOfSunflower = 1;
  late int numOfRose = 0;
  late int numOfDaisy = 0;
  late int numOfLilac = 0;

  /* void getDataFlower() async {
    try {
      int data1 = await DB().getFlowerList(FirebaseAuth.instance.currentUser.uid).elementAt(0).getNum(); // sunflower is at index 0 in the list, get its num
      int data2 = await DB().getFlowerList(FirebaseAuth.instance.currentUser.uid).elementAt(1).getNum();
      int data3 = await DB().getFlowerList(FirebaseAuth.instance.currentUser.uid).elementAt(2).getNum();
      int data4 = await DB().getFlowerList(FirebaseAuth.instance.currentUser.uid).elementAt(3).getNum();
      setState(() {
        numOfSunflower = data1;
        numOfRose = data2;
        numOfDaisy = data3;
        numOfLilac = data4;
      });
    } catch (ex) {
      print(ex);
    }
  } */
  
  @override
  Widget build(BuildContext context) {
    //getDataFlower();
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
            detail("Sunflower", "0.png", numOfSunflower),
            detail("Rose", "1.png", 0),//numOfRose),
            detail("Daisy", "2.png", 0),//numOfDaisy),
            detail("Lilac", "3.png", 0),//numOfLilac),
            detail("Coins", "coin.png", 0),
            detail("Days of Consecutive Sleep", "shanna_asleep.png", 0)
          ],
        )
      ]),
    );
  }
}
