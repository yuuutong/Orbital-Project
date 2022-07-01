import 'package:sleeplah/configurations/text_field_container.dart';
import '../constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    required this.hintText,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: onChanged,
        cursorColor: themePrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: themePrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}