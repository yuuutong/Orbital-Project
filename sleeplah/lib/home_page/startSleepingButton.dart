import 'package:flutter/material.dart';
import 'package:sleeplah/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../SizeConfig.dart';
import '../constant.dart';
import 'package:sleeplah/home_page/sleep.dart';

class startSleepingButton extends StatefulWidget {
  String _buttonText = "Sleep Now";
  startSleepingButton(this._buttonText);

  @override
  State<startSleepingButton> createState() =>
      startSleepingButtonState(_buttonText);
}

class startSleepingButtonState extends State<startSleepingButton> {
  String _buttonText;
  startSleepingButtonState(this._buttonText);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize ?? 1;
    return Container(
      alignment: Alignment.center,
      child: Container(
        //color: Colors.blueGrey,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueGrey,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: TextButton(
          child: Text(
            _buttonText,
            style: TextStyle(
                fontSize: defaultSize * 30,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          onPressed: () {
            {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const sleep(),
                ),
              );
              setState(
                () {
                  DB().setTime(DateTime.now(), "sleepActual");
                },
              );
            }
          },
        ),
      ),
    );
  }
}
