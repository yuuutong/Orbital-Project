import 'package:sleeplah/shop/match.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/configurations/background.dart';

class Body extends StatelessWidget {
  final double defaultSize = SizeConfig.defaultSize!;
  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
      children: <Widget>[
        Container(height: defaultSize * 10),
        Text(
          "~ Unlock your favourite flowers in the shop ~",
          style: TextStyle(color: Colors.white, fontSize: defaultSize * 2),
        ),
        Text(
          "~ 50 coins -> 1 flower ~",
          style: TextStyle(color: Colors.white, fontSize: defaultSize * 2),
        ),
        Container(
            height: defaultSize * 50,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/shop.png"),
                    fit: BoxFit.fill)),
            child: const Match()),
      ],
    ));
  }
}