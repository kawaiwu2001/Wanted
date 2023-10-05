import 'package:wanted_new/constants.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      color: keyLightColor,
      child: Stack(
        alignment: Alignment.center,
        children:<Widget> [
          Positioned(
              left: 0,
              bottom: 520,
              child:Image.asset("assets/images/little_square1.png")
          ),
          Positioned(
              right: 0,
              bottom: -350,
              child: Image.asset("assets/images/little_square2.png")
          ),
          child,
        ],
      ),
    );
  }
}
