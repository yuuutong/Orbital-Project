import 'package:flutter/material.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'body.dart';

class Friendboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Leaderboard'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(
            labelStyle: TextStyle(fontSize: 19.0, fontFamily: "IndieFlower"),
            unselectedLabelStyle:
                TextStyle(fontSize: 17.0, fontFamily: "IndieFlower"),
            tabs: <Widget>[
              Tab(
                text: "Consecutive Days",
              ),
              Tab(
                text: "Total Flowers",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[Body("days"), Body("flowers")],
        ),
      ),
    );
  }
}
