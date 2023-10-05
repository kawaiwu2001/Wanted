import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shake_animation_widget/shake_animation_widget.dart';
import 'package:wanted_new/background.dart';
import 'package:wanted_new/constants.dart';
import 'package:wanted_new/rounded_button.dart';
import 'package:wanted_new/home_page.dart';
import 'package:wanted_new/rounded_input_field.dart';
import 'package:wanted_new/rounded_input_field_password.dart';
import 'package:wanted_new/signInPage.dart';
import 'package:wanted_new/text_field_container.dart';
import 'package:wanted_new/widgets/toast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _usernameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  //Stream 更新操作控制器
  StreamController _userNameStream = new StreamController();
  //StreamController _userNameStream = StreamController();
  StreamController _userPasswordStream = new StreamController();

  //抖动动画控制器
  ShakeAnimationController _userNameAnimation = new ShakeAnimationController();
  ShakeAnimationController _userPasswordAnimation = new ShakeAnimationController();
  String _responseString = "";
  String catchError="";

  void hindKeyBoarder() {
    //输入框失去焦点
    _usernameFocusNode.unfocus();
    _passwordFocusNode.unfocus();

    //隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }


  Future<void> postData(String username,String password) async{
    final uri = baseUri + "vertification";
    //final uri = "http://10.0.2.2:8080/vertification";
   // print('username: $username');
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

        //print('_responseString:$_responseString');

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
      //print('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    FToast fToast;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          hindKeyBoarder();
        },
        child: Background(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsetsDirectional.fromSTEB(30.0, 0.0, 30.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //SizedBox(height: size.height * 0.01),

                  Container(
                      height: 150.0,
                      width: 150.0,
                      child: Image.asset("assets/images/user.png")
                  ),
                  SizedBox(height: size.height * 0.05),
                  // RoundedInputField(
                  //   controller: _usernameController,
                  //   hintText: "帐号",
                  //   onChanged: (value) {},
                  // ),
                  TextFieldContainer(child:buildUserNameWidget()),
                  // buildUserNameWidget(),
                  SizedBox(height: size.height * 0.03),
                  // RoundedInputFieldPassword(
                  //   controller: _passwordController,
                  //   hintText: "密码",
                  //   onChanged: (value) {},
                  // ),
                  TextFieldContainer(child: buildUserPasswordWidget()),
                  //buildUserPasswordWidget(),
                  Align(
                    widthFactor: 3.7,
                    heightFactor: 2,
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed:(){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context){
                                    return SignInPage();
                                  }));
                        }, child:Text(
                      "注册帐号",
                      style: TextStyle(
                          color: Color.fromARGB(255, 95, 142, 113),
                          fontWeight: FontWeight.w300,
                          fontSize: 18
                      ),
                      //textAlign: TextAlign.end,
                    )

                    ),
                  ),
                  SizedBox(height: size.height * 0.04),
                  RoundedButton(
                    text: "登录",
                    press: () async {
                      // Navigator.push(
                      //     context,MaterialPageRoute(
                      //     builder: (context){
                      //       return HomePage();
                      //     }));
                      final String username = _usernameController.text;
                      final String password = _passwordController.text;
                      if(checkLoginFunction()){
                        await postData(username,password);
                        userIdFlutter = _responseString;
                        if(int.parse(_responseString) >0){
                          showToast('登入成功');
                          Navigator.push(
                              context,MaterialPageRoute(
                              builder: (context){
                                return HomePage();
                              }));
                        }else if(int.parse(_responseString) == -1){
                          showToast('密码不正确，请重试');
                        }else if(int.parse(_responseString) == -2){
                          showToast('此用户名尚未注册');
                        }else {
                          showToast('$_responseString');
                          showToast('$catchError');
                        }
                      }
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
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
                loginFunction();
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
  bool checkLoginFunction() {
    hindKeyBoarder();

    if(checkUserName() == false){
      return false;
    }

    if(checkUserPassword() == false){
      return false;
    }

    loginFunction();
    return true;
  }
  void loginFunction() {}

}
