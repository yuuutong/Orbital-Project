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
  late int numOfLotus = 0;
  late int numOfLily = 0;
  late int numOfTulip = 0;
  late int numOfDays = 0;
  late int coins = 0;
  bool loading = true;

  @override
  void initState() {
    loading = true;
    getValue();
    super.initState();
  }

  Future<void> getValue() async {
    List<String> flowerList = await DB().getFlowerList();
    numOfSunflower = int.parse(flowerList[0]);
    numOfRose = int.parse(flowerList[1]);
    numOfDaisy = int.parse(flowerList[2]);
    numOfLilac = int.parse(flowerList[3]);
    numOfLotus = int.parse(flowerList[4]);
    numOfLily = int.parse(flowerList[5]);
    numOfTulip = int.parse(flowerList[6]);
    numOfDays = await DB().getDays(FirebaseAuth.instance.currentUser!.uid);
    coins = await DB().getCoins();
    setState(() {
      loading = false;
    });
    //print(loading);
  }

  @override
  Widget build(BuildContext context) {
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
        loading ? const Text("loading...") : 
        GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            detail("Sunflower", "0.png", numOfSunflower),
            detail("Rose", "1.png", numOfRose),
            detail("Daisy", "2.png", numOfDaisy),
            detail("Lilac", "3.png", numOfLilac),
            detail("Lotus", "4.png", numOfLotus),
            detail("Lily", "5.png", numOfLily),
            detail("Tulip", "6.png", numOfTulip),
            detail("Coins", "coin.png", coins),
            detail("Days of Consecutive Sleep", "shanna_asleep.png", numOfDays)
          ],
        )
      ]),
    );
  }
}
