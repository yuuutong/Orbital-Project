import 'package:flutter/material.dart';
import 'package:sleeplah/Component/background.dart';
import '../size_config.dart';
import '../constant.dart';
//import 'package:sleeplah/Component/startSleepingButton.dart';

class sleep extends StatefulWidget {
  const sleep({Key? key}) : super(key: key);

  @override
  State<sleep> createState() => _sleepState();
}

class _sleepState extends State<sleep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Flexible(
                child: Text(
                  'Good Night with Shanna!',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Image(
                    image:
                        AssetImage("assets/images/shanna-removebg-preview.png"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
