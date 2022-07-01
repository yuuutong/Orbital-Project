import 'package:sleeplah/login_page/LoginScreen.dart';
import 'package:sleeplah/models/flowers.dart';
import '../database.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import '../SizeConfig.dart';

class Selection extends StatefulWidget {
  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  List<String> userFlowers = [];
  double defaultSize = SizeConfig.defaultSize!;
  double screenHeight = SizeConfig.screenHeight!;
  double screenWidth = SizeConfig.screenWidth!;
  String selectedID = "-1";

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (selectedID != "-1") {
      return Container(child: flowerInfo());
    }

    return Container(
        margin: EdgeInsets.fromLTRB(defaultSize * 6, defaultSize * 11,
            defaultSize * 6, defaultSize * 13),
        child: ListView.builder(
            itemCount: FlowerList.length,
            itemBuilder: (context, index) {
              return Card(child: _buildTile(index));
            }));
  }

  ListTile _buildTile(int index) {
    String flowerID = FlowerList[index].id;
    if (userFlowers.contains(flowerID)) {
      return ListTile(
        onTap: () {
          setState(() {
            selectedID = flowerID;
          });
        },
        title: Text(FlowerList[index].name),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('$flower_profile_path$flowerID.png'),
        ),
      );
    }

    return ListTile(
        onTap: () {
          showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                    title: const Text('Shanna has not seen this flower yet!'),
                    content: SingleChildScrollView(
                      child: ListBody(
                        children: const <Widget>[
                          Text(
                              'Go to flower shop to purchase new flowers...'),
                        ],
                      ),
                    ));
              });
        },
        title: Text("mysterious flower locked"),
        leading: Icon(Icons.lock));
  }

  Widget flowerInfo() {
    return Column(
      children: <Widget>[
        Container(
          height: screenHeight * 0.15,
          //decoration: BoxDecoration(color: Colors.black),
        ),
        Container(
            height: screenHeight * 0.22,
            decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.grey, width: defaultSize * 0.2)),
            child: Image(
                image: AssetImage('$flower_profile_path$selectedID.png'))),
        Container(
            height: screenHeight * 0.35,
            padding: EdgeInsets.all(defaultSize * 1.25),
            child: Image(
              image: AssetImage('$flower_profile_path$selectedID.png'),
            )),
        Row(
          children: [
            Container(width: screenWidth * 0.7),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                    top: defaultSize * -2.5,
                    right: defaultSize * -1.2,
                    child: Image(
                      image: AssetImage('assets/images/background.png'),
                    )),
                IconButton(
                    onPressed: () {
                      setState(() {
                        selectedID = "-1"; //go back to selction view
                      });
                    },
                    icon: Icon(Icons.keyboard_return_rounded,
                        color: Colors.white, size: defaultSize * 3)),
              ],
            )
          ],
        )
      ],
    );
  }

  void getData() async {
    userFlowers = await DB().getFlowerList();
    setState(() {});
  }
}