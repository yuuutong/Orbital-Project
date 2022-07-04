import 'package:sleeplah/login_page/LoginScreen.dart';
import 'package:sleeplah/models/flowers.dart';
import '../database.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import '../SizeConfig.dart';
import 'package:sleeplah/configurations/loading.dart';

class Selection extends StatefulWidget {
  @override
  _SelectionState createState() => _SelectionState();
}

class _SelectionState extends State<Selection> {
  bool loading = true;
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

    //print(FlowerList.length);
    return loading
        ? Loading()
        : Container(
        margin: EdgeInsets.fromLTRB(defaultSize * 6, defaultSize * 1,
            defaultSize * 6, defaultSize * 8),
        child: ListView.builder(
            itemCount: FlowerList.length,
            itemBuilder: (context, index) {
              return Card(child: _buildTile(index));
            }));
  }

  ListTile _buildTile(int index) {
    String flowerID = FlowerList[index].id;
    List<String> unlockedFlowersID = [];
    for (var Flower in FlowerList) {
      if (userFlowers[int.parse(Flower.id)] != "0")
        unlockedFlowersID.add(Flower.id);
      // if num != 0 for a particular variant in current list of flower, then it is unlocked. add it to unlocked list
    }
    // if the user already unlocked the flower
    if (unlockedFlowersID.contains(flowerID)) {
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

    // if the user has not unlocked the flower
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
                          Text('Go to flower shop to purchase new flowers...'),
                        ],
                      ),
                    ));
              });
        },
        title: const Text("mysterious flower locked"),
        leading: const Icon(Icons.lock));
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
                image: AssetImage('$flower_profile_path$selectedID.png'), fit: BoxFit.fitHeight)),
        Container(
            height: screenHeight * 0.35,
            padding: EdgeInsets.all(defaultSize * 1.25),
            child: Image(
              image: AssetImage('$flower_profile_path${selectedID}_des.png'),
              width: 300, height: 300,
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
                      image: AssetImage('assets/images/shanna.png'),
                      fit: BoxFit.fitWidth
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
    setState(() {
      loading = false;
    });
  }
}
