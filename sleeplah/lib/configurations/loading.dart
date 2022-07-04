import 'package:flutter/material.dart';
import 'package:loading_gifs/loading_gifs.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: Image(
          image: Image.asset(
            circularProgressIndicatorSmall,
            filterQuality: FilterQuality.none,
          ).image,
          fit: BoxFit.cover,
        ),
        // child: SpinKitThreeBounce(
        //   // color: themeSecondaryColor,
        //   color: Colors.white,
        //   // size: 50.0,
        // ),
      ),
    );
  }
}
