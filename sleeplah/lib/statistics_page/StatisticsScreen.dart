import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sleeplah/statistics_page/Chart.dart';
import 'package:sleeplah/database.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  // String data = 'test';
  // Map allData = {"yo" : "keyss"};
  Map chartData = {};
  bool loading = true;

  @override
  void initState() {
    loading = true;
    getValue();
    super.initState();
  }

  Future<void> getValue() async {
    for (int i = 1; i <= 7; i++) {
      DateTime pastDate = DateTime.now().subtract(Duration(days: i));
      String docDate = DateFormat("yyyy-MM-dd").format(pastDate);
      Map allData = await DB().getTimeCollectionDoc(docDate);
      if (allData.isNotEmpty) {
        DateTime sleepActual = DateTime.parse(allData["sleepActual"]);
        DateTime wakeActual = DateTime.parse(allData["wakeActual"]);
        Duration asleep = const Duration(days: 1) - sleepActual.difference(wakeActual);
        chartData[pastDate] = asleep;
      } else {
        chartData[pastDate] = Duration.zero;
      }
    }
    // allData = await DB().getTimeCollectionDoc('2022-06-29');
    // data = await DB().getUserName(FirebaseAuth.instance.currentUser.uid);
    print("chartdata in screen: " + chartData.toString());
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statistics")),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.cover),
          ),
          child: loading ? const Center(child: Text("loading...")) : Chart(chartData)
          ),
    );
  }
}
