import 'package:sleeplah/friend_system/user_model.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/SizeConfig.dart';

class LeaderBoard extends StatefulWidget {
  List<UserModel> friendList;
  UserModel currUser;
  String category;
  late List<UserModel> rankList;

  LeaderBoard(this.friendList, this.currUser, this.category) {
    rankList = List.from(friendList);
    rankList.add(currUser);
    rankUserByTime();
  }

  List<UserModel> rankUserByTime() {
    if (category == "days") {
      rankList.sort((o1, o2) => (o2.days - o1.days).toInt());
    } else {
      rankList.sort((o1, o2) => (o2.coins - o1.coins).toInt());
    }
    return rankList;
  }

  @override
  _LeaderBoardState createState() => _LeaderBoardState(rankList, category);
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<UserModel> rankList;
  double screenHeight = SizeConfig.screenHeight!;
  double screenWidth = SizeConfig.screenWidth!;
  bool loading = true;
  String category;

  _LeaderBoardState(this.rankList, this.category);

  @override
  Widget build(BuildContext context) {
    double defaultWidth = screenWidth * 0.1;

    return Container(
      height: screenHeight * 7 / 11,
      child: ListView.builder(
          itemCount: rankList.length,
          itemBuilder: (context, index) {
            return Card(
                margin: EdgeInsets.only(top: defaultWidth * 0.5),
                color: Colors.white.withOpacity(0.6),
                child: rankTile(index, rankList[index]));
          }),
    );
  }

  Widget rankTile(int index, UserModel user) {
    String criteria;
    if (category == "days") {
      criteria = user.days.toString();
    } else {
      List flowersList = user.flowers;
      // flowersList.removeWhere((element) => element == "0");
      // criteria = flowersList.length.toString();
      List<int> help = flowersList.map((e) => int.parse(e)).toList();
      criteria = help.reduce((value, element) => value + element).toString();
    }

    return ListTile(
      leading: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage("assets/images/${user.profileId}.png"),
            ),
          )),
      tileColor: Colors.transparent,
      title: Text(user.name),
      subtitle: Text(criteria),
      trailing: Text(
        (index + 1).toString(),
        style: const TextStyle(fontSize: 25),
      ),
    );
  }
}
