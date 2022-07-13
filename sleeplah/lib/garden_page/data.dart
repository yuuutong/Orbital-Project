import 'package:sleeplah/login_page/LoginScreen.dart';
import 'package:sleeplah/models/flowers.dart';
import '../database.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import '../SizeConfig.dart';
import 'package:sleeplah/configurations/loading.dart';
import 'package:sleeplah/garden_page/garden_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class data extends StatefulWidget {
  @override
  _dataState createState() => _dataState();
}

class _dataState extends State<data> {
  List<String> flowerList = [];
  bool loading = true;
  double defaultSize = SizeConfig.defaultSize!;
  double screenHeight = SizeConfig.screenHeight!;
  double screenWidth = SizeConfig.screenWidth!;
  late int numOfSunflower = 1;
  late int numOfRose = 0;
  late int numOfDaisy = 0;
  late int numOfLilac = 0;
  late int numOfLotus = 0;
  late int numOfLily = 0;
  late int numOfTulip = 0;
  late int numOfDays = 0;
  late int coins = 0;

  @override
  void initState() {
    getValue();
    super.initState();
  }

  Future<void> getValue() async {
    flowerList = await DB().getFlowerList();
    numOfSunflower = int.parse(flowerList[0]);
    numOfRose = int.parse(flowerList[1]);
    numOfDaisy = int.parse(flowerList[2]);
    numOfLilac = int.parse(flowerList[3]);
    numOfLotus = int.parse(flowerList[4]);
    numOfLily = int.parse(flowerList[5]);
    numOfTulip = int.parse(flowerList[6]);
    numOfDays = await DB().getDays(FirebaseAuth.instance.currentUser!.uid);
    coins = await DB().getCoins(FirebaseAuth.instance.currentUser!.uid);

    // make changes here

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(margin: EdgeInsets.fromLTRB(0, defaultSize * 6,
            0, 0),
          child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                detail("Coins", "coin.png", coins),
                detail(
                    "Days", "shanna_asleep.png", numOfDays),
                detail("Sunflower", "0.png", numOfSunflower),
                detail("Rose", "1.png", numOfRose),
                detail("Daisy", "2.png", numOfDaisy),
                detail("Lilac", "3.png", numOfLilac),
                detail("Lotus", "4.png", numOfLotus),
                detail("Lily", "5.png", numOfLily),
                detail("Tulip", "6.png", numOfTulip),
              ],
            ),
        );
  }
}
