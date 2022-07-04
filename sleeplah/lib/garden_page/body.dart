import 'package:sleeplah/garden_page/gardenStats.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/configurations/background.dart';
import '../SizeConfig.dart';
import 'package:sleeplah/garden_page/garden_details.dart';
import 'package:sleeplah/configurations/loading.dart';
import 'package:sleeplah/garden_page/data.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;

    return Background(
      child: Stack(children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        data()
      ]),
    );
  }
}
