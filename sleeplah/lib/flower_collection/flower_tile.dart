import 'package:flutter/material.dart';
//hi
class Flower extends StatefulWidget {
  // const Flower({super.key});

  String flowerName;
  String flowerImage;

  Flower(this.flowerName, this.flowerImage);

  @override
  State<Flower> createState() => _FlowerState(flowerName, flowerImage);
}

class _FlowerState extends State<Flower> {
  String flowerName;
  String flowerImage;

  _FlowerState(this.flowerName, this.flowerImage);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image(
            image: AssetImage("assets/images/$flowerImage"),
            filterQuality: FilterQuality.none,
          ).image,
          colorFilter: const ColorFilter.mode(Colors.white70, BlendMode.color),
          fit: BoxFit.fill,
          filterQuality: FilterQuality.none,
        ),
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(flowerName),
    );
  }
}
