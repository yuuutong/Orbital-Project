import 'package:flutter/material.dart';

class Flower extends StatefulWidget {
  // const Flower({super.key});

  String flowerName;
  AssetImage flowerImage;

  Flower(this.flowerName, this.flowerImage);

  @override
  State<Flower> createState() => _FlowerState(flowerName, flowerImage);
}

class _FlowerState extends State<Flower> {
  String flowerName;
  AssetImage flowerImage;

  _FlowerState(this.flowerName, this.flowerImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        image: DecorationImage(image: flowerImage),
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(flowerName),
    );
  }
}
