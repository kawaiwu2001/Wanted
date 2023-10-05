import 'package:flutter/material.dart';
import 'package:wanted_new/constants.dart';
import 'package:wanted_new/text_field_container.dart';

class RoundedInputFieldPassword extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputFieldPassword({
    Key? key,
    required this.hintText,
    required this.controller,
    this.icon = Icons.person,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        style: TextStyle(
          color: textColor
        ),
        controller:controller,
        onChanged: onChanged,
        cursorColor: keyColor,
        obscureText:true,
        decoration: InputDecoration(
          labelText:hintText,
          //prefixText:"    ",
          labelStyle: TextStyle(fontSize: 18.0, color: textLightColor),
          border: InputBorder.none,
        ),

      ),
    );
  }
}