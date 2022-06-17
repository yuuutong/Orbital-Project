import 'package:flutter/material.dart';
import 'package:sleeplah/Component/flower_tile.dart';

class Garden extends StatefulWidget {
  const Garden({Key? key}) : super(key: key);

  @override
  State<Garden> createState() => _GardenState();
}

class _GardenState extends State<Garden> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Garden"),
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
            Flower("Sunflower", const AssetImage("assets/images/sunflower.png")),
            Flower("Sunflower", const AssetImage("assets/images/sunflower.png")),
            Flower("Sunflower", const AssetImage("assets/images/sunflower.png")),
            Flower("Sunflower", const AssetImage("assets/images/sunflower.png")),
            Flower("Sunflower", const AssetImage("assets/images/sunflower.png")),
            Flower("Sunflower", const AssetImage("assets/images/sunflower.png")),
          ],
        )
      ]),
    );
  }
}
