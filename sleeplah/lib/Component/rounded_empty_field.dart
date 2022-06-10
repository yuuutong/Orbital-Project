import 'package:sleeplah/Component/rounded_password_field.dart';
import 'package:sleeplah/Component/text_field_container.dart';
import '../constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedEmptyField extends StatelessWidget {
  final String title;
  final String hintText;
  final ValueChanged<String> onChanged;
  final bool isPassword;

  RoundedEmptyField({
    required this.hintText,
    required this.onChanged,
    required this.title,
    required this.isPassword
  }) : super();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("    " + title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          isPassword?
          RoundedPasswordField(text: hintText, onChanged: onChanged)
          : TextFieldContainer(
            child: TextField(
              onChanged: onChanged,
              cursorColor: themePrimaryColor,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          )
        ]),
      );
    }
  }