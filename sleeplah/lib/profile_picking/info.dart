import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sleeplah/login_page/LoginScreen.dart';
import '../../database.dart';
import 'package:flutter/material.dart';
import '../../SizeConfig.dart';
import 'package:sleeplah/models/flowers.dart';
import 'package:sleeplah/configurations/loading.dart';

import '../constant.dart';

class Info extends StatefulWidget {
  const Info({
    required this.name,
    required this.userFlower,
  });
  final String name;
  final String userFlower;

  @override
  _InfoState createState() => _InfoState(name, userFlower);
}

class _InfoState extends State<Info> {
  double defaultSize = SizeConfig.defaultSize!;
  double defualtHeight = SizeConfig.screenHeight! / 10;
  String name;
  String userFlower;
  List<String> flowerIdList = [];
  bool loading = true;

  _InfoState(this.name, this.userFlower);

  @override
  void initState() {
    super.initState();
    getFlowerIDList();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : SizedBox(
            height: defualtHeight * 8, // 240
            child: Stack(children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      child: InkWell(
                        onTap: () => _selectFlowerDialog(),
                      ),
                      margin: EdgeInsets.only(bottom: defaultSize), //10
                      height: defaultSize * 15, //140
                      width: defaultSize * 15,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: defaultSize * 0.6, //8
                        ),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/images/$userFlower.png"),
                          filterQuality: FilterQuality.none,
                        ),
                      ),
                    ),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: defaultSize * 2.5, // 22
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: defaultSize / 2),
                    TextButton(
                      onPressed: () => _selectFlowerDialog(),
                      style: TextButton.styleFrom(
                          primary: primaryColor,
                          backgroundColor: primaryColor,
                          shadowColor: Colors.yellow,
                          elevation: 10,
                          padding: EdgeInsets.fromLTRB(
                              defaultSize * 5,
                              defaultSize * 1.2,
                              defaultSize * 5,
                              defaultSize * 1.2),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultSize * 3.6), //36
                              side: const BorderSide(color: Colors.white))),
                      child: Shimmer.fromColors(
                          baseColor: Colors.red,
                          highlightColor: Colors.yellow,
                          enabled: true,
                          child: Text("Change Profile Photo",
                              style: TextStyle(fontSize: defaultSize * 3))),
                    ),
                    SizedBox(height: defualtHeight * 0.1),
                    Container(
                      width: 270,
                      height: 270,
                      child: Image.asset('assets/images/shanna.png'),
                    ) //5
                  ],
                ),
              )
            ]));
  }

  Future<void> getFlowerIDList() async {
    List<String> flowerNumList = await DB().getFlowerList();
    for (var Flower in FlowerList) {
      if (flowerNumList[int.parse(Flower.id)] != "0") {
        flowerIdList.add(Flower.id);
      }
      // if num != 0 for a particular variant in current list of flower, then it is unlocked. add it to unlocked list
      // users can use these unlocked flowers as profile photo
    }
    setState(() {
      loading = false;
    });
  }

  Future<void> _selectFlowerDialog() async {
    List<Widget> tiles = flowerIdList.map((e) => _buildGridTile(e)).toList();

    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => AlertDialog(
            title: const Text("Choose your profile flower ฅ•ω•ฅ"),
            insetPadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 100),
            contentPadding: EdgeInsets.zero,
            content: Container(
                height: defualtHeight * 5,
                width: defaultSize,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: tiles,
                ))));
  }

  Widget _buildGridTile(String id) {
    String path = "assets/images/$id.png";
    return SimpleDialogOption(
      child: Container(padding: EdgeInsets.zero, child: Image.asset(path)),
      onPressed: () {
        setState(() {
          userFlower = id;
          DB().updateProfileFlower(FirebaseAuth.instance.currentUser!.uid, id);
        });
        Navigator.pop(context);
      },
    );
  }
}
