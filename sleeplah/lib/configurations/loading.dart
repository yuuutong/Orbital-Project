import '../constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: themePrimaryColor,
      child: Center(
        child: SpinKitThreeBounce(
          color: themeSecondaryColor,
          size: 50.0,
        ),
      ),
    );
  }
}