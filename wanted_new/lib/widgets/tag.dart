import 'package:flutter/material.dart';
class Tag extends StatelessWidget {
  final Color color,textColor;
  final String text;
  const Tag({Key? key, required this.color, required this.textColor, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 30,
      padding: const EdgeInsets.fromLTRB(
          12.0, 5.0, 12.0, 5.0),
      decoration: new BoxDecoration(
        color: color,
        borderRadius:
        BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 12.0, color: textColor),
        ),
      ),
    );
  }
}
