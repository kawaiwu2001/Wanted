import 'package:flutter/material.dart';
class TagAdd extends StatelessWidget {
  final Function onClick;
  const TagAdd({Key? key, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=>
        onClick(),
      child: Container(
        width: 60,
        height: 30,
        padding: const EdgeInsets.fromLTRB(
            12.0, 5.0, 12.0, 5.0),
        decoration: new BoxDecoration(
          color:  Color.fromARGB(138, 138, 138,138),
          borderRadius:
          BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Icon(Icons.add_rounded,color: Colors.white,size: 20,),
      ),
    );
  }
}
