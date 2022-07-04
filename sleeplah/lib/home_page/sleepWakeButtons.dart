import 'package:flutter/material.dart';
import 'startSleepingButton.dart';
import 'wakeUpButton.dart';

class sleepWakeButtons extends StatelessWidget {
  const sleepWakeButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 1),
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: startSleepingButton("Sleep Now"),
        ),
        const Spacer(flex: 1),
        Flexible(
          fit: FlexFit.tight,
          flex: 2,
          child: wakeUpButton("I'm awake!"),
        ),
        const Spacer(flex: 1),
      ],
    );
  }
}
