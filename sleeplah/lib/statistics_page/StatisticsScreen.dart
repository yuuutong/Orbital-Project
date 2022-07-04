import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sleeplah/statistics_page/Chart.dart';
import 'package:sleeplah/database.dart';
import 'package:sleeplah/constant.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'package:sleeplah/configurations/background.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  Map chartData = {};
  bool loading = true;

  @override
  void initState() {
    loading = true;
    getValue();
    super.initState();
  }

  Future<void> getValue() async {
    for (int i = 0; i <= 6; i++) {
      DateTime pastDate = DateTime.now().subtract(Duration(days: i));
      String docDate = DateFormat("yyyy-MM-dd").format(pastDate);
      Map allData = await DB().getTimeCollectionDoc(docDate);
      if (allData.isNotEmpty) {
        DateTime sleepActual = DateTime.parse(allData["sleepActual"]);
        DateTime wakeActual = DateTime.parse(allData["wakeActual"]);
        Duration asleep =
            const Duration(days: 1) - sleepActual.difference(wakeActual);
        chartData[pastDate] = asleep;
      } else {
        chartData[pastDate] = Duration.zero;
      }
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Statistics"),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        body: Background(
            child: Padding(
          padding: EdgeInsets.only(top: 2),
          child: Container(
              child: loading
                  ? const Center(child: Text("loading..."))
                  : Chart(chartData)),
        )));
  }
}
