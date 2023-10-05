import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wanted_new/background.dart';
import 'package:wanted_new/rounded_button.dart';
import 'package:wanted_new/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:wanted_new/text_field_container.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:wanted_new/widgets/toast.dart';

import 'constants.dart';
class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {


  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConformController = TextEditingController();

  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _passwordConformFocusNode = FocusNode();

  String _responseString = "";
  String catchError = "";
  //Stream 更新操作控制器
  StreamController _userNameStream = new StreamController();
  //StreamController<String> _userNameStream = new StreamController();
  StreamController _userPasswordStream = new StreamController();
  StreamController _userPasswordConformStream = new StreamController();

  //抖动动画控制器
  ShakeAnimationController _userNameAnimation = new ShakeAnimationController();
  ShakeAnimationController _userPasswordAnimation = new ShakeAnimationController();
  ShakeAnimationController _userPasswordConformAnimation = new ShakeAnimationController();

  Future<void> postData(String username,String password) async{

    final uri = baseUri + "user";
   // final uri = "http://10.0.2.2:8080/user";
    print('username: $username');
    try{
      final response = await http.post(
          Uri.parse(uri),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body:jsonEncode(<String,String>{
            "name": username,
            "password": password
          }),
      );

      if(response.statusCode == HttpStatus.ok){
        //print(response.body);
        this.setState(() {
          _responseString = response.body;
        });

      }else{
        this.setState(() {
          _responseString = response.statusCode.toString();
        });
      }

    }catch(er){
      this.setState(() {
        _responseString = er.toString();
        catchError = uri;
      });
    }
  }


  void show(){
    String username = _usernameController.text;
    String password = _passwordController.text;
    String passwordConform = _passwordConformController.text;
    //print('username: $username $password $passwordConform');
  }

  void hindKeyBoarder() {
    //输入框失去焦点
    _usernameFocusNode.unfocus();
    _passwordFocusNode.unfocus();
    _passwordConformFocusNode.unfocus();
    //隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        hindKeyBoarder();
      },
      child: Scaffold(
          body:Background(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                //verticalDirection: VerticalDirection.up,
                children: <Widget>[
                  Row(
                    children: [
                      IconButton(onPressed:(){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back_ios_rounded,color: backArrowColor,),
                      )],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Container(
                      height: 150.0,
                      width: 150.0,
                      child: Image.asset("assets/images/user.png")
                  ),
                  SizedBox(height: size.height * 0.08),
                  TextFieldContainer(child: buildUserNameWidget()),
                  // RoundedInputField(
                  //   controller: _usernameController,
                  //   hintText: "用户名",
                  //   onChanged: (value) {},
                  // ),
                  SizedBox(height: size.height * 0.02),
                  TextFieldContainer(child: buildUserPasswordWidget()),
                  // RoundedInputFieldPassword(
                  //   controller: _passwordController,
                  //   hintText: "密码",
                  //   onChanged: (value) {},
                  // ),
                  SizedBox(height: size.height * 0.02),
                  TextFieldContainer(child: buildUserPasswordConformWidget()),
                  // RoundedInputFieldPassword(
                  //   controller: _passwordConformController,
                  //   hintText: "确定密码",
                  //   onChanged: (value) {
                  //   },
                  // ),
                  SizedBox(height: size.height * 0.1),
                  RoundedButton(
                    text: "注册",
                    press: () async {
                      show();
                      if(checkLoginFunction()){
                        final String username = _usernameController.text;
                        final String password = _passwordController.text;
                        await postData(username,password);
                        if(_responseString == "注冊成功"){
                          showToast('$_responseString');
                          Navigator.pop(context);
                        }else{
                          showToast('$_responseString');
                          showToast('$catchError');
                        }

                      }
                      },

                  ),
                ],
              ),
            ),

          )
      ),
    );
  }
  StreamBuilder<dynamic> buildUserNameWidget() {
    return StreamBuilder<dynamic>(
      stream: _userNameStream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ShakeAnimationWidget(
          //微左右的抖动
          shakeAnimationType: ShakeAnimationType.LeftRightShake,
          //设置不开启抖动
          isForward: false,
          //抖动控制器
          shakeAnimationController: _userNameAnimation,
          child: TextField(
            style: TextStyle(
                color: textColor
            ),
            //焦点控制
            focusNode: _usernameFocusNode,
            //文本控制器
            controller: _usernameController,
            //键盘回车键点击回调
            onSubmitted: (String value) {
              //点击校验，如果有内容输入 输入焦点跳入下一个输入框
              if (checkUserName()) {
                _usernameFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              } else {
                FocusScope.of(context).requestFocus(_usernameFocusNode);
              }
            },
            //边框样式设置
            decoration: InputDecoration(
              //红色的错误提示文本
              errorText: snapshot.data,
              labelStyle: TextStyle(
                  color: textColor
              ),
              labelText: "用户名",
              //设置上下左右 都有边框
              //设置四个角的弧度

              border: OutlineInputBorder(
                //设置边框四个角的弧度
                borderSide: BorderSide(color: keyLightColor),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              errorBorder: OutlineInputBorder(
                //设置边框四个角的弧度
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              focusedBorder: OutlineInputBorder(
                //设置边框四个角的弧度
                borderSide: BorderSide(color: keyColor),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              enabledBorder: OutlineInputBorder(
                //设置边框四个角的弧度
                borderSide: BorderSide(color: keyLightColor),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        );

      },
    );
  }

  StreamBuilder<dynamic> buildUserPasswordWidget() {
    return StreamBuilder<dynamic>(
      stream: _userPasswordStream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ShakeAnimationWidget(
          //微左右的抖动
          shakeAnimationType: ShakeAnimationType.LeftRightShake,
          //设置不开启抖动
          isForward: false,
          //抖动控制器
          shakeAnimationController: _userPasswordAnimation,
          child: TextField(
            style: TextStyle(
                color: textColor
            ),
            focusNode: _passwordFocusNode,
            controller: _passwordController,
            onSubmitted: (String value) {
              if (checkUserPassword()) {
                _passwordFocusNode.unfocus();
                FocusScope.of(context).requestFocus(_passwordConformFocusNode);
              } else {
                FocusScope.of(context).requestFocus(_passwordFocusNode);
              }
            },
            //隐藏输入的文本
            obscureText: true,
            //最大可输入1行
            maxLines: 1,
            //边框样式设置
            decoration: InputDecoration(
              labelText: "密码",
              labelStyle: TextStyle(
                  color: textColor
              ),
              errorText: snapshot.data,

              border: OutlineInputBorder(
                //设置边框四个角的弧度
                //borderSide: BorderSide(color: Colors.yellowAccent),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              errorBorder: OutlineInputBorder(
                //设置边框四个角的弧度
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              focusedBorder: OutlineInputBorder(
                //设置边框四个角的弧度
                borderSide: BorderSide(color: keyColor),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              enabledBorder: OutlineInputBorder(
                //设置边框四个角的弧度
                borderSide: BorderSide(color: keyLightColor),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        );

      },
    );
  }

  StreamBuilder<dynamic> buildUserPasswordConformWidget() {
    return StreamBuilder<dynamic>(
      stream: _userPasswordConformStream.stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return ShakeAnimationWidget(
          //微左右的抖动
          shakeAnimationType: ShakeAnimationType.LeftRightShake,
          //设置不开启抖动
          isForward: false,
          //抖动控制器
          shakeAnimationController: _userPasswordConformAnimation,
          child: TextField(
            style: TextStyle(
                color: textColor
            ),
            focusNode: _passwordConformFocusNode,
            controller: _passwordConformController,
            onSubmitted: (String value) {
              if (checkUserPasswordConform()) {
                loginFunction();
              } else {
                FocusScope.of(context).requestFocus(_passwordConformFocusNode);
              }
            },
            //隐藏输入的文本
            obscureText: true,
            //最大可输入1行
            maxLines: 1,
            //边框样式设置
            decoration: InputDecoration(
              labelText: "确定密码",
              labelStyle: TextStyle(
                  color: textColor
              ),
              errorText: snapshot.data,

              border: OutlineInputBorder(
                //设置边框四个角的弧度
                //borderSide: BorderSide(color: Colors.yellowAccent),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              errorBorder: OutlineInputBorder(
                //设置边框四个角的弧度
                borderSide: BorderSide(color: Colors.red),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              focusedBorder: OutlineInputBorder(
                //设置边框四个角的弧度
                borderSide: BorderSide(color: keyColor),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              enabledBorder: OutlineInputBorder(
                //设置边框四个角的弧度
                borderSide: BorderSide(color: keyLightColor),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ),
        );

      },
    );
  }
  bool checkUserName() {
    //获取输入框中的输入文本
    String userName = _usernameController.text;
    if (userName.length == 0) {
      //Stream 事件流更新提示文案
      _userNameStream.add("请输入用户名");

      //抖动动画开启
      _userNameAnimation.start();
      return false;
    } else {
      //清除错误提示
      _userNameStream.add(null);
      return true;
    }
  }

  bool checkUserPassword() {
    String userPassword = _passwordController.text;
    if (userPassword.length == 0) {
      _userPasswordStream.add("请输入密码");
      _userPasswordAnimation.start();
      return false;
    } else {
      _userPasswordStream.add(null);
      return true;
    }
  }
  bool checkUserPasswordConform() {
    String userPasswordConform = _passwordConformController.text;
    if (userPasswordConform.length == 0) {
      _userPasswordConformStream.add("请再次输入密码");
      _userPasswordConformAnimation.start();
      return false;
    } else {
      _userPasswordConformStream.add(null);
      return true;
    }
  }

  bool checkLoginFunction() {
    hindKeyBoarder();

    if(checkUserName() == false){
      return false;
    }

    if(checkUserPassword() == false){
      return false;
    }
    if(checkUserPasswordConform() == false){
      return false;
    }
    if(_passwordController.text != _passwordConformController.text){
      _userPasswordConformStream.add("两次输入的密码不一致，请重试");
      return false;
    }
    loginFunction();
    return true;
  }
  void loginFunction() {}

}
