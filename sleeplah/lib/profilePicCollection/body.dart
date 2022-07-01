import 'package:sleeplah/profilePicCollection/selection.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/configurations/background.dart';
import '../SizeConfig.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;

    return Background(
        child: Padding(
            padding:
                EdgeInsets.only(top: defaultSize * 5, right: defaultSize * 0.5),
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/0.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Selection())));
  }
}