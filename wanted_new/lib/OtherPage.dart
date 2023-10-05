import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wanted_new/constants.dart';
import 'package:wanted_new/detailButtonForPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        home: OtherPage()

    );
  }
}

class OtherPage extends StatelessWidget{
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.4,
              alignment: Alignment.topCenter,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child:
                Image.asset("assets/images/user2.png",
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //对上面的图片进行高斯模糊
            BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 5.0,
                  sigmaY: 5.0
              ),
              child: Center(
                child: Container(
                  color: Colors.red.withOpacity(0),
                ),
              ),
            ),
            //头像和信息组件
            Positioned(
              left: 12,
              top: 10,
              child:
                IconButton(onPressed: (){}, icon: const ImageIcon(AssetImage('assets/icons/back.png'))),
            ),
            Positioned(
                right: 12,
                top: 10,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    '已关注',
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ButtonStyle(
                      padding:
                      MaterialStateProperty.all(
                          EdgeInsets.all(2)),
                      foregroundColor:
                      MaterialStateProperty.all<
                          Color>(keyColor),
                      backgroundColor:
                      MaterialStateProperty.all<
                          Color>(Colors.white),
                      shape:
                      MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(
                                20.0),
                          ))),
                ),
            ),
            Align(
              //确保以下组件居中对齐
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  //设置边距
                  const SizedBox(height: 30,width: 450,),
                  //头像
                  Container(
                    alignment: Alignment.topCenter,
                    width: 140.0,
                    height: 140.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/user2.png'),
                      ),
                    ),
                  ),
                  //边距
                  const SizedBox(
                    height: 10,
                    width: 450,
                  ),
                  //personal information
                  Container(
                    //设置 child 居中
                    alignment: Alignment.topCenter,
                    height: 55,
                    width: 354,
                    //渐变背景设置
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color.fromRGBO(255, 253, 253, 0.0),
                            Color.fromRGBO(253, 248, 248, 1.0),
                            Color.fromRGBO(255, 253, 253, 0.0),],
                          stops: [0,.5,1]
                      ),

                      //设置四周圆角 角度
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      //设置四周边框

                    ),
                    //文字部分
                    child: const Text("张三\n华中科技大学机械学院2018级",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: keyDarkColor,
                          fontSize: 18,
                          decoration: TextDecoration.none//去掉下划线
                      ),),
                  ),
                  const SizedBox(
                    height: 10,
                    width: 450,
                  ),
                  Follow(firsttap: 'TA的关注',secondtap: 'TA的粉丝',
                    firsticon: 'assets/icons/yes.png',secondicon: 'assets/icons/fans.png', onClick2: () {  }, onClick1: () {  },),
                  const SizedBox(
                    height: 10,
                    width: 450,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                          PageButton(logo: 'assets/icons/unused.png',num: '15',inform: 'TA的闲置', onClick: () {  },),
                          SizedBox(width: 20,height: 20,),
                          PageButton(logo: 'assets/icons/wantedlogo.png',num: '8',inform: 'TA的悬赏', onClick: () {  },),
                          ]
                      ),
                  const SizedBox(width: 10,
                  height: 10,),
                  //評價
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    child:Container(
                      width: 354,
                      height: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(color: Colors.grey,width: 1),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(15.0, 15.0), //阴影xy轴偏移量
                                blurRadius: 50.0, //阴影模糊程度
                                spreadRadius: 50.0 //阴影扩散程度
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                                SizedBox(width: 20,height: 30,),
                               Text('评价',style: TextStyle(color: Colors.grey),),
                            ],
                          ),
                          Row(
                            children: [
                              const SizedBox(width: 15,height: 20,),
                              Container(
                                decoration: BoxDecoration(
                                //背景
                                color: Colors.white,
                                //设置四周圆角 角度
                                borderRadius: const BorderRadius.all(Radius.circular(19.0)),
                                //设置四周边框
                                border: Border.all(width: 1, color: Colors.grey),
                                ),
                                  width: 50,
                                  height: 20,
                                  child: const Text("nice",style: TextStyle(color: Colors.grey),textAlign:TextAlign.center),
                                ),
                              const SizedBox(width: 15,height: 10,),
                              Container(
                                decoration: BoxDecoration(
                                  //背景
                                  color: Colors.white,
                                  //设置四周圆角 角度
                                  borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                                  //设置四周边框
                                  border: Border.all(width: 1, color: Colors.grey),
                                ),
                                width: 50,
                                height: 20,
                                child: const Text("贴心",style: TextStyle(color: Colors.grey,fontSize: 12),textAlign:TextAlign.center, ),
                              ),
                            ],
                          ),
                          const Command(),
                          const Command(),
                          const Command(),
                        ],
                      ),
                    ),
                  ),
                    ],
                  ),
            ),
                    ],
              ),
      ),
          );
  }
}

class Command extends StatelessWidget{
  const Command({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(width: 10,height: 25,),
        Row(
          children: [
            const SizedBox(width: 15,height: 10,),
            Image.asset('assets/images/user.png',width: 50,),
            const SizedBox(width: 20,height: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('胡老板很nice！',style: TextStyle(color: Colors.green),),
                SizedBox(width: 10,height: 10,),
                Text('2021.05.21',style: TextStyle(color: Colors.green),),
              ],
            ),
            const SizedBox(width: 120,height: 20,),
            IconButton(onPressed: (){}, icon: const ImageIcon(AssetImage('assets/icons/xinaixin.png'),color: Colors.green,))
          ],
        )
      ],
    );
    // TODO: implement build
    throw UnimplementedError();
  }

}