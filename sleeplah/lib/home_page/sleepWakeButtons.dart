import 'package:flutter/material.dart';
import '../configurations/loading.dart';
import 'startSleepingButton.dart';
import 'wakeUpButton.dart';
import 'package:sleeplah/database.dart';

class sleepWakeButtons extends StatefulWidget {
  const sleepWakeButtons({Key? key}) : super(key: key);

  @override
  State<sleepWakeButtons> createState() => _sleepWakeButtonsState();
}

class _sleepWakeButtonsState extends State<sleepWakeButtons> {
  // bool isAsleep = false;
  // bool loading = true;

  // @override
  // void initState() {
  //   getValue();
  //   loading = true;
  //   super.initState();
  // }

  // Future<void> getValue() async {
  //   isAsleep = await DB().isAsleep();
  //   setState(() {
  //     loading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // return loading
    //     ? Loading()
    //     : isAsleep
    //         ? wakeUpButton("I'm awake!")
    //         : startSleepingButton("Sleep now");
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
