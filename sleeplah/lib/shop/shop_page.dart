import 'package:sleeplah/home_page/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'body.dart';

class Shop extends StatelessWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("Flower Shop"),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Body());
  }
}