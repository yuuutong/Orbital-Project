import 'package:flutter/material.dart';

class Flower extends StatefulWidget {
  // const Flower({super.key});

  final String flowerName;
  final String flowerImage;

  Flower(this.flowerName, this.flowerImage, {Key? key}) : super(key: key);

  @override
  State<Flower> createState() => _FlowerState(flowerName, flowerImage);
}

class _FlowerState extends State<Flower> {
  final String flowerName;
  final String flowerImage;

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
          colorFilter: const ColorFilter.mode(Colors.transparent, BlendMode.color),
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
