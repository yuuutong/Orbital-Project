import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/configurations/color_extensions.dart';
import 'package:sleeplah/Database.dart';

class Chart extends StatefulWidget {
  final List<Color> availableColors = const [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
  ];

  final Map chartData;

  Chart(this.chartData, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ChartState(chartData);
}

class ChartState extends State<Chart> {
  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);
  final Map chartData;

  int touchedIndex = -1;

  bool isPlaying = false;

  ChartState(this.chartData);

  List getWeekDays() {
    List result = List.empty(growable: true);
    for (final item in chartData.entries) {
      String date = DateFormat("yyyy-MM-dd").format(item.key);
      String day = '';
      int dayValue = item.key.weekday;
      if (dayValue == 1) {
        day = "Monday";
      }
      if (dayValue == 2) {
        day = "Tuesday";
      }
      if (dayValue == 3) {
        day = "Wednesday";
      }
      if (dayValue == 4) {
        day = "Thursday";
      }
      if (dayValue == 5) {
        day = "Friday";
      }
      if (dayValue == 6) {
        day = "Sat";
      }
      if (dayValue == 7) {
        day = "Sun";
      }
      result.add(day + "\n" + date);
    }
    return result;
  }

  List getDurations() {
    List result = List.empty(growable: true);
    for (final item in chartData.values) {
      double dur = item.inMinutes / 60;
      result.add(double.parse(dur.toStringAsFixed(2)));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: const Color(0xff81e5cd),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  const Text(
                    'Mingguan',
                    style: TextStyle(
                        color: Color(0xff0f4a3c),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Grafik konsumsi kalori',
                    style: TextStyle(
                        color: Color(0xff379982),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: BarChart(
                        isPlaying ? randomData() : mainBarData(),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: const Color(0xff0f4a3c),
                  ),
                  onPressed: () {
                    setState(() {
                      isPlaying = !isPlaying;
                      if (isPlaying) {
                        refreshState();
                      }
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? Colors.yellow : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: Colors.yellow.darken(), width: 1)
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 20,
            color: barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, getDurations()[6], isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, getDurations()[5], isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, getDurations()[4], isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, getDurations()[3], isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, getDurations()[2], isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, getDurations()[1], isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, getDurations()[0], isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = getWeekDays()[6];
                  break;
                case 1:
                  weekDay = getWeekDays()[5];
                  break;
                case 2:
                  weekDay = getWeekDays()[4];
                  break;
                case 3:
                  weekDay = getWeekDays()[3];
                  break;
                case 4:
                  weekDay = getWeekDays()[2];
                  break;
                case 5:
                  weekDay = getWeekDays()[1];
                  break;
                case 6:
                  weekDay = getWeekDays()[0];
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.toY - 1).toString(),
                    style: const TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
      gridData: FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(getWeekDays()[6].substring(0,3), style: style);
        break;
      case 1:
        text = Text(getWeekDays()[5].substring(0,3), style: style);
        break;
      case 2:
        text = Text(getWeekDays()[4].substring(0,3), style: style);
        break;
      case 3:
        text = Text(getWeekDays()[3].substring(0,3), style: style);
        break;
      case 4:
        text = Text(getWeekDays()[2].substring(0,3), style: style);
        break;
      case 5:
        text = Text(getWeekDays()[1].substring(0,3), style: style);
        break;
      case 6:
        text = Text(getWeekDays()[0].substring(0,3), style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  BarChartData randomData() {
    return BarChartData(
      barTouchData: BarTouchData(
        enabled: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: List.generate(7, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 1:
            return makeGroupData(1, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 2:
            return makeGroupData(2, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 3:
            return makeGroupData(3, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 4:
            return makeGroupData(4, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 5:
            return makeGroupData(5, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          case 6:
            return makeGroupData(6, Random().nextInt(15).toDouble() + 6,
                barColor: widget.availableColors[
                    Random().nextInt(widget.availableColors.length)]);
          default:
            return throw Error();
        }
      }),
      gridData: FlGridData(show: false),
    );
  }

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }
}
