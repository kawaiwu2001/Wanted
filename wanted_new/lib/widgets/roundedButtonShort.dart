import 'package:flutter/material.dart';

class RoundButtonShort extends StatelessWidget {
  final String text;
  final Color color,textColor;
  final Function() onClick;
  const RoundButtonShort({Key? key, required this.text, required this.color, required this.textColor, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onClick,
      child: Text(
        text,
        style: TextStyle(fontSize: 14),
      ),
      style: ButtonStyle(

          padding:
          MaterialStateProperty.all(
              EdgeInsets.all(2)),
          foregroundColor:
          MaterialStateProperty.all<
              Color>(textColor),
          backgroundColor:
          MaterialStateProperty.all<
              Color>(color),
          shape:
          MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(
                    20.0),
              ))),
    );
  }
}
