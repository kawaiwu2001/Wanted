import 'package:flutter/material.dart';

class PictureAdd extends StatelessWidget {
  final Function onClick;
  const PictureAdd({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>
        onClick(),
      child: Container(
          width: 112,
          height: 112,
          color: Color.fromARGB(138, 138, 138,138),
          child: Icon(Icons.add_rounded,color: Colors.white,size: 60,)
      ),
    );
  }
}
