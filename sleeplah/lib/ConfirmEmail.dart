import 'package:flutter/material.dart';

class ConfirmEmail extends StatelessWidget {
  static String id = 'confirm-email';
  final String message;

  const ConfirmEmail({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: Colors.lightBlueAccent,
        body: Stack(children: [
      const Positioned.fill(
        child: Image(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.fitHeight,
        ),
      ),
      Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        )),
      ),
    ]));
  }
}
