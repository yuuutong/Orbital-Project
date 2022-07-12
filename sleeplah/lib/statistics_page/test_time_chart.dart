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
              const Text('Weekly time chart'),
              TimeChart(
                data: dataList,
                viewMode: ViewMode.weekly,
                barColor: themePrimaryColor,
                tooltipBackgroundColor: primaryColor,
              ),
              sizedBox,
              const Text('Weekly amount chart'),
              TimeChart(
                data: dataList,
                chartType: ChartType.amount,
                viewMode: ViewMode.weekly,
                barColor: themePrimaryColor,
                tooltipBackgroundColor: primaryColor,
              ),
              sizedBox,
              const Text('Monthly time chart'),
              TimeChart(
                data: dataList,
                viewMode: ViewMode.monthly,
                barColor: themePrimaryColor,
                tooltipBackgroundColor: primaryColor,
              ),
              sizedBox,
              const Text('Monthly amount chart'),
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
