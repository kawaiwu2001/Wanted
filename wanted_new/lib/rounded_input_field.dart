import 'package:flutter/material.dart';
import 'package:wanted_new/constants.dart';
import 'package:wanted_new/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.controller ,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        cursorColor: keyColor,
        //obscureText:true,
        decoration: InputDecoration(
          labelText: hintText,
         // prefixText:"    ",
          labelStyle: TextStyle(fontSize: 18.0, color: textLightColor),
          border: InputBorder.none,
        ),

      ),
    );
  }
}