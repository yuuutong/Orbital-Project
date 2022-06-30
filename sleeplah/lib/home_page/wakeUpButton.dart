import 'package:flutter/material.dart';
import 'package:sleeplah/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../SizeConfig.dart';
import '../constant.dart';
import 'package:sleeplah/home_page/awake.dart';
import 'package:intl/intl.dart';

class wakeUpButton extends StatefulWidget {
  String _buttonText = "I'm awake!";
  wakeUpButton(this._buttonText);

  @override
  State<wakeUpButton> createState() => wakeUpButtonState(_buttonText);
  //_startSleepingButtonState createState() => _startSleepingButtonState(_buttonText);
}

class wakeUpButtonState extends State<wakeUpButton> {
  String _buttonText;
  wakeUpButtonState(this._buttonText);

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
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: TextButton(
              child: Text(_buttonText,
                  style: TextStyle(
                      fontSize: defaultSize * 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              onPressed: () {
                {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const awake()));
                  setState(() {
                    DB().setTime(DateTime.now(), "wakeActual");
                    DB().claimReward(
                        DateFormat("yyyy-MM-dd").format(DateTime.now()),
                        FirebaseAuth.instance.currentUser.uid);                  
                  });
                }
              }),
        ));
  }
}
