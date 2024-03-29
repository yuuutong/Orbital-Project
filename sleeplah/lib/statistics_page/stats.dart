import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/main.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'TimeChart.dart';
import 'package:sleeplah/statistics_page/body.dart';
import 'package:sleeplah/constant.dart';

class stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: darkColor,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text('Sleeping Statistics'),
          foregroundColor: Colors.black,
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          bottom: const TabBar(
            labelColor: Colors.black,
            labelStyle: TextStyle(fontSize: 20.0, fontFamily: "IndieFlower"),
            unselectedLabelStyle:
                TextStyle(fontSize: 17.0, fontFamily: "IndieFlower"),
            tabs: <Widget>[
              Tab(
                text: "weekly",
              ),
              Tab(
                text: "monthly",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[Body("weekly"), Body("monthly")],
        ),
      ),
    );
  }
}
