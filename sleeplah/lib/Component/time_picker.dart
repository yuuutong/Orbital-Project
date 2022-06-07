import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  @override
  State<TimePicker> createState() => TimePickerState();
}

class TimePickerState extends State<TimePicker> {
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Row( //sets up the two clocks side by side
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(flex: 1),
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: FittedBox(
            child: _buildTimePick("Start", true, startTime, (x) {
              setState(() {
                startTime = x;
                print("The picked time is: $x");
              });
            })
          )
        ),
        const Spacer(flex: 1),
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: FittedBox(
            child: _buildTimePick("End", true, endTime, (x) {
              setState(() {
                endTime = x;
                print("The picked time is: $x");
              });
            })
          )
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
        Text(title),
        Container(
          padding: const EdgeInsets.all(8.0), //EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.lightBlueAccent,
            border: Border.all(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: GestureDetector(
            child: Text(
              currentTime.format(context),
            ),
            onTap: () {
              selectedTime(context, ifPickedTime, currentTime, onTimePicked);
            },
          ),
        ),
      ],
    );
  }
}