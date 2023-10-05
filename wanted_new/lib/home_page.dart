import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:wanted_new/OtherPage.dart';
import 'package:wanted_new/UploadProduct.dart';
import 'package:wanted_new/UploadWanted.dart';
import 'package:wanted_new/UserMessagePage.dart';
import 'package:wanted_new/MessagePage.dart';
import 'package:wanted_new/RewardPage.dart';
import 'package:wanted_new/constants.dart';
import 'package:wanted_new/costom_icons.dart';
import 'package:wanted_new/mypage.dart';
import 'package:wanted_new/shoppingPage.dart';

import 'CircularButton.dart';
import 'bottomNavigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation degOneTranslationAnimation;
  late Animation rotationAnimation;
  bool isshow = false;

  bool clickW = false;
  //late Animation<Color> animation;
  // @override
  // void dispose() {
  //   animationController.dispose();
  //   super.dispose();
  // }

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  int _currentIndex = 0;
  var _pageList = [
    ShoppingPage(),
    RewardPage(),
    MessagePage(),
    //UserMessagePage(),
    MyPage(),
    //OtherPage(),
    //UserMassagePage()
  ];

  void selectedTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation =
        Tween(begin: 0.0, end: 1.0).animate(animationController);
    rotationAnimation = Tween(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();

    animationController.addListener(() {
      setState(() {});
    });
  }
  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        this._pageList[this._currentIndex],
        _blackContainer(isshow),
        //閒置icon
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegree(225),
                degOneTranslationAnimation.value * 100),
            child: Transform(
              transform: Matrix4.rotationZ(
                  getRadiansFromDegree(rotationAnimation.value))
                ..scale(degOneTranslationAnimation.value * 3),
              alignment: Alignment.center,
              child: CircularButton(
                color: Color.fromARGB(0, 0, 0, 0),
                icon: ImageIcon(
                  AssetImage('assets/icons/unused.png'),
                  color: Colors.white,
                  size: 24,
                ),
                onClick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return UploadProduct();
                  }));
                }, text: '闲置',),
            ),
          ),
        ),
        //懸賞icon
        Align(
          alignment: Alignment.bottomCenter,
          child: Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegree(315),
                degOneTranslationAnimation.value * 100),
            child: Transform(
              transform: Matrix4.rotationZ(
                  getRadiansFromDegree(rotationAnimation.value))
                ..scale(degOneTranslationAnimation.value * 3),
              alignment: Alignment.center,
              child: CircularButton(
                color: Color.fromARGB(0, 0, 0, 0),
                icon: ImageIcon(
                  AssetImage('assets/icons/wantedlogo.png'),
                  color: Colors.white,
                  size: 24,
                ),
                onClick: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return UploadWanted();
                  }));
                }, text: '悬赏',
              ),
            ),
          ),
        ),
      ]
      ),
      bottomNavigationBar: FABBottomAppBar(
        centerItemText: '发布',
        color: Colors.grey.shade500,
        selectedColor: keyColor,
        notchedShape: CircularNotchedRectangle(),
        onTabSelected: selectedTab,
        backgroundColor: Colors.white,
        items: [
          FABBottomAppBarItem(iconData: Costom.shopping, text: '购物'),
          FABBottomAppBarItem(iconData: Costom.wanted, text: '悬赏'),
          FABBottomAppBarItem(iconData: Costom.message, text: '消息'),
          FABBottomAppBarItem(iconData: Costom.my, text: '我'),
        ],
      ),
     floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          if (animationController.isCompleted) {
            animationController.reverse();
            isshow = false;
            // clickP = false;
          } else {
            animationController.forward();
            isshow = true;
            // clickP = true;
          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add,size: 30,),
        elevation: 2.0,
      ),
       // This trailing comma makes auto-formatting nicer for build methods.

    );
  }

}



//点击+后背景变黑
Widget _blackContainer(bool isshow) {
  var content;
  if (isshow) {
    //如果数据不为空，则显示Text
    content = Container(
      //width: size.width,
      //height: size.height,
      color: isshow?Colors.black54:Color.fromARGB(0, 0, 0,0),
    );
  } else {
    //当数据为空我们需要隐藏这个Text
    //我们又不能返回一个null给当前的Widget Tree
    //只能返回一个长宽为0的widget占位
    content = new Container(height:0.0,width:0.0);
  }
  return content;
}

