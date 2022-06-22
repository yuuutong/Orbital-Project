import 'package:flutter/material.dart';
// import 'package:sleeplah/configurations/background.dart';
import '../SizeConfig.dart';
import '../constant.dart';

class awake extends StatefulWidget {
  const awake({Key? key}) : super(key: key);

  @override
  State<awake> createState() => _awakeState();
}

class _awakeState extends State<awake> {
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
                  'Good morning!\n \n Shanna is excited \n to start a new day!',
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
