import 'package:flutter/material.dart';
import 'package:sleeplah/constant.dart';
import 'package:sleeplah/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: themePrimaryColor,
            border: Border.all(),
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: TextButton(
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  _buttonText,
                  style: TextStyle(color: Colors.black),
                )),
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
      ),
    );
  }
}
