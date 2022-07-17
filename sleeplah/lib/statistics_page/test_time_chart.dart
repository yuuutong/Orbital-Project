import 'package:flutter/material.dart';
import 'package:time_chart/time_chart.dart';
import 'package:sleeplah/constant.dart';

class timeChart extends StatelessWidget {
  List<DateTimeRange> dataList;

  timeChart(this.dataList);

  @override
  Widget build(BuildContext context) {
    final sizedBox = const SizedBox(height: 16);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Theme(
          data: ThemeData.dark(),
          child: Column(
            children: [
              const Text(
                'Sleeping Distribution In A Week',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 52, 165)),
              ),
              TimeChart(
                data: dataList,
                viewMode: ViewMode.weekly,
                barColor: themePrimaryColor,
                tooltipBackgroundColor: primaryColor,
              ),
              sizedBox,
              const Text(
                'Sleep Duration In A Week',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 52, 165)),
              ),
              TimeChart(
                data: dataList,
                chartType: ChartType.amount,
                viewMode: ViewMode.weekly,
                barColor: themePrimaryColor,
                tooltipBackgroundColor: primaryColor,
              ),
              sizedBox,
              const Text(
                'Sleeping Distribution In A Month',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 52, 165)),
              ),
              TimeChart(
                data: dataList,
                viewMode: ViewMode.monthly,
                barColor: themePrimaryColor,
                tooltipBackgroundColor: primaryColor,
              ),
              sizedBox,
              const Text(
                'Sleep Duration In A Month',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 84, 52, 165)),
              ),
              TimeChart(
                data: dataList,
                chartType: ChartType.amount,
                viewMode: ViewMode.monthly,
                barColor: themePrimaryColor,
                tooltipBackgroundColor: primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
