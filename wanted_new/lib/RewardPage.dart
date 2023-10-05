import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:wanted_new/WantedCard.dart';
import 'package:wanted_new/searchPage.dart';
import 'constants.dart';
import 'package:http/http.dart' as http;
class SortCondition {
  String name;
  bool isSelected;

  SortCondition({
    required this.name,
    required this.isSelected,
  });
}

// var p = {
//   "imageUrl": 'assets/images/picture1.png',
//   'name': '笔记本',
//   'massage': '这是一个笔记本这是一个笔记本这是一个笔记本这是一个笔记本这是一个笔记本',
//   'price': 200
// };

class RewardPage extends StatefulWidget {
  const RewardPage({Key? key}) : super(key: key);

  @override
  _RewardPageState createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  List<String> _dropDownHeaderItemStrings = ['综合排序'];
  List<SortCondition> _brandSortConditions = [];
  late SortCondition _selectBrandSortCondition;
  GZXDropdownMenuController _dropdownMenuController = GZXDropdownMenuController();
  String _responseOneImage = "";
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  GlobalKey _stackKey = GlobalKey();

  String _dropdownMenuChange = '';
  late Future<dynamic> futureReward;
  List<String> imagesList = [];
  List<String> labelsList = [];
  String username = "";


  Future<dynamic> getUserName(int userId) async{
    final uri = baseUri+"getUserName";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    //print(userId);
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


  Future<dynamic> getLabels(int labelsId) async{
    final uri = baseUri+"labelsList";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['labelsId'] = labelsId.toString();
    var streamedResponse = await request.send();
    if(streamedResponse.statusCode == HttpStatus.ok){
      var response = await http.Response.fromStream(streamedResponse);
      var jsonData = json.decode(response.body);
      //print(jsonData);
      setState(() {
        if(labelsList.isNotEmpty){
          labelsList = [];
        }
        if(jsonData["label1"]!=null && jsonData["label1"]!=""){
          labelsList.add(jsonData["label1"]);
        }
        if(jsonData["label2"]!=null && jsonData["label2"]!=""){
          labelsList.add(jsonData["label2"]);
        }
        if(jsonData["label3"]!=null && jsonData["label3"]!=""){
          labelsList.add(jsonData["label3"]);
        }
      });
    }else{
      print('error');
    }
  }

  Future<dynamic> getImages(int imagesId) async{
    final uri = baseUri+"images";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['imagesId'] = imagesId.toString();
    var streamedResponse = await request.send();
    if(streamedResponse.statusCode == HttpStatus.ok){
      var response = await http.Response.fromStream(streamedResponse);
      var jsonData = json.decode(response.body);
      //print(jsonData);
      setState(() {
        // print(jsonData[1]);
        if(imagesList.isNotEmpty){
          imagesList = [];
        }
        if(jsonData["image1"] != null){
          imagesList.add(jsonData["image1"]);
        }
        if(jsonData["image2"] != null){
          imagesList.add(jsonData["image2"]);
        }
        if(jsonData["image3"] != null){
          imagesList.add(jsonData["image3"]);
        }
        if(jsonData["image4"] != null){
          imagesList.add(jsonData["image4"]);
        }
        if(jsonData["image5"] != null){
          imagesList.add(jsonData["image5"]);
        }
        if(jsonData["image6"] != null){
          imagesList.add(jsonData["image6"]);
        }
      });

    }else{
      print('error');
    }
  }

  Future<dynamic> getOneImage(int imagesId) async{
    final uri = baseUri+"oneImage";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    request.fields['imagesId'] = imagesId.toString();
    var streamedResponse = await request.send();
    if(streamedResponse.statusCode == HttpStatus.ok){
      var response = await http.Response.fromStream(streamedResponse);
      setState(() {
        _responseOneImage = response.body;
      });
    }else{
      print('error');
    }
  }

  Future<dynamic> getRewardList() async{
    final uri = baseUri+"rewardList";
    var response = await http.get(
      Uri.parse(uri),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var jsonData = json.decode(response.body);
    // Map<String, dynamic> jsonData = json.decode(response.body);
    //Map<String, dynamic> myMap = new Map<String, dynamic>.from(response.headers);

    //var jsonData = myMap;
    //print(jsonData);
    if(response.statusCode == HttpStatus.ok){
      // print(response.statusCode);
      List<Reward> rewards = [];
      for(var r in jsonData){
        await getImages(r["imagesId"]);
        await getLabels(r["labelsId"]);
        await getUserName(r["userId"]);
        //await getOneImage(r["imagesId"]);
        Reward reward = Reward(r["id"],r["name"],r["description"], r["location"],r["price"],username,imagesList,labelsList);
        rewards.add(reward);
        // print(product);
      }
      //改Reward
      //print(products.length);
      return rewards;
    }else{
      print('reward error');
    }
    return null;
  }

  // Future<dynamic> getRewardList() async{
  //   final uri = "http://175.178.42.8:8080/wanted-0.0.1-SNAPSHOT/" +"rewardList";
  //   //final uri = "http://10.0.2.2:8080/rewardList";
  //   var response = await http.get(
  //     Uri.parse(uri),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //   );
  //   var jsonData = jsonDecode(response.body);
  //   //print(jsonData);
  //   if(response.statusCode == HttpStatus.ok){
  //     // print(response.statusCode);
  //     List<Reward> rewards = [];
  //     for(var r in jsonData){
  //       //Reward reward = Reward(r["reward_id"],r["reward_imageUrl"], r["reward_name"], r["reward_message"], r["reward_price"]);
  //       //rewards.add(reward);
  //     }
  //     //(rewards.length);
  //     //return rewards;
  //   }else{
  //     print('reward error');
  //   }
  //   return null;
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureReward = getRewardList();
    _brandSortConditions.add(SortCondition(name: '默认排序', isSelected: true));
    _brandSortConditions.add(SortCondition(name: '价格升序', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '价格降序', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '热度', isSelected: false));
    _brandSortConditions.add(SortCondition(name: '时间', isSelected: false));
    _selectBrandSortCondition = _brandSortConditions[0];
  }
  GestureDetector gestureDetector(items, int index, void itemOnTap(SortCondition sortCondition), BuildContext context) {
    SortCondition goodsSortCondition = items[index];
    return GestureDetector(
      onTap: () {
        for (var value in items) {
          value.isSelected = false;
        }
        goodsSortCondition.isSelected = true;

        itemOnTap(goodsSortCondition);
      },
      child: Container(
        //            color: Colors.blue,
        height: 40,
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Text(
                goodsSortCondition.name,
                style: TextStyle(
                  color: goodsSortCondition.isSelected ? Theme.of(context).primaryColor : Colors.black,
                ),
              ),
            ),
            goodsSortCondition.isSelected
                ? Icon(
              Icons.check,
              color: Theme.of(context).primaryColor,
              size: 16,
            )
                : SizedBox(),
            SizedBox(
              width: 16,
            ),
          ],
        ),
      ),
    );
  }
  _buildConditionListWidget(items, void itemOnTap(SortCondition sortCondition)) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      // item 的个数
      separatorBuilder: (BuildContext context, int index) => Divider(height: 1.0),
      // 添加分割线
      itemBuilder: (BuildContext context, int index) {
        return gestureDetector(items, index, itemOnTap, context);
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(size.height * 0.02, size.height * 0.02, size.height * 0.02, 0),
        child: Scaffold(
            key: _scaffoldKey,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.08),
              child: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                elevation: 0,
                title: InkWell(
                  splashColor: Colors.white,
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return SearchPage();
                    }));
                  },
                  child: Container(
                    //color: Colors.black54,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(28)),
                        color: Color.fromARGB(255, 243, 243, 243)),
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "搜索",
                            style: TextStyle(
                                color: textLightColor,
                                fontSize: 20.0,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ImageIcon(
                            AssetImage("assets/icons/search.png"),
                            color: keyColor,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                //放下拉菜单的地方，不会写.jpg
                Container(
                  padding: EdgeInsets.fromLTRB(size.height * 0.02, 0, size.height * 0.02, 0),
                  height: size.height*0.03,
                ),
                Container(
                  height: size.height*0.75,
                  child: FutureBuilder<dynamic>(
                    future: futureReward,
                    builder: (context,snapshot){
                      if(snapshot.data == null){
                        return Container(
                          child: Center(
                              child:CircularProgressIndicator(
                                color: keyColor,
                              )
                          ),
                        );
                      }else return GridView.builder(
                        itemCount: snapshot.data.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 15,
                                crossAxisCount: 1,
                                crossAxisSpacing: 15,
                                childAspectRatio: 204 / 119
                            ),
                          itemBuilder: (context,index){
                            return Stack(
                              children: [
                                WantedCard(
                                  snapshot.data[index].id,
                                  snapshot.data[index].name,
                                  snapshot.data[index].description,
                                  snapshot.data[index].location,
                                  snapshot.data[index].price,
                                  snapshot.data[index].username,
                                  snapshot.data[index].imagesList,
                                  snapshot.data[index].labelsList,
                                )
                                //WantedCard(p),
                              ],
                            );
                          });
                    },
                  ),
                )
              ],
            )
        )
    );
  }
}


class Reward {
  final String name,description,location,username;
  //final List<String> labels;
  //final List<XFile> images;
  final List<String> imagesList,labelsList;
  final int id;
  final double price;

  Reward( this.id,this.name, this.description, this.location, this.price, this.username, this.imagesList, this.labelsList,);

}

