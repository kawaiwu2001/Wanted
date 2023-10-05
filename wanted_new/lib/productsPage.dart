import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanted_new/ProductCard.dart';
import 'package:wanted_new/constants.dart';
import 'package:wanted_new/searchPage.dart';
import 'package:http/http.dart' as http;



// var p = {
//   "product_imageUrl": 'assets/images/picture1.png',
//   'product_name': '笔记本',
//   'product_message': '这是一个笔记本这是一个笔记本这是一个笔记本这是一个笔记本这是一个笔记本',
//   'product_price': 200
// };
// var p1 = {
//   "product_imageUrl": 'assets/images/picture1.png',
//   'product_name': '笔记本',
//   'product_message': '这是一个笔记本这是一个笔记本这是一个笔记本这是一个笔记本这是一个笔记本',
//   'product_price': 20
// };

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late Future<dynamic> futureProduct;
  String _responseOneImage = "";
  List<String> imagesList = [];
  List<String> labelsList = [];
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

  Future<dynamic> getProductList() async{
    final uri = baseUri+"productList";
    //final uri = "http://10.0.2.2:8080/productList";
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
      List<Product> products = [];
      for(var p in jsonData){
        await getImages(p["imagesId"]);
        await getLabels(p["labelsId"]);
        await getUserName(p["userId"]);
        Product product = Product(
            p["name"],p["description"],
            p["location"],p["id"],p["price"],
            username,imagesList,labelsList);
        products.add(product);
        //print(product);
      }
      //print(products.length);
      return products;
    }else{
      print('product error');
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    futureProduct = getProductList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isshow = false;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.15),
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
          bottom: TabBar(
            indicatorPadding: EdgeInsets.fromLTRB(20, 0, 20, 10),
            indicatorWeight: 3,
            indicatorColor: keyColor,
            unselectedLabelColor: textLightColor,
            labelColor: keyColor,
            unselectedLabelStyle:
            TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
            labelStyle:
            TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
            tabs: [
              Tab(text: "学习用品"),
              Tab(text: "生活用品"),
              Tab(text: '其他用品'),
            ],
            controller: tabController,
          ),
        ),
      ),
      body: Stack(
        children: [
          TabBarView(
            children: [
              Center(
                  child: FutureBuilder<dynamic>(
                      future: futureProduct,
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
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                childAspectRatio: 167 / 237
                            ),
                            itemBuilder:(context,index){
                              return Stack(
                                children: [

                                  ProductCard(
                                    snapshot.data[index].id,
                                    snapshot.data[index].price,
                                    snapshot.data[index].description,
                                    snapshot.data[index].name,
                                    snapshot.data[index].username,
                                    snapshot.data[index].location,
                                    snapshot.data[index].imagesList,
                                    snapshot.data[index].labelsList,
                                  ),
                                ],
                              );
                            });
                      }
                  )),
              Center(child: Text('生活用品')),
              Center(child: Text('其他用品')),
            ],
            controller: tabController,
          ),
        ],
        //
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

class Product {
  final String name,description,location,username;
  //final List<String> labels;
  //final List<XFile> images;
  final List<String> imagesList,labelsList;
  final int id;
  final double price;


  Product(this.name, this.description, this.location, this.id, this.price, this.username, this.imagesList, this.labelsList);
}

