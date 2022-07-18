import 'package:flutter/material.dart';
import 'package:time_chart/time_chart.dart';
import 'package:sleeplah/constant.dart';
import 'package:sleeplah/statistics_page/stats.dart';
import 'package:sleeplah/statistics_page/body.dart';

class timeChart extends StatelessWidget {
  List<DateTimeRange> dataList;
  String category;
  timeChart(this.dataList, this.category);

  @override
  Widget build(BuildContext context) {
    final sizedBox = const SizedBox(height: 16);

    /*return SingleChildScrollView(
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
              Body(/* dataList,  */"weekly"), */
    if (category == "weekly distribution") {
      return Column(
        children: [
          sizedBox,
          const Text(
            'Sleep Distribution In A Week',
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
        ],
      );
    } else if (category == "weekly duration") {
      return Column(
        children: [
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
        ],
      );
    } else if (category == "monthly distribution") {
      return Column(
        children: [
          sizedBox,
          const Text(
            'Sleep Distribution In A Month',
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
        ],
      );
    } else {
      return Column(
        children: [
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
      );
    }

    /* sizedBox,
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
    ); */
  }
}
