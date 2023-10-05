import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:wanted_new/widgets/PictureAdd.dart';
import 'package:wanted_new/widgets/roundedButtonShort.dart';
import 'package:wanted_new/widgets/tag.dart';
import 'package:wanted_new/widgets/tagAdd.dart';

import 'constants.dart';

class UploadProduct extends StatefulWidget {
  const UploadProduct({Key? key}) : super(key: key);

  @override
  _UploadProductState createState() => _UploadProductState();
}

class _UploadProductState extends State<UploadProduct> {
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  late FocusNode _textfieldfocus,_textformfieldfocus,_namefocus;
  List<String> _values = [];
  final ImagePicker _picker = ImagePicker();
  List<XFile> _imagelist = [];
  bool showTextField = false;
  String _responseString = "";
  _onDelete(index) {
    setState(() {
      _values.removeAt(index);
    });
  }

  void hindKeyBoarder() {
    //输入框List<XFile>失去焦点
    _textfieldfocus.unfocus();
    _textformfieldfocus.unfocus();
    _namefocus.unfocus();
    //隐藏键盘
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }
  
  Future<int> postProduct(List<XFile> images,String name,String description,String location,String price,List<String> labels) async {
    final uri = baseUri + "postProduct";
    var request = http.MultipartRequest('POST', Uri.parse(uri));
    for(int i = 0; i<images.length; i++){
      request.files.add(await http.MultipartFile.fromPath('images', images[i].path));
    }
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['location'] = location;
    request.fields['price'] = price;
    request.fields['labels'] = labels.toString();
    request.fields['userId'] = userIdFlutter;
    var res = await request.send();
    return res.statusCode;

  }

  @override
  void initState() {
    super.initState();
    _textformfieldfocus = FocusNode();
    _textfieldfocus = FocusNode();
    _namefocus = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _textfieldfocus.dispose();
    _textformfieldfocus.dispose();
    _namefocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GestureDetector(
        onTap: (){
          hindKeyBoarder();
        },
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        iconSize:36,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: ImageIcon(AssetImage('assets/icons/back.png'),color: backArrowColor,)
                    ),
                    SizedBox(
                      width: 230,
                    ),

                    RoundButtonShort(text: '发布',textColor: Colors.white,color: keyColor,
                      onClick: ()async{
                        final String description = _descriptionController.text;
                        final String location = _locationController.text;
                        final String price = _priceController.text;
                        final String name = _nameController.text;
                        int res = await postProduct(_imagelist,name,description,location,price,_values);
                        if(res == 200){
                            Fluttertoast.showToast(msg: '发布成功');
                            Navigator.pop(context);
                        }else{
                            Fluttertoast.showToast(msg: '发布失败');
                        }
                      },),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    controller: _nameController,
                    focusNode: _namefocus,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.transparent)
                      ),
                      hintText: "请输入商品名",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: textLightColor,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.transparent)
                      ),
                      enabledBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.transparent)
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: TextFormField(
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
                    controller: _descriptionController,
                    focusNode: _textformfieldfocus,
                    minLines: 5,
                    maxLines: 5,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.transparent)
                      ),
                      hintText: "请输入商品描述",
                      hintStyle: TextStyle(
                        fontSize: 18,
                        color: textLightColor,
                      ),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.transparent)
                      ),
                      enabledBorder:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.transparent)
                      ),
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Row(
                    children: [
                      ImageIcon(AssetImage('assets/icons/location.png'),color: keyColor,),
                      Expanded(
                        child: TextField(
                          textInputAction: TextInputAction.done,
                          controller: _locationController,
                          focusNode: _textfieldfocus,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.transparent)
                            ),
                            hintText: "请输入取货地点",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              color: textLightColor,
                            ),

                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.transparent)
                            ),
                            enabledBorder:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(color: Colors.transparent)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                  child: Text('图片',style: TextStyle(fontSize: 16,color: keyDarkColor),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,0, 0, 8),
                  child: SizedBox(
                    height: 270,
                    width: MediaQuery.of(context).size.width-10,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                      ),
                      physics: new NeverScrollableScrollPhysics(),
                      shrinkWrap: false,
                      children: List<Widget>.generate(_imagelist.length, (index) {
                        return Image.file(
                                      File(_imagelist[index].path),
                                      width: 112,
                                      height: 112,
                                      fit: BoxFit.cover,
                                    );
                            //your continued code
                          }) + [PictureAdd(onClick: (){
                                _onButtonPress();
                          }),],
                    ),

                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Text('标签',style: TextStyle(fontSize: 16,color: keyDarkColor),),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width-10,
                    child: ListView(
                      //physics: new NeverScrollableScrollPhysics(),
                      //scrollDirection: Axis.horizontal,
                      // children: List<Widget>.generate(_imagelist.length, (index) {
                      //   return Image.file(
                      //     File(_imagelist[index].path),
                      //     width: 112,
                      //     height: 112,
                      //     fit: BoxFit.cover,
                      //   );
                      //   //your continued code
                      // }) + [showTextField?phoneTextInput():TagAdd(
                      //   onClick: (){setState(() {
                      //     showTextField = true;
                      //   });},)],
                      children: [
                        TagEditor(
                          length: _values.length,
                          delimiters: [',', ' ','\u2386','\n'],
                          hasAddButton: false,
                          inputDecoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '请输入标签',
                          ),
                          onTagChanged: (newValue) {
                            if(_values.length<3){
                              setState(() {
                                _values.add(newValue);
                              });
                            }else{
                              Fluttertoast.showToast(msg: '只能有3个标签');
                            }
                          },
                          tagBuilder: (context, index) => _Chip(
                            index: index,
                            label: _values[index],
                            onDeleted: _onDelete,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))
                          ],
                        ),
                        const Divider(),
                      ],
                    ),
                  ),
                ),
                // Tag(color: keyLightColor, text:'一口价',textColor: keyDarkColor,),
                // SizedBox(width: 5,),
                // Tag(color: keyLightColor, text:'全新',textColor: keyDarkColor,),
                // SizedBox(width: 5,),
                // Tag(color: keyLightColor, text:'包邮',textColor: keyDarkColor,),
                // SizedBox(width: 5,),
                // showTextField?phoneTextInput():TagAdd(
                //   onClick: (){setState(() {
                //     showTextField = true;
                // });},),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                  child: Text('价格',style: TextStyle(fontSize: 16,color: keyDarkColor),),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(100, 0, 100, 0),
                        child: TextField(
                          controller: _priceController,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                            fontSize: 24,
                            color: keyColor,

                          ),
                          maxLength: 10,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            contentPadding: EdgeInsets.zero,

                            hintText: '0',
                            hintStyle: TextStyle(
                              fontSize: 24,
                              color: textLightColor,
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textLightColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: textLightColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text('元',style: TextStyle(color: textLightColor,fontSize: 14),)
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
  void imageSelectGallery() async{
    final XFile? selectedImage =
      await _picker.pickImage(source: ImageSource.gallery);
    // print(selectedImage!.path.toString());
    if(selectedImage!.path.isNotEmpty){
      _imagelist.add(selectedImage);

    }
    setState(() {

    });
  }

  void imageSelectCamera() async{
    final XFile? selectedImage =
    await _picker.pickImage(source: ImageSource.camera);
    // print(selectedImage!.path.toString());
    if(selectedImage!.path.isNotEmpty){
      _imagelist.add(selectedImage);

    }
    setState(() {

    });
  }


  void _onButtonPress(){
    showModalBottomSheet(context: context, builder: (context){
        return Container(
          color: Colors.white,
          height: 120,
          child: Container(
            child: _buildBottomNavigationMenu(),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
              )
            ),

          ),
        );
    });
  }

  Column _buildBottomNavigationMenu(){
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.camera_alt_outlined),
          title: Text('相机'),
          onTap: (){
            imageSelectCamera();
          },
        ),
        ListTile(
          leading: Icon(Icons.image_outlined),
          title: Text('图库'),
          onTap: (){
            imageSelectGallery();
          },
        ),
      ],
    );
  }

  // Widget phoneTextInput() {
  //   return TextField(
  //     controller: _textEditingController3,
  //     textAlign: TextAlign.center,
  //     decoration: InputDecoration(
  //       hintText: "Numero",
  //       border: InputBorder.none,
  //     ),
  //   );
  // }


  // Future pickImageGallery(File? _image) async{
  //   try{
  //     final image = await ImagePicker().pickImage(source: ImageSource.gallery);
  //     if(image == null) return;
  //
  //     final imageTemporary = File(image.path);
  //     setState(() => _image = imageTemporary);
  //   }on PlatformException catch(e){
  //     print('failed to pick image: $e');
  //   }
  // }
  //
  // Future pickImageCamera(File? _image) async{
  //   try{
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //     if(image == null) return;
  //
  //     final imageTemporary = File(image.path);
  //     setState(() => _image = imageTemporary);
  //   }on PlatformException catch(e){
  //     print('failed to pick image: $e');
  //   }
  // }

}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: keyLightColor,
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label,style: TextStyle(color: textLightColor),),
      deleteIcon: Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}