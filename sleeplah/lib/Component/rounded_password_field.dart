import 'package:sleeplah/Component/text_field_container.dart';
import '../constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedPasswordField extends StatefulWidget {
  final String text;
  final onChanged;
  final IconData? icon;

  RoundedPasswordField(
      { required this.text,
      this.onChanged,
      this.icon}
      );

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState(text, onChanged,icon);
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool obscure = true;
  late final onChanged;
  final text;
  IconData? icon;



  _RoundedPasswordFieldState(this.text, this.onChanged,this.icon);

  @override
  Widget build(BuildContext context) {

    return TextFieldContainer(
      child: TextField(
        obscureText: obscure,
        onChanged: onChanged,
        cursorColor: themePrimaryColor,
        decoration: InputDecoration(
          hintText: text,
          icon: icon == null? null:Icon(
            icon,
            color: themePrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscure? Icons.visibility : Icons.visibility_off,
              color: themePrimaryColor,),
            onPressed: () {setState(() {
              obscure = !obscure;
            });},
          ),
          border: InputBorder.none,

        ),
      ),
    );
  }
}