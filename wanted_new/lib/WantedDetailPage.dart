import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wanted_new/constants.dart';

// ignore: must_be_immutable
class WantedDetailPage extends StatefulWidget {
  int id;
  String name,description,location,username;
  double price;
  List<String> imagesList,labelsList;
  WantedDetailPage(this.id,this.name,this.description,this.location,
      this.price,this.username,this.imagesList,this.labelsList,{Key? key}) : super(key: key);
  @override
  _WantedDetailPageState createState() => _WantedDetailPageState();
}

class _WantedDetailPageState extends State<WantedDetailPage> {
  PageController _pageController = new PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: FractionallySizedBox(
                alignment: Alignment.topLeft,
                widthFactor: 1,
                heightFactor: 0.5,
                child: Stack(
                  children: [
                    PageView(
                        scrollDirection: Axis.vertical,
                        controller: _pageController,
                        children: List.generate(widget.imagesList.length, (index) => _page(baseUri+"upload/"+widget.imagesList[index]))
                    ),
                    Positioned(
                      top: 30,
                      left: 10,
                      child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.white,
                            size: 30,
                          )
                      ),

                    ),
                    Positioned(
                      bottom: 165,
                      left: 330,
                      child: Container(
                        padding: const EdgeInsets.all(25),
                        child: SmoothPageIndicator(
                          axisDirection: Axis.vertical,
                          textDirection: TextDirection.rtl,
                          controller: _pageController,
                          count: widget.imagesList.length,
                          effect: WormEffect(
                              dotColor: Colors.white,
                              activeDotColor: keyColor,
                              dotHeight: 14,
                              dotWidth: 14),
                          onDotClicked: (index) =>
                              _pageController.animateToPage(index,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.bounceOut),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.6,
            maxChildSize: 0.9,
            builder: (context, controller) => ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  color: Colors.white,
                  child: ListView(
                    controller: controller,
                    children: [
                      Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  SizedBox(width: 20, height: 30),
                                  ClipOval(
                                    child: Image.asset(
                                      'assets/images/user.png',
                                      fit: BoxFit.cover,
                                      width: 125.0,
                                      height: 125.0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  Column(
                                    children: [

                                      Align(
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 0.0,
                                              height: 10.0,
                                            ),
                                            Text(//username
                                              widget.username,
                                              style: TextStyle(
                                                color: textDarkColor,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(width: 80, height: 10),
                                            TextButton(
                                              onPressed: () {},
                                              child: Text(
                                                '关注',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                              style: ButtonStyle(
                                                  padding:
                                                  MaterialStateProperty.all(
                                                      EdgeInsets.all(2)),
                                                  foregroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(Colors.white),
                                                  backgroundColor:
                                                  MaterialStateProperty.all<
                                                      Color>(keyColor),
                                                  shape:
                                                  MaterialStateProperty.all(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                      ))),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                        height: 20.0,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10.0,
                                            height: 50.0,
                                          ),
                                          Text(
                                            '',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: keyDarkColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 25.0,
                                    height: 10.0,
                                  ),
                                  Text(
                                    widget.name,
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: textLightColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 20.0,
                            height: 30.0,
                          ),
                          Row(children: [
                            SizedBox(
                              width: 25.0,
                            ),
                            Text(
                              widget.description,
                              style: TextStyle(
                                fontSize: 15,
                                color: textLightColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ]),
                          SizedBox(
                            width: 20.0,
                            height: 50.0,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 230.0,
                                width: 10.0,
                              ),
                              Text(
                                '价格: ',
                                style: TextStyle(
                                    fontSize: 14.0, color: keyDarkColor),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(widget.price.toString(),
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    color: keyColor,
                                    fontWeight: FontWeight.bold,
                                  )),
                              Spacer(),
                              Row(
                                children: List.generate(widget.labelsList.length, (index) => _label(widget.labelsList[index]))+[SizedBox(width: 10,)],
                              )
                            ],
                          ),
                          SizedBox(width: 10, height: 60),
                        ],
                      ),
                    ],
                  )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              //margin: EdgeInsets.only(top: 620),
              //alignment: Alignment.bottomCenter,
                height: 120,
                width: double.maxFinite,

                //SizedBox(height: 10,width: 10,),
                decoration: new BoxDecoration(
                  //背景
                  color: Colors.white,
                  //设置四周圆角 角度
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  //设置四周边框
                  border: new Border.all(width: 1, color: Colors.white60),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      icon: ImageIcon(AssetImage("assets/icons/collect.png")),
                      onPressed: () {},
                      iconSize: 35,
                      color: keyColor,
                    ),
                    IconButton(
                      icon: ImageIcon(AssetImage("assets/icons/massage.png")),
                      onPressed: () {},
                      iconSize: 35,
                      color: Colors.grey,
                    ),
                    IconButton(
                      icon: ImageIcon(AssetImage("assets/icons/share.png")),
                      onPressed: () {},
                      iconSize: 35,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    SizedBox(
                      width: 95,
                      height: 40,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '交易',
                          style: TextStyle(fontSize: 20),
                        ),
                        style: ButtonStyle(
                            padding:
                            MaterialStateProperty.all(EdgeInsets.all(2)),
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                            MaterialStateProperty.all<Color>(keyColor),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ))),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: keyColor,
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: CustomFloatingActionButtonLocation(
          FloatingActionButtonLocation.endFloat, 0, -60),
    );
  }
}
Widget _page(String picturePath) {
  return Container(
    child: Image.network(
      picturePath,
      fit: BoxFit.fill,
    ),
  );
}

Widget _label(String text){
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: Container(
      width: 60,
      height: 30,
      padding: const EdgeInsets.fromLTRB(
          12.0, 5.0, 12.0, 5.0),
      decoration: new BoxDecoration(
        color: keyLightColor,
        borderRadius:
        BorderRadius.all(Radius.circular(15.0)),
      ),
      //labels
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 12.0, color: keyDarkColor),
      ),
    ),
  );
}
class CustomFloatingActionButtonLocation extends FloatingActionButtonLocation {
  FloatingActionButtonLocation location;
  double offsetX; // X方向的偏移量
  double offsetY; // Y方向的偏移量
  CustomFloatingActionButtonLocation(this.location, this.offsetX, this.offsetY);

  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    Offset offset = location.getOffset(scaffoldGeometry);
    return Offset(offset.dx + offsetX, offset.dy + offsetY);
  }
}
