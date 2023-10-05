import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Chart.dart';
import 'constants.dart';

class MessageCard extends StatefulWidget {
  String name,msg,time,imageUrl;
  int num;
  MessageCard(this.name,this.msg,this.time,this.imageUrl,this.num,{Key? key}) : super(key: key);

  @override
  _MessageCardState createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
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
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context){
                        return ChatPage();
                      }));
            },
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Container(),
                ),
                Expanded(
                    flex: 5,
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
                                Spacer(),
                                Text(
                                    widget.time,
                                    style: TextStyle(
                                        color: keyDarkColor,
                                        letterSpacing: 1.5,
                                        fontSize: 18
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
                                //SizedBox(width: 40),
                                Spacer(),
                                Container(
                                  width: 18,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    border: Border.all(width: 1, color: keyColor),
                                  ),
                                  child: Text(widget.num.toString(),
                                    textAlign:TextAlign.center
                                  ),
                                )
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
              backgroundImage: NetworkImage(widget.imageUrl),
              radius: size.width*75/317/2,
            )
        ),
      ],
    );
  }
}
