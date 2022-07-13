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
  State<Actual> createState() => _ActualState();
}

class _ActualState extends State<Actual> {
  //bool _startAlready = false;
  bool loading = true;
  bool sleeping = false;
  String username = "";

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    sleeping = await DB().isSleeping(FirebaseAuth.instance.currentUser!.uid);
    username = await DB().getUserName(FirebaseAuth.instance.currentUser!.uid);
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
          //_startAlready
          sleeping
              ? ElevatedButton(
                  child: const Text("I'm awake",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      )),
                  onPressed: () async {
                    await DB().hasAGoal(FirebaseAuth.instance.currentUser!.uid)
                        ? setState(() {
                            DB().addWakeActual(DateTime.now());
                            // DB().setTime(DateTime.now(), "wakeActual");
                            // DB().eligibleForReward(
                            //     DateFormat("yyyy-MM-dd").format(DateTime.now()),
                            //     FirebaseAuth.instance.currentUser!.uid);
                            //_startAlready = false;
                            sleeping = false;
                            DB().toggleSleeping(
                                FirebaseAuth.instance.currentUser!.uid);
                            showDialog(
                                context: context,
                                builder: (_) => _wakeDialog());
                            print("set state liao");
                          })
                        : ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'You need to set the time to sleep and wake up before sleeping!'),
                            ),
                          );
                  })
              : ElevatedButton(
                  child: const Text("Sleep Now",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      )),
                  onPressed: () async {
                    await DB().hasAGoal(FirebaseAuth.instance.currentUser!.uid)
                        ? setState(() {
                            DB().addSleepActual(DateTime.now());
                            // DB().setTime(DateTime.now(), "sleepActual");
                            //_startAlready = true;
                            sleeping = true;
                            DB().toggleSleeping(
                                FirebaseAuth.instance.currentUser!.uid);
                            showDialog(
                                context: context,
                                builder: (_) => _sleepDialog());
                            print("set state liao");
                          })
                        : ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                            content: Text(
                                'You need to set the time to sleep and wake up before sleeping!'),
                          ));
                  }),
        ]);
  }

  Widget _sleepDialog() {
    return AlertDialog(
      title: Text("Good Night, $username!"),
    );
  }

  Widget _wakeDialog() {
    return AlertDialog(
      title: Text("Morning, $username!"),
      content:
          const Text('Shanna is excited to start a new day!'),
    );
  }
}
