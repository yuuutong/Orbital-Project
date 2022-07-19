import 'package:flutter/material.dart';
import 'package:sleeplah/home_page/HomeScreen.dart';

class WalkthroughItem extends StatefulWidget {
  final description;
  final index;
  final totalItem;
  final controller;
  final Map<String, dynamic>? item;

  const WalkthroughItem(
      {Key? key,
      this.controller,
      this.description,
      this.index,
      this.totalItem,
      this.item})
      : super(key: key);

  @override
  _WalkthroughItemState createState() => _WalkthroughItemState();
}

class _WalkthroughItemState extends State<WalkthroughItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 147, 171, 212),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.index == 0
                  ? [
                      Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Image.asset(
                            widget.item!['image'] ?? '',
                            width: 150,
                          )),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: widget.item!['description_rich'] ?? const Text(""),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: widget.item!['title'] ?? const Text(""),
                      ),
                    ]
                  : [
                      Container(
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          child: Image.asset(
                            widget.item!['image'] ?? '',
                            width: 150,
                          )),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
                        child: widget.item!['title'] ?? const Text(""),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: widget.item!['description_rich'] ?? const Text(""),
                      ),
                    ],
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: InkWell(
              customBorder: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              onTap: () async {
                if ((widget.index + 1) == widget.totalItem) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomeScreen()));
                } else {
                  await widget.controller.animateToPage(
                    widget.index + 1,
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 200),
                  );
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 52,
                margin:
                    const EdgeInsets.only(top: 30, bottom: 30, left: 30, right: 30),
                padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 5),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 74, 112, 189),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(153, 130, 165, 225),
                      blurRadius: 40,
                      spreadRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Text(
                  widget.item!['button_text'] ?? 'Continue',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
