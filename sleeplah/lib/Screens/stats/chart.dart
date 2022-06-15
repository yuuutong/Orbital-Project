import 'dart:async';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:sleeplah/Login/log_in.dart';
import 'package:sleeplah/Component/loading.dart';
import 'package:sleeplah/constant.dart';
import 'package:sleeplah/database.dart';
import 'package:sleeplah/size_config.dart';
import 'package:flutter/gestures.dart';

//https://github.com/imaNNeoFighT/fl_chart/blob/master/example/lib/bar_chart/samples/bar_chart_sample1.dart
//fi chart sample code 1

class Chart extends StatefulWidget {
  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  final Color barBackgroundColor = Colors.grey[200]!;
  final Duration animDuration = const Duration(milliseconds: 250);
  List<double> weekHours = [0, 0, 0, 0, 0, 0, 0];
  bool loading = true;

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  void initState() {
    hourOfTheDay().then((value) {
      setState(() {
        loading = false;
      });
    });
    print("initializing");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize!;

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(SizeConfig.defaultSize! * 1.8),
            child: Text(
              'Weekly Sleeping Time',
              style: TextStyle(
                color: themeSecondaryColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          loading
              ? Loading()
              : Padding(
                  padding: EdgeInsets.fromLTRB(
                      defaultSize * 2, 0, defaultSize * 2, defaultSize * 1.6),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      color: primaryColor,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.all(defaultSize * 1.6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                /*
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'help making Coma\'s dreams come true',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),

                           */
                                const SizedBox(
                                  height: 38,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: BarChart(
                                      mainBarData(),
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
                        ],
                      ),
                    ),
                  ))
        ]);
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
          color: isTouched ? themePrimaryColor : themeSecondaryColor,
          width: width,
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
            return makeGroupData(0, weekHours[0], isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, weekHours[1], isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, weekHours[2], isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, weekHours[3], isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, weekHours[4], isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, weekHours[5], isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, weekHours[6], isTouched: i == touchedIndex);
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
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toString(),
                    style: TextStyle(
                      color: themeSecondaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
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

  Future<void> hourOfTheDay() async {
    DateTime date = DateTime.now();
    int currDay = date.weekday; //Monday -> 1
    int fromCurrToMon = currDay - 1;
    DateTime monday = date.subtract(Duration(days: fromCurrToMon));

    for (int i = 0; i < 7; i++) {
      DateTime thisDay = monday.add(Duration(days: i));
      String date =
          "${thisDay.year}-${thisDay.month.toString().padLeft(2, '0')}-${thisDay.day.toString().padLeft(2, '0')}";

      await DatabaseService().getTimeOfTheDay(user!.uid, date).then((value) {
        setState(() {
          weekHours[i] = value.roundToDouble();
        });
      });
    }
  }
}
