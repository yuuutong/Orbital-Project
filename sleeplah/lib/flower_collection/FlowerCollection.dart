import 'package:flutter/material.dart';
import 'package:sleeplah/flower_collection/flower_tile.dart';

class FlowerCollection extends StatefulWidget {
  const FlowerCollection({Key? key}) : super(key: key);

  @override
  State<FlowerCollection> createState() => _FlowerCollectionState();
}

class _FlowerCollectionState extends State<FlowerCollection> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shop"),
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
            Flower("Shanna swimming in the air", "shanna_stand.gif"),
            Flower("Rose", "1.png"),
            Flower("Daisy", "2.png"),
            Flower("Lilac", "3.png"),
            Flower("Lotus", "4.png"),
            Flower("Lily", "5.png"),
            Flower("Tulip", "6.png"),
          ],
        )
      ]),
    );
  }
}
