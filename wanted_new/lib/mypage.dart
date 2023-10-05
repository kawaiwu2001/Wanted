import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wanted_new/MyCollectPage.dart';
import 'package:wanted_new/MyLeisurePage.dart';
import 'package:wanted_new/MyWantedPage.dart';
import 'package:wanted_new/concernsPage.dart';
import 'package:wanted_new/constants.dart';
import 'package:wanted_new/detailButtonForPage.dart';
import 'package:wanted_new/settingPage.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';

class MyPage extends StatefulWidget{
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String username = "";

  Future<dynamic> getUserName(int userId) async{
    final uri = baseUri+"getUserName";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['userId'] = userId.toString();
    var streamedResponse = await request.send();
    if(streamedResponse.statusCode == HttpStatus.ok){
      var response = await http.Response.fromStream(streamedResponse);
      //var jsonData = json.decode(response.body);
      //print(jsonData);
      setState(() {
        username = response.body;
        print(username);
      });
    }else{
      print('error');
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserName(int.parse(userIdFlutter));
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.4,
                alignment: Alignment.topCenter,
                child:ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child:
                  Image.asset("assets/images/user.png",
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

              Align(
                //确保以下组件居中对齐
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    //设置边距
                    SizedBox(height: 30,width: 450,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                          width: 120,
                        ),
                        Container(
                          alignment: Alignment.topCenter,
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/images/user.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                          width: 55,
                        ),
                        IconButton(
                            onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder:(context){
                                return settingPage();
                              }));
                            },
                            icon:Icon(
                              Icons.settings_outlined,
                              color: keyColor,
                              size: 30,
                            )

                        ),
                        // TextButton(
                        //   onPressed: () {},
                        //   child: Text(
                        //     '关注',
                        //     style: TextStyle(fontSize: 14),
                        //   ),
                        //   style: ButtonStyle(
                        //       padding:
                        //       MaterialStateProperty.all(
                        //           EdgeInsets.all(2)),
                        //       foregroundColor:
                        //       MaterialStateProperty.all<
                        //           Color>(Colors.white),
                        //       backgroundColor:
                        //       MaterialStateProperty.all<
                        //           Color>(keyColor),
                        //       shape:
                        //       MaterialStateProperty.all(
                        //           RoundedRectangleBorder(
                        //             borderRadius:
                        //             BorderRadius.circular(
                        //                 20.0),
                        //           ))),
                        // ),

                      ],
                    ),
                    //头像

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
                      child: new Text(username,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: keyDarkColor,
                            fontSize: 18,
                            decoration: TextDecoration.none//去掉下划线
                        ),),
                    ),
                     SizedBox(
                      height: 10,
                      width: 450,
                    ),
                    Follow(firsttap: '我的收藏',secondtap: '我的关注',
                      firsticon: 'assets/icons/collect.png',secondicon: 'assets/icons/yes.png',
                      onClick1: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){return MyCollectPage();
                      })); },
                      onClick2: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){return ConcernsPage();
                        }));
                      },),
                    const SizedBox(
                      height: 10,
                      width: 450,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            PageButton(
                              logo: 'assets/icons/unused.png',
                              num: '15',
                              inform: '我的闲置',
                              onClick: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context){return MyLeisurePage();}));
                              },
                            ),
                            SizedBox(width: 10,height: 20,),
                            PageButton(logo: 'assets/icons/post.png',num: '20',inform: '购买记录',
                              onClick:(){

                            }, ),
                          ],
                        ),
                        SizedBox(width: 20,height: 20,),
                        Column(
                            children: [
                              PageButton(logo: 'assets/icons/wantedlogo.png',
                                num: '8',
                                inform: '我的悬赏',
                                onClick: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){return MyWantedPage();}));
                                },
                              ),
                              SizedBox(width: 10,height: 20,),
                              PageButton(logo: 'assets/icons/award.png',num: '15',inform: '已接悬赏',
                                onClick:(){

                                },),
                            ]
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
  }
}

