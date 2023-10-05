import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wanted_new/productsPage.dart';
import 'package:wanted_new/searchPage.dart';

import 'constants.dart';

class ShoppingPage extends StatefulWidget {
  const ShoppingPage({Key? key}) : super(key: key);

  @override
  _ShoppingPageState createState() => _ShoppingPageState();
}

class _ShoppingPageState extends State<ShoppingPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(size.height * 0.02, size.height * 0.02, size.height * 0.02, 0),
      child: ProductsPage(),
    );
  }
}


//拆分搜索栏与tab的写法（已废弃）
// child: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Expanded(
//         flex: 1,
//         child:InkWell(
//           onTap: (){
//             Navigator.push(
//                 context,MaterialPageRoute(
//                 builder: (context){
//               return SearchPage();
//             }));
//           },
//           child:  Container(
//             width: double.infinity,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(28)),
//                 color: Color.fromARGB(255, 243, 243, 243)),
//             padding: EdgeInsets.fromLTRB(20,10,20,10),
//             child: Stack(
//               children: [
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "搜索",
//                     style: TextStyle(
//                         color: textLightColor,
//                         fontSize: 20.0,
//                         fontWeight: FontWeight.normal),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Icon(
//                     Icons.search,
//                     color: keyColor,
//                     size: 30,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         )
//     ),
//     Expanded(flex: 10, child: ProductsPage())
//   ],
// ),
