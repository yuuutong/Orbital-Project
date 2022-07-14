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
    numOfDays = await DB().getDays(FirebaseAuth.instance.currentUser!.uid);
    coins = await DB().getCoins(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            margin: EdgeInsets.fromLTRB(0, defaultSize * 6, 0, 0),
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.all(8.0),
              children: tiles(),
            ),
          );
  }

  List<Widget> tiles() {
    List<Flower> unlockedFlower = [];
    List<Widget> result = [];
    result.add(detail("Coins", "coin.png", coins));
    result.add(detail("Days", "shanna_asleep.png", numOfDays));
    for (Flower f in FlowerList) {
      if (flowerList[int.parse(f.id)] != "0") unlockedFlower.add(f);
    }
    for (Flower f in unlockedFlower) {
      result.add(detail(
          f.name, '${f.id}.png', int.parse(flowerList[int.parse(f.id)])));
    }
    return result;
  }
}
