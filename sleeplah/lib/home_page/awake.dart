import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../SizeConfig.dart';
import '../constant.dart';
import 'package:sleeplah/models/AppUser.dart';
import 'package:sleeplah/database.dart';

class awake extends StatefulWidget {
  const awake({Key? key}) : super(key: key);

  @override
  State<awake> createState() => _awakeState();
}

class _awakeState extends State<awake> {
  late String username = "";
  bool loading = true;

  @override
  void initState() {
    loading = true;
    getValue();
    super.initState();
  }

  Future<void> getValue() async {
    username = await DB().getUserName(FirebaseAuth.instance.currentUser!.uid);
    setState(() {
      loading = false;
    });
    print(loading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          const Positioned.fill(
            child: Image(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fitHeight,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loading ? const Text("loading...") :
              Flexible(
                child: Text(
                  'Good morning, $username!\nShanna is excited \n to start a new day!',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  child: const Image(
                    image:
                        AssetImage("assets/images/shanna-removebg-preview.png"),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
