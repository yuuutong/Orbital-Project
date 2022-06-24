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
        title: const Text("Shop: Shanna GIFS"),
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
            Flower("Shanna stands up", "shanna_stand.gif"),
            Flower("Rose", "rose.png"),
            Flower("Daisy", "daisy.png"),
            Flower("Lilac", "lilac.png"),
          ],
        )
      ]),
    );
  }
}
