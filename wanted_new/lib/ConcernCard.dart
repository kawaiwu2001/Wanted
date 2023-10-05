import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class ConcernCard extends StatefulWidget {
  String name,msg,imageUrl;
  ConcernCard(this.name,this.msg,this.imageUrl,{Key? key}) : super(key: key);

  @override
  _ConcernCardState createState() => _ConcernCardState();
}

class _ConcernCardState extends State<ConcernCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 10,5),
          // width: size.width,
          // height: size.width*75/317,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(100),
                bottomRight: Radius.circular(50),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.5, 0.5), //阴影xy轴偏移量
                    blurRadius: 8.0, //阴影模糊程度
                    spreadRadius: 0.2 //阴影扩散程度
                )
              ]
          ),
          child: InkWell(
            onTap: (){},
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                    child: VerticalDivider(
                  color: Colors.grey,
                  width: 1,
                )
                ),
                Expanded(
                    flex: 12,
                    child: Column(
                      children: [
                        Expanded(
                            child:Row(
                              children: [
                                Text(
                                  widget.name,
                                  style: TextStyle(
                                      color: keyDarkColor,
                                      fontSize: 20
                                  ),
                                ),
                                SizedBox(width: 120),
                                Container(
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    border: Border.all(width: 1, color: keyColor),
                                  ),
                                  child: Text('已关注',
                                      textAlign:TextAlign.center
                                  ),
                                )
                              ],
                            )
                        ),
                        Expanded(
                            child: Row(
                              children: [
                                Text(
                                  widget.msg,
                                  style: TextStyle(
                                      color: keyDarkColor,
                                      fontSize: 15
                                  ),
                                ),
                              ],
                            )
                        )
                      ],
                    )
                ),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child:CircleAvatar(
              backgroundImage: AssetImage(widget.imageUrl),
              radius: size.width*75/317/2,
            )
        ),
      ],
    );
  }
}
