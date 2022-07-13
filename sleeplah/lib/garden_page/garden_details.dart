import 'package:flutter/material.dart';

class detail extends StatefulWidget {
  String flowerName;
  String flowerImage;
  int number;

  detail(this.flowerName, this.flowerImage, this.number);

  @override
  State<detail> createState() => _detailState(flowerName, flowerImage, number);
}

class _detailState extends State<detail> {
  String flowerName;
  String flowerImage;
  int number;

  _detailState(this.flowerName, this.flowerImage, this.number);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Flexible(
          fit: FlexFit.tight,
          flex: 4,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image(
                  image: AssetImage("assets/images/$flowerImage"),
                  filterQuality: FilterQuality.none,
                  fit: BoxFit.fill,
                ).image,
                colorFilter:
                    const ColorFilter.mode(Colors.white70, BlendMode.color),
                fit: BoxFit.fill,
                filterQuality: FilterQuality.none,
              ),
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(20),
            ),
          )),
      Flexible(
        fit: FlexFit.tight,
        flex: 1,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Text('$flowerName $number', textAlign: TextAlign.center),
        ),
      )
    ]);
  }
}
