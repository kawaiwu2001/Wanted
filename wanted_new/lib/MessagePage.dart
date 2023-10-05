import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanted_new/MessageCard.dart';
import 'package:wanted_new/constants.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.09),
      child: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        title: Text(
          "消息",
          style: TextStyle(
              color: Colors.black,
            fontSize: 25
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [

        ],
      ),),
      body: GridView.count(
        padding: EdgeInsets.all(10),
        childAspectRatio: 317/75,
        crossAxisCount: 1,
        mainAxisSpacing: 10,
        children: [
          MessageCard('张文','你好，请问可以小刀ma?','9:00','https://i.bmp.ovh/imgs/2022/04/10/b2a5adb6df81fbc2.png',1),
          MessageCard('小莉','还有多少?','9:00','https://s3.bmp.ovh/imgs/2022/04/20/9a2e3902540d56f4.jpg',2),
          //MessageCard('用户名','你好，请问可以小刀ma?','9:00','assets/images/user2.png',2),
        ],
      )
    );
  }
}
