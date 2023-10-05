import 'package:flutter/material.dart';
import 'package:wanted_new/constants.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final Function() press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = keyColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
          color: color,
          onPressed:press,
          child: Text(
            text,
            style: TextStyle(color: textColor,fontSize: 18.0,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}