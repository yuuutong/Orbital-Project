import 'package:flutter/material.dart';
import 'package:sleeplah/configurations/loading.dart';
import 'package:sleeplah/garden_page/garden_details.dart';
import '../database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sleeplah/garden_page/body.dart';

class gardenStats extends StatefulWidget {
  const gardenStats({Key? key}) : super(key: key);

  @override
  State<gardenStats> createState() => _gardenStatsState();
}

class _gardenStatsState extends State<gardenStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Garden Statistics Dashboard"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Body());
  }
}
