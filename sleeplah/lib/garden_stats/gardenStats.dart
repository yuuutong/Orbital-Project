import 'package:flutter/material.dart';
import 'package:sleeplah/garden_stats/garden_details.dart';

class gardenStats extends StatefulWidget {
  const gardenStats({Key? key}) : super(key: key);

  @override
  State<gardenStats> createState() => _gardenStatsState();
}

class _gardenStatsState extends State<gardenStats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Garden Statistics Dashboard"),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: Stack(children: [
        const Positioned.fill(
          child: Image(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
        GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8.0),
          children: <Widget>[
            detail("Sunflower", "sunflower.png", 1),
            detail("Rose", "rose.png", 0),
            detail("Daisy", "daisy.png", 0),
            detail("Lilac", "lilac.png", 0),
          ],
        )
      ]),
    );
  }
}
