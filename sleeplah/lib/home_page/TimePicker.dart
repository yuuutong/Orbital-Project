import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:intl/intl.dart';
import 'package:sleeplah/database.dart';

import '../configurations/loading.dart';

class TimePicker extends StatefulWidget {
  @override
  State<TimePicker> createState() => TimePickerState();
}

class TimePickerState extends State<TimePicker> {
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  bool loading = true;

  @override
  void initState() {
    loading = true;
    getValue();
    super.initState();
  }

  Future<void> getValue() async {
    String sleepTimeSet = await DB()
        .getUserValue(FirebaseAuth.instance.currentUser!.uid, "sleepTimeSet");
    String wakeTimeSet = await DB()
        .getUserValue(FirebaseAuth.instance.currentUser!.uid, "wakeTimeSet");
    try {
      if (sleepTimeSet != "") {
        startTime = TimeOfDay.fromDateTime(DateTime.parse(sleepTimeSet));
      }
      if (wakeTimeSet != "") {
        endTime = TimeOfDay.fromDateTime(DateTime.parse(wakeTimeSet));
      }
      print('used new fx');
    } catch (e) {
      print(e);
    }

    setState(() {
      loading = false;
      print('time picker loading complete!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      //sets up the two clocks side by side
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(flex: 1),
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: _buildTimePick("Sleeping Goal", true, startTime, (x) {
            setState(() {
              DB().updateTimeSet(
                  DB.convertTimeOfDayToDateTime(x), "sleepTimeSet");
              // DB().setTime(DB.convertTimeOfDayToDateTime(x), "sleepSet");
              startTime = x;
              print("The picked time is: $x");
            });
          }),
        ),
        const Spacer(flex: 1),
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: _buildTimePick("Wakeup Goal", true, endTime, (x) {
            setState(() {
              DB().updateTimeSet(
                  DB.convertTimeOfDayToDateTime(x), "wakeTimeSet");
              // DB().setTime(DB.convertTimeOfDayToDateTime(x), "wakeSet");
              endTime = x;
              print("The picked time is: $x");
            });
          }),
        ),
        const Spacer(flex: 1),
      ],
    );
  }

  Future selectedTime(BuildContext context, bool ifPickedTime,
      TimeOfDay initialTime, Function(TimeOfDay) onTimePicked) async {
    var _pickedTime =
        await showTimePicker(context: context, initialTime: initialTime);
    if (_pickedTime != null) {
      onTimePicked(_pickedTime);
    }
  }

  Widget _buildTimePick(String title, bool ifPickedTime, TimeOfDay currentTime,
      Function(TimeOfDay) onTimePicked) {
    TimeOfDay alarmTime = TimeOfDay.fromDateTime(DB
        .convertTimeOfDayToDateTime(currentTime)
        .subtract(const Duration(minutes: 5)));
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            fit: FlexFit.tight, flex: 2, child: FittedBox(child: Text(title))),
        Flexible(
          fit: FlexFit.tight,
          flex: 4,
          child: GestureDetector(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(8.0),
              //EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 147, 184, 248),
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: loading
                  ? Center(child: Loading())
                  : FittedBox(
                      fit: BoxFit.contain,
                      child: Text(currentTime.format(context))),
            ),
            onTap: () {
              selectedTime(context, ifPickedTime, currentTime, onTimePicked);
            },
          ),
        ),
        const Spacer(flex: 1),
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: GestureDetector(
            onTap: () {
              showDialog(context: context, builder: (_) => _alarm1Dialog());
              FlutterAlarmClock.createAlarm(alarmTime.hour, alarmTime.minute,
                  title: "SleepLah! Alarm: $title time reached!");
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(8.0),
              //EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 192, 213, 249),
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: loading
                  ? Loading()
                  : const FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Create alarm',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
          ),
        )
      ],
    );
  }

  Widget _alarm1Dialog() {
    return const AlertDialog(
      title: Text("Alarm is set at 5 minutes before your scheduled time!\nCheck your default alarm for more info"),
    );
  }
}
