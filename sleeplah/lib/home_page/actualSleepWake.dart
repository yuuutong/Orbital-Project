import 'dart:async';
import 'package:sleeplah/configurations/background.dart';
import 'package:sleeplah/database.dart';
import 'package:sleeplah/home_page/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/login_page/LoginScreen.dart';
import '../constant.dart';
import '../SizeConfig.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:sleeplah/models/AppUser.dart";

class Actual extends StatefulWidget {
  const Actual({Key? key}) : super(key: key);

  @override
  State<Actual> createState() => _ActualState(/* _buttonText */);
}

class _ActualState extends State<Actual> {
  bool _startAlready = false;
  bool loading = true;
  late String sleepTimeSet;
  late String wakeTimeSet;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    sleepTimeSet = await DB().getUserValue(user!.uid, "sleepTimeSet");
    wakeTimeSet = await DB().getUserValue(user!.uid, "wakeTimeSet");
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _startAlready
              ? ElevatedButton(
                  child: Text("I'm awake",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      )),
                  onPressed: () {
                    (sleepTimeSet != "" && wakeTimeSet != "")
                        ? setState(() {
                            DB().addWakeActual(DateTime.now());
                            // DB().setTime(DateTime.now(), "wakeActual");
                            // DB().eligibleForReward(
                            //     DateFormat("yyyy-MM-dd").format(DateTime.now()),
                            //     FirebaseAuth.instance.currentUser!.uid);
                            _startAlready = false;
                            print("set state liao");
                          })
                        : ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text(
                                  'You need to set the time to sleep and wake up before sleeping!'),
                            ),
                          );
                    print("user never set time");
                  })
              : ElevatedButton(
                  child: Text("Sleep Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      )),
                  onPressed: () {
                    (sleepTimeSet != "" && wakeTimeSet != "")
                        ? setState(() {
                            DB().addSleepActual(DateTime.now());
                            // DB().setTime(DateTime.now(), "sleepActual");
                            _startAlready = true;
                            print("set state liao");
                          })
                        : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(
                                'You need to set the time to sleep and wake up before sleeping!'),
                          ));
                    print("user never set time");
                  }),
          /* ActualButtons(
            text: 'Stop',
            press: () {
              _timer.cancel();
              _stars = helper.countStars(_actual);
              showDialog(context: context, builder: (_) => _confirmationDialog());
            },
          ) */
        ]);
  }

  /* Widget _confirmationDialog() {
    return AlertDialog(
        title: const Text("Quit?"),
        content: Text("Are you sure?"),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _startTimer();
                    _startAlready = false;
                  });
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                      context: context, builder: (_) => _taskCompletedDialog());
                },
                child: Text("Yes"),
              ),
            ],
          )
        ]);
  } */

  /* Widget _taskCompletedDialog() {
    return AlertDialog(
      title: const Text("YAY!"),
      content: Container(
        child: Text('You have helped Coma get $_stars stars!'),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            DB().saveFocusTime(_tag!, _actual, date);
            print(date);
            DB().updateStars(_stars);
            Navigator.pop(context);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomePage()));
          },
          child: Text("Return to Home"),
        ),
      ],
    );
  } */
}
