
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      home:ChatPage(),
    );
  }
}
class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController _textController = new TextEditingController();
  final _messages = <Message>[Message('你好，请问可以小刀吗？', false)];
  ///发送信息
  void _handleSubmitted(String text) {
    _textController.clear();//清空文本框
    Message message = new Message(
        text,true
    );

    setState((){
      _messages.add(message);
    });
  }

//构造输入框
  Widget _buildTextComposer(){
    return new Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 246, 246, 246),
        ),
        margin: const EdgeInsets.all(1),
        child: new Row(
            children: <Widget> [
              new Flexible(
                  child: Container(
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    margin: const EdgeInsets.only(left: 3),
                    padding: EdgeInsets.all(5),
                    child: new TextField(
                      controller: _textController,
                      onSubmitted: _handleSubmitted,
                      decoration: new InputDecoration.collapsed(hintText: '点击输入......'),
                    ),
                  )
              ),
              // new Container(
              //   child: new IconButton(
              //       splashRadius: 0.1,
              //       iconSize: 40,
              //       icon: new Icon(Icons.sentiment_satisfied_alt,color: Color.fromARGB(255, 30, 167, 85),),
              //       onPressed: (){}
              //   ),
              // ),
              new Container(
                child: new IconButton(
                    splashRadius: 0.1,
                    iconSize: 40,
                    icon: new Icon(Icons.control_point,color: Color.fromARGB(255, 30, 167, 85),),
                    onPressed: (){
                      //發圖片
                    }
                ),
              ),
            ]
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    Chatter chatter = Chatter('张文', 'https://i.bmp.ovh/imgs/2022/04/10/b2a5adb6df81fbc2.png');
    Widget divider = Divider(color: Colors.white, height: 18.0, indent: 18,);
    Size size = MediaQuery.of(context).size;
    return new Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 246, 246),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.08),
        child: AppBar(
          elevation: 0.8,
          backgroundColor: Color.fromARGB(255, 246, 246, 246),
          title: new Text(chatter.userName,
            style: TextStyle(
                color: Color.fromARGB(255, 112, 112, 112),
                fontSize: 24.0,
                fontWeight: FontWeight.normal),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.grey,
                size: 30,
              )
          ),
        ),
      ),
      body: new Column(
        children: <Widget>[
          new Flexible(
            child:new ListView.separated(
              separatorBuilder: (BuildContext context, int index) {
                return divider;
              },
              padding: new EdgeInsets.all(8.0),
              itemBuilder: (context, int index) => EntryItem(_messages[index],chatter),
              itemCount: _messages.length,
            ),
          ),
          new Divider(height: 1.0),
          new Container(
            decoration: new BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: _buildTextComposer(),
          )
        ],
      ),
    );
  }
}


///发送的信息类
class Message {
  String text;//内容
  bool isSender;//是否由自己发送
  Message(this.text, this.isSender,);
}

///构造发送的信息
class EntryItem extends StatelessWidget{
  final Chatter chatter;
  final Message message;
  const EntryItem(this.message,this.chatter);

  Widget row(){
    ///由自己发送，在右边显示
    if(message.isSender){
      return new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(Icons.check_circle,color: Colors.grey,size: 15,),
          Text('未读',
            style:TextStyle(
                color: Colors.grey,
                fontSize: 10
            ),),
          Flexible(
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    height:48,
                    decoration: new BoxDecoration(
                      color: Color.fromARGB(255, 222, 243, 229),
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    ),
                    margin: const EdgeInsets.all(5.0),
                    padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                    child: new Text(message.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ]
            ),
          ),
          new Container(
            margin: const EdgeInsets.only(left: 12.0,right: 12.0),
            child: new CircleAvatar(
              backgroundImage: NetworkImage(chatter.imageUrl),
              radius: 24.0,
            ) ,
          ),
        ],
      );
    }
    else{
      ///对方发送，左边显示
      return new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: const EdgeInsets.all(5.0),
            child: new CircleAvatar(
              backgroundImage: NetworkImage(chatter.imageUrl),
              radius: 24.0,
            ) ,
          ),
          Flexible(
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    height:48,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18.0)),
                    ),
                    margin: const EdgeInsets.all(5.0),
                    padding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                    child: new Text(message.text,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16
                      ),
                    ),
                  ),
                ]
            ),
          ),
          Icon(Icons.check_circle,color: Color.fromARGB(255, 30, 167, 85),size: 15,),
          Text('已读',
            style:TextStyle(
                color: Color.fromARGB(255, 30, 167, 85),
                fontSize: 10
            ),)
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: row(),
    );
  }
}

class Chatter {
  String imageUrl,userName;
  Chatter(this.userName,this.imageUrl);
}
