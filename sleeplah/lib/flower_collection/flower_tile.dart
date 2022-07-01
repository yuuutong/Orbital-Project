import 'package:flutter/material.dart';
import 'package:sleeplah/database.dart';

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

  bool flowerLocked = true;
  bool loading = true;

  @override
  void initState() {
    loading = true;
    accessDB();
    super.initState();
  }

  Future<void> accessDB() async {
    List<String> flowersList = await DB().getFlowerList();
    int index = int.parse(flowerImage);
    try {
      if (flowersList[index] != "0") {
        print(flowerName + " is an unlocked item!");
        flowerLocked = false;
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      loading = false;
      print('flower_tile loading complete!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 4,
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: Image(
                  image: AssetImage("assets/images/$flowerImage.png"),
                  filterQuality: FilterQuality.none,
                ).image,
                colorFilter:
                    const ColorFilter.mode(Colors.transparent, BlendMode.color),
                fit: BoxFit.contain,
                filterQuality: FilterQuality.none,
              ),
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Text(flowerName, textAlign: TextAlign.center),
          ),
        )
      ],
    );
  }
}
