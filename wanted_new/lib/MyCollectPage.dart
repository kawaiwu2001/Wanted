import 'package:wanted_new/constants.dart';

import 'ListItem.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: MyCollectPage()
    );
  }
}

class MyCollectPage extends StatelessWidget {
  const MyCollectPage({Key? key}) : super(key: key);

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
            icon: const ImageIcon(AssetImage('assets/icons/back.png'), color: Colors.grey,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

          //是否Title居中
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text('我的收藏',style: TextStyle(color:Colors.black,fontSize: 22),),
          bottom: TabBar(
              unselectedLabelColor: textLightColor,
              labelStyle: TextStyle(fontSize: 18),
              labelColor:Colors.green,
              indicatorColor:Colors.green,
              tabs: <Widget>[
                Tab(text: '闲置'),
                Tab(text: '悬赏'),
              ]),
        ),
        body:TabBarView(children: [
          Center(child: ListItem()),
          Center(child: ListItem()),
        ]),

      ),
    );
    // TODO: implement build
  }
}

