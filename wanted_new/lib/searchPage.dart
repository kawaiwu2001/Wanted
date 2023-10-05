
import 'package:flutter/material.dart';

import 'constants.dart';
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    controller.addListener(() {
      print('input ${controller.text}');
    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.1),
          child:AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
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
              title: Container(
                height: size.height*0.08,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(100)),
                //     color: Color.fromARGB(255, 243, 243, 243)),
                padding: EdgeInsets.fromLTRB(0,12,0,0),
                child: TextField(
                  controller: controller,
                  cursorColor: keyColor,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(25,0,0,0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0x00FF0000)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0x00000000)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      filled: true,
                      fillColor: Color.fromARGB(255, 243, 243, 243),
                      hintText: "搜索",
                      hintStyle: TextStyle(
                          color: textLightColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal),
                      suffixIcon: IconButton(
                        onPressed: () {  },
                        icon: ImageIcon(
                          AssetImage("assets/icons/search.png"),
                          color: keyColor,
                          // size: 30,
                        ),
                      )
                  ),
                ),
              )

          ),
        ),
        body: Column(
          children: [
            Divider(
              color: Color.fromARGB(246, 246, 246, 246),
              indent: 20,
              endIndent: 20,
              thickness: 3,
              height: 3,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20,20,0,0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "历史搜索",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: keyDarkColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){},
                        child: Container(
                          width: 60,
                          height: 30,
                          padding: const EdgeInsets.fromLTRB(
                              12.0, 5.0, 12.0, 5.0),
                          decoration: new BoxDecoration(
                            color: keyLightColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Text(
                            '电动车',
                            style: TextStyle(
                                fontSize: 12.0, color: keyDarkColor),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          width: 60,
                          height: 30,
                          padding: const EdgeInsets.fromLTRB(
                              17.0, 5.0, 14.0, 5.0),
                          decoration: new BoxDecoration(
                            color: keyLightColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(15.0)),
                          ),
                          child: Text(
                            '鼠标',
                            style: TextStyle(
                                fontSize: 12.0, color: keyDarkColor),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )
            ),
          ],
        )
    );
  }
}