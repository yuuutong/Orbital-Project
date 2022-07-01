import 'package:flutter/foundation.dart';
import 'package:sleeplah/login_page/LoginScreen.dart';
import 'package:sleeplah/configurations/loading.dart';
import '../constant.dart';
import 'package:sleeplah/friend_system/friend_request/friend_request_page.dart';
import 'package:sleeplah/friend_system/leaderboard.dart';
import 'package:sleeplah/friend_system/user_model.dart';
import 'package:flutter/material.dart';
import '../database.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'package:sleeplah/configurations/background.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState(_category);
  String _category;
  Body(this._category);
}

class _BodyState extends State<Body> {
  bool loading = true;
  List<UserModel> friendList = [];
  late UserModel currUser;
  double screenHeight = SizeConfig.screenHeight!;
  double screenWidth = SizeConfig.screenWidth!;
  String _category;
  //String userProfileAnimal = "0";

  _BodyState(this._category);

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Background(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: screenHeight * 2 / 11,
              ),
              LeaderBoard(friendList, currUser, _category),
              Container(
                height: screenHeight * 2 / 11,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: selfInfo(currUser),
              )
            ],
          ));
  }

  //need a function to sort the rank

  Widget selfInfo(UserModel user) {
    double defaultWidth = screenWidth * 0.1;
    double defaultHeight = screenHeight * 2 / 11 * 0.1;
    double defaultSize = SizeConfig.defaultSize!;

    String criteria;
    if (_category == "days") {
      criteria = user.days.toString();
    } else {
      criteria = user.coins.toString();
    }

    return Row(
      children: <Widget>[
        Container(
          width: defaultWidth * 0.5,
        ),
        Container(
            //mimic display pic
            width: defaultWidth * 2.5,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: defaultSize * 0.8, //8
              ),
              color: Colors.white,
              /* image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(
                    "assets/image/animal_floating/$userProfileAnimal.png"),
              ), */
            )),
        Container(
          width: defaultWidth * 0.5,
        ),
        Container(
            width: defaultWidth * 4.8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: defaultHeight * 1.8,
                ),
                Text(user.name,
                    style: TextStyle(
                        color: primaryColor, fontSize: defaultWidth * 0.8)),
                Container(
                  height: defaultHeight * 0.5,
                ),
                Text(criteria, style: TextStyle(fontSize: defaultWidth * 0.45))
              ],
            )),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => FriendRequest()));
            },
            icon:
                Icon(Icons.person_add_alt_1_rounded, size: defaultWidth * 0.8))
      ],
    );
  }

  Future<void> getData() async {
    String currUserId = user!.uid;
    //userProfileAnimal = await DB().getProfileAnimal(currUserId);
    List<String> friendIdList = await DB().getFriendList(currUserId);
    String name = await DB().getUserName(currUserId);
    num days = await DB().getDays(currUserId);
    num coins = await DB().getCoins();

    currUser = UserModel(name, "", days, coins);

    for (var id in friendIdList) {
      num days = await DB().getDays(currUserId);

      friendList.add(UserModel(name, id, days, coins));
    }

    setState(() {
      loading = false;
    });
  }
}
