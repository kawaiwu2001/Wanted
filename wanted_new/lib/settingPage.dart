import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanted_new/LoginPage.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'constants.dart';
import 'package:http/http.dart' as http;

class settingPage extends StatefulWidget{
  const settingPage({Key? key}) : super(key: key);

  @override
  _settingPageState createState() => _settingPageState();
}

class _settingPageState extends State<settingPage> {
  //String deleteRes = "";

  Future<String> deleteUser(int userId) async{
    final uri = baseUri+"deleteUser";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['userId'] = userId.toString();
    var streamedResponse = await request.send();
    if(streamedResponse.statusCode == HttpStatus.ok) {
      var response = await http.Response.fromStream(streamedResponse);

      return response.body;

    }else{
      return "-1";
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: () {
            Navigator.pop(context);
          },  icon:Icon(
            Icons.arrow_back_ios_rounded,
            color: backArrowColor,
            size: 25,
          )
          ),
          title: const Text('设置',style: TextStyle(color: textLightColor),),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children:[
          Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(onPressed: (){},
                  color: Colors.white,
                  child:Row(
                    children: const [
                      SizedBox(width: 20,),
                      Text("收货地址",textAlign:TextAlign.left,),
                    ],
                  ) ),
            ),
            const SizedBox(height: 2,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(onPressed: (){},
                color: Colors.white,
                  child:Row(
                    children: const [
                      SizedBox(width: 20,),
                      Text("个人资料设置",textAlign:TextAlign.left,),
                    ],
                  ),),
            ),
            const SizedBox(height: 2,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(onPressed: (){},
                  color: Colors.white,
                  child:Row(
                    children: [
                      const SizedBox(width: 20,),
                      const Text("学生认证",textAlign:TextAlign.left,),
                      SizedBox(width: MediaQuery.of(context).size.width-200,),
                      Image.asset("assets/icons/stuyes.png",alignment: Alignment.centerRight,),
                      const SizedBox(width: 10,),
                      const Text("已认证",textAlign:TextAlign.left,),
                    ],
                  ) ),
            ),
            const SizedBox(height: 2,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(onPressed: (){},
                  color: Colors.white,
                  child:Row(
                    children: const [
                      SizedBox(width: 20,),
                      Text("支付设置",textAlign:TextAlign.left,),
                    ],
                  ) ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 20,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(onPressed: (){},
                  color: Colors.white,
                  child:Row(
                    children: const [
                      SizedBox(width: 20,),
                      Text("帮助与反馈",textAlign:TextAlign.left,),
                    ],
                  ) ),
            ),
            const SizedBox(height: 2,),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: FlatButton(onPressed: (){},
                  color: Colors.white,
                  child:Row(
                    children: const [
                      SizedBox(width: 20,),
                      Text("客服",textAlign:TextAlign.left,),
                    ],
                  )
              ),
            ),
            SizedBox(height: 0.18*MediaQuery.of(context).size.height,),
            MaterialButton(
              minWidth: 0.8*MediaQuery.of(context).size.width,
              height: 50,
              color: const Color.fromARGB(255, 30,167, 85),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              textColor: Colors.white,
              child: const Text('退出登录',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
              onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                  },
            ),
            const SizedBox(height: 10,),
            MaterialButton(
              minWidth: 0.8*MediaQuery.of(context).size.width,
              height: 50,
              color: const Color.fromARGB(255, 204,79, 99),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              textColor: Colors.white,
              child: const Text('注销账号',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold ),),
              onPressed: ()async{
                String res = await deleteUser(int.parse(userIdFlutter));
                if(res == "1"){
                  Fluttertoast.showToast(msg: "注销账号成功");
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                }else{
                  Fluttertoast.showToast(msg: "注销账号错误");
                }

              },
            )
          ],
        )
          ]

        ),
      ),
    );
    // TODO: implement build
    throw UnimplementedError();
  }
}