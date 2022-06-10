import '../constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final press;
  final Color color, textColor;
  const RoundedButton({
    required this.text,
    required this.press,
    this.color = themePrimaryColor,
    this.textColor = Colors.white,
  }) : super();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ElevatedButton(
        //padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        style: ElevatedButton.styleFrom(
          primary: themePrimaryColor, // background
          onPrimary: Colors.white, // foreground
        ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}