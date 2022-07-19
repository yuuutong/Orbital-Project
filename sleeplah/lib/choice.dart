import 'package:flutter/material.dart';
import 'package:sleeplah/home_page/HomeScreen.dart';
import 'package:sleeplah/walkthrough/walkthrough_screen.dart';
import 'configurations/background.dart';
import 'configurations/rounded_button.dart';
import 'login_page/LoginScreen.dart';
import 'package:sleeplah/constant.dart';

class Choice extends StatefulWidget {
  const Choice({Key? key}) : super(key: key);

  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  @override
  Widget build(BuildContext context) {
    return Material(
        child: Background(
            child: SingleChildScrollView(
                child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: const Text(
            "Would you like a walkthrough of the app?",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "IndieFlower",
                fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundedButton(
            press: () async {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            text: 'I\'m an old user. Log in straight',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RoundedButton(
            press: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const WalkthroughScreen()));
            },
            text: 'I\'m a newbie! Go for a walkthrough',
          ),
        )
      ],
    ))));
  }
}
