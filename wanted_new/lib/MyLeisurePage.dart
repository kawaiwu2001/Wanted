import 'package:wanted_new/constants.dart';

import 'ListItem.dart';
import 'package:flutter/material.dart';

class MyLeisurePage extends StatelessWidget {
  const MyLeisurePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //初始化选择页面
        initialIndex: 0,
        //多个页面
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: ImageIcon(AssetImage('assets/icons/back.png'), color: Colors.grey,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),

            //是否Title居中
            centerTitle: true,
            backgroundColor: Colors.white,
            title: const Text('我的闲置',style: TextStyle(color:Colors.black,fontSize: 22),),
            bottom: TabBar(
                unselectedLabelColor: textLightColor,
                labelStyle: TextStyle(fontSize: 18),
                labelColor:keyColor,
                indicatorColor:keyColor,
                tabs: <Widget>[
                Tab(text: '正在发布'),
                Tab(text: '已售出'),
            ]),
          ),
          body: TabBarView(children: [
            Center(child: ListItem()),
            Center(child: ListItem()),
          ]),

          ),
        );
    // TODO: implement build
  }
}

