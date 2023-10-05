import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanted_new/ConcernCard.dart';
import 'package:wanted_new/constants.dart';

class ConcernsPage extends StatelessWidget {
  const ConcernsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:  PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.09),
          child: AppBar(
            iconTheme: IconThemeData(color: textColor),
            elevation: 2,
            title: Text(
              "我的关注",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25
              ),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),),
        body: GridView.count(
          padding: EdgeInsets.all(10),
          childAspectRatio: 317/75,
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          children: [
            ConcernCard('李四','在校本科生，喜好音乐。','assets/images/user2.png'),
            ConcernCard('王五','在校本科生，喜好绘画。','assets/images/user2.png'),
            ConcernCard('赵六','在校本科生，喜好文学。','assets/images/user2.png'),
          ],
        )
    );
  }
}
