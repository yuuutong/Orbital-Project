import 'package:sleeplah/login_page/LogIn.dart';
import 'package:sleeplah/login_page/LoginScreen.dart';
import 'package:sleeplah/models/flowers.dart';
import 'package:sleeplah/database.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'dart:math';

import '../../constant.dart';

class Match extends StatefulWidget {
  const Match({Key? key}) : super(key: key);

  @override
  _MatchState createState() => _MatchState();
}

class _MatchState extends State<Match> {
  double defaultSize = SizeConfig.defaultSize!;
  double screenHeight = SizeConfig.screenHeight!;
  double screenWidth = SizeConfig.screenWidth!;
  bool _bigger = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: defaultSize * 30,
      ),
      TextButton(
        onPressed: () => _matchDialogWidget(),
        style: TextButton.styleFrom(
            primary: primaryColor,
            backgroundColor: primaryColor,
            shadowColor: Colors.yellow,
            elevation: 10,
            padding: EdgeInsets.fromLTRB(defaultSize * 5, defaultSize * 1.2,
                defaultSize * 5, defaultSize * 1.2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(defaultSize * 3.6), //36
                side: const BorderSide(color: Colors.white))),
        child: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor: Colors.yellow,
            enabled: true,
            child: Text("Purchase", style: TextStyle(fontSize: defaultSize * 3))),
      )
    ]);
  }

  Future<void> _matchDialogWidget() async {
    String message = "";
    bool success = true;

    if (!await hasEnoughCoins()) {
      message = "You don't have enough coins mew ~";
      success = false;
    }

    var selectedFlower = await pickFlower();

    if (selectedFlower.id == "0") {
      message = "Fufu~ seems like you already know everyone";
      success = false;
    }

    if (success) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
                title:
                    Text("Mystery shop owner has introduce you a new friend!"),
                content: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  padding: _bigger
                      ? EdgeInsets.all(defaultSize)
                      : EdgeInsets.all(defaultSize * 10),
                  child: Image(
                    image: AssetImage(
                        "$flower_profile_path${selectedFlower.id}.png"),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        _bigger = false;
                        Navigator.of(context).pop();
                      },
                      child: Text("Yay"))
                ],
              ));
      _bigger = true;
      //minus coins
      DB().updateCoin(-50);
      //add Flowers
      DB().addFlower(user!.uid, selectedFlower.id);
    } else {
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: Text(message),
                content: Container(
                  height: screenHeight * 0.2,
                ),
              ));
    }
  }

  //a func that pick the Flower
  Future<Flower> pickFlower() async {
    var userFlowers = await DB().getFlowerList(user?.uid ?? "000");
    List<Flower> uncatchFlowers = [];
    for (var Flower in FlowerList) {
      if (!userFlowers.contains(Flower.id)) uncatchFlowers.add(Flower);
    }

    var _random = Random();

    return uncatchFlowers.length == 0
        ? FlowerList.first
        : uncatchFlowers[_random.nextInt(uncatchFlowers.length)];
  }

  //a func that determine whether the user has enough stars
  Future<bool> hasEnoughCoins() async {
    return await DB().getCoins() >= 50;
  }
}