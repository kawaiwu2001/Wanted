import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'WantedDetailPage.dart';
import 'constants.dart';

class WantedCard extends StatefulWidget {
  //final Map wantedInfo;
  String name,description,location,username;
  List<String> imagesList,labelsList;
  double price;
  int id;
  bool isMarked;

  WantedCard(this.id,this.name,this.description,this.location,this.price,this.username,this.imagesList,this.labelsList ,{Key? key, this.isMarked = false})
      : super(key: key);

  @override
  _WantedCardState createState() => _WantedCardState();
}

class _WantedCardState extends State<WantedCard> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // height: size.height*0.28,
      // width: size.width*0.4,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color.fromARGB(255, 233, 246, 237),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.5, 0.5), //阴影xy轴偏移量
                blurRadius: 8.0, //阴影模糊程度
                spreadRadius: 0.2 //阴影扩散程度
            )
          ]),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      //点卡片进去
                      return WantedDetailPage(widget.id,widget.name,widget.description,widget.location,
                          widget.price,widget.username, widget.imagesList,widget.labelsList);
                    }));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: ConstrainedBox(
                      // child: Image.asset(
                      //   widget.reward_imageUrl,
                      //   fit: BoxFit.cover,
                      // ),
                      child: Image.network(
                        baseUri+"upload/"+widget.imagesList[0],
                        fit: BoxFit.cover,
                      ),
                      constraints: new BoxConstraints.expand(),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    splashRadius: 0.01,
                    icon: ImageIcon(
                      AssetImage("assets/icons/star.png"),
                      color: widget.isMarked ? keyColor : Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.isMarked = widget.isMarked ? false : true;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                      flex: 11,
                      child: InkWell(
                        onTap: () {},
                        child: ListTile(
                          contentPadding: EdgeInsets.fromLTRB(5, 3, 5, 0),
                          title: Text(
                            widget.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1),
                          ),
                          subtitle: Text(
                            widget.description,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: TextStyle(
                                color: textLightColor,
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                                letterSpacing: 1),
                          ),
                        ),
                      )
                  ),
                  Expanded(
                      flex: 7,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '¥',
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    letterSpacing: 1),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.price.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: keyColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    letterSpacing: 1),
                              ),
                            ),
                          Spacer(),
                            IconButton(
                              // alignment: Alignment.centerRight,
                              splashRadius: 0.01,
                              iconSize: 26,
                              icon: ImageIcon(
                                AssetImage("assets/icons/massage.png"),
                              ),
                              onPressed: () {},
                              color: keyColor,
                            ),
                            IconButton(
                              // alignment: Alignment.centerRight,
                              splashRadius: 0.01,
                              iconSize: 24,
                              icon: Icon(Icons.add_circle_outline,
                                  color: keyColor),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
