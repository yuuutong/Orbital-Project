import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sleeplah/database.dart';
import 'package:sleeplah/constant.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'package:sleeplah/configurations/background.dart';
import 'package:sleeplah/statistics_page/TimeChart.dart';
import 'package:sleeplah/statistics_page/stats.dart';
import '../configurations/loading.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState(this.category);
  late List<DateTimeRange> dataList;
  String category;
  Body(this.category);
}

class _BodyState extends State<Body> {
  List<DateTimeRange> dataList = [];
  String category = "";
  bool loading = true;
  _BodyState(this.category);

  @override
  void initState() {
    loading = true;
    getValue();
    super.initState();
  }

  Future<void> getValue() async {
    Map DTRDoc = await DB().getDTRdoc();
    for (Map sleepWakeMap in DTRDoc.values) {
      for (MapEntry sleepWakePair in sleepWakeMap.entries) {
        if (sleepWakePair.value != "" && sleepWakePair.value != true) {
          dataList.add(
            DateTimeRange(
              start: DateTime.parse(sleepWakePair.key),
              end: DateTime.parse(sleepWakePair.value),
            ),
          );
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
    return loading
        ? Loading()
        : SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    timeChart(dataList, "${category} distribution"),
                    timeChart(dataList, "${category} duration")
                  ],
                ),
              ),
            ),
          );
  }
}
