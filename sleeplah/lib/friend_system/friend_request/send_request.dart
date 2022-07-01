import 'package:sleeplah/configurations/background.dart';
import 'package:sleeplah/configurations/rounded_input_field.dart';
import 'package:flutter/material.dart';
import 'package:sleeplah/SizeConfig.dart';
import 'package:sleeplah/database.dart';
import 'package:sleeplah/login_page/LoginScreen.dart';

class Send extends StatefulWidget {
  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<Send> {
  double screenHeight = SizeConfig.screenHeight!;
  double screenWidth = SizeConfig.screenWidth!;
  int state = 0;
  String searchName = "bitch";
  //0 - init, 1 - found, -1 - not found

  @override
  Widget build(BuildContext context) {
    return Background(
        child: Column(
      children: <Widget>[
        Container(
          height: screenHeight * 2 / 10,
        ),
        RoundedInputField(
            hintText: "nickname",
            onChanged: (value) async {
              bool isUserNameExist =
                  await DB().isUserNameExist(value);
              if (isUserNameExist) {
                setState(() {
                  state = 1;
                  searchName = value;
                });
              } else {
                setState(() {
                  state = -1;
                });
              }
            }),
        Container(
            margin: EdgeInsets.only(top: screenHeight * 0.05),
            child: searchResult())
      ],
    ));
  }

  Widget searchResult() {
    if (state == 0) return Container();

    return state == 1
        ? Card(
            child: ListTile(
            leading: Icon(Icons.account_circle),
            title: Text(searchName),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                DB().sendFriendRequest(user!.uid, searchName);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Friend request sent!'),
                  ),
                );
              },
            ),
          ))
        : Card(
            child: ListTile(
            title: Text("User not found"),
          ));
  }
}