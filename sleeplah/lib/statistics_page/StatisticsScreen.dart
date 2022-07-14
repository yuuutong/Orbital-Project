import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sleeplah/database.dart';
import 'package:sleeplah/constant.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'package:sleeplah/configurations/background.dart';
import 'package:sleeplah/statistics_page/test_time_chart.dart';
import '../configurations/loading.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  // Map chartData = {};
  List<DateTimeRange> dataList = [];
  bool loading = true;

  @override
  void initState() {
    loading = true;
    getValue();
    super.initState();
  }

  Future<void> getValue() async {
    // for (int i = 0; i <= 6; i++) {
    //   DateTime pastDate = DateTime.now().subtract(Duration(days: i));
    //   String docDate = DateFormat("yyyy-MM-dd").format(pastDate);
    //   Map allData = await DB().getTimeCollectionDoc(docDate);
    //   Duration asleep = Duration.zero;
    //   if (allData.isNotEmpty) {
    //     if (!allData.values.contains("")) {
    //       DateTime sleepActual = DateTime.parse(allData["sleepActual"]);
    //       DateTime wakeActual = DateTime.parse(allData["wakeActual"]);
    //       if (sleepActual.isBefore(wakeActual)) {
    //         asleep = wakeActual.difference(sleepActual);
    //       } else {
    //         asleep =
    //             const Duration(days: 1) - sleepActual.difference(wakeActual);
    //       }
    //     }
    //   }
    //   chartData[pastDate] = asleep;
    // }
    // print(chartData);

    Map DTRDoc = await DB().getDTRdoc();
    for (Map sleepWakeMap in DTRDoc.values) {
      for (MapEntry sleepWakePair in sleepWakeMap.entries) {
        if (sleepWakePair.value != "" && sleepWakePair.value != true) {
          dataList.add(DateTimeRange(
              start: DateTime.parse(sleepWakePair.key),
              end: DateTime.parse(sleepWakePair.value)));
        }
      }
    }
    dataList.sort((a, b) => b.start.compareTo(a.start));
    print("datalist: \n" + dataList.toString());

    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeSecondaryColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Statistics"),
        foregroundColor: Colors.black,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 2),
          child: Container(
            child: loading
                ? Loading() //const Center(child: Text("loading..."))
                : timeChart(dataList),
                // : Chart(chartData),
          ),
        ),
      ),
    );
  }
}
