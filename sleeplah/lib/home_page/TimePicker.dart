import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:sleeplah/database.dart';

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
    String docDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    Map timeData = await DB().getTimeCollectionDoc(docDate);
    print(timeData);
    try {
      if (timeData["sleepSet"] != null) {
        startTime =
            TimeOfDay.fromDateTime(DateTime.parse(timeData["sleepSet"]));
      }
      if (timeData["wakeSet"] != null) {
        endTime = TimeOfDay.fromDateTime(DateTime.parse(timeData["wakeSet"]));
      }
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
          child: _buildTimePick("Start", true, startTime, (x) {
            setState(() {
              DB().setTime(DB.convertTimeOfDayToDateTime(x), "sleepSet");
              startTime = x;
              print("The picked time is: $x");
            });
          }),
        ),
        const Spacer(flex: 1),
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: _buildTimePick("End", true, endTime, (x) {
            setState(() {
              DB().setTime(DB.convertTimeOfDayToDateTime(x), "wakeSet");
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
            fit: FlexFit.tight, flex: 2, child: FittedBox(child: Text(title))),
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: GestureDetector(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              padding: const EdgeInsets.all(8.0),
              //EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: loading
                  ? Center(
                      child: Image(
                        image: Image.asset(
                          circularProgressIndicatorSmall,
                          filterQuality: FilterQuality.none,
                        ).image,
                        fit: BoxFit.cover,
                      ),
                    )
                  : FittedBox(fit: BoxFit.cover,child: Text(currentTime.format(context))),
            ),
            onTap: () {
              selectedTime(context, ifPickedTime, currentTime, onTimePicked);
            },
          ),
        )
      ],
    );
  }
}
