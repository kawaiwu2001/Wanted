import 'package:flutter/material.dart';

class CircularButton extends StatefulWidget {
  final Color color;
  final ImageIcon icon;
  final Function onClick;
  final String text;
  CircularButton(
      {required this.color,
        required this.icon,
        required this.onClick,
        required this.text,
      });

  @override
  _CircularButtonState createState() => _CircularButtonState();
}

class _CircularButtonState extends State<CircularButton> {
  @override
  Widget build(BuildContext context) {
    return  TextButton(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                IconButton(onPressed: (){widget.onClick();}, icon: widget.icon,enableFeedback: true,),
                Text(widget.text,style: TextStyle(
                    color: Colors.white,
                    fontSize: 6
                ),)
              ],
            ),
            onPressed: (){}
    );
  }
}