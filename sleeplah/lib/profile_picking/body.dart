import 'package:sleeplah/configurations/loading.dart';
import '../database.dart';
import 'package:sleeplah/profile_picking/info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../SizeConfig.dart';
import 'package:sleeplah/configurations/background.dart';

class Body extends StatefulWidget {
  final User? user;
  Body(this.user);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  late String name;
  int stars = 0;
  String userFlower = "0";
  bool loading = true;

  Future<void> getData() async {
    name = await DB().getUserName(widget.user!.uid);
    stars = await DB().getCoins(widget.user!.uid);
    userFlower = await DB().getProfileFlower(widget.user!.uid);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;

    return loading
        ? Loading()
        : Background(
            child: Padding(
                padding: EdgeInsets.only(top: defaultSize * 5),
                child: Stack(children: [
                  Column(
                    children: <Widget>[
                      Info(
                        name: name,
                        userFlower: userFlower,
                      ),
                    ],
                  ),
                ])));
  }
}
