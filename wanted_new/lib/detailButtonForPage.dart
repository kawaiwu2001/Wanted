

import 'package:flutter/material.dart';
import 'package:wanted_new/constants.dart';

class Follow extends StatelessWidget{

  const Follow({
    Key? key,
    required this.firsttap,
    required this.secondtap,
    required this.firsticon,
    required this.secondicon,
    required this.onClick1,
    required this.onClick2,
  }) : super(key: key);

  final Function() onClick1,onClick2;
  final String firsttap;
  final String secondtap;
  final String firsticon;
  final String secondicon;

  get offset => null;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      child: Container(
        width: 354,
        height: 63,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            border:  Border.all(color: Colors.grey,width: 1),
            boxShadow:[
              BoxShadow(
                  color: Colors.black,
                  offset: Offset(15.0, 15.0), //阴影xy轴偏移量
                  blurRadius: 50.0, //阴影模糊程度
                  spreadRadius: 50.0 //阴影扩散程度
              )
            ]),
        child:
        Row(
          children:
          [
            const SizedBox(width: 20,height: 20,),
            TextButton(onPressed: onClick1, child: Row(
              children: [
                Image(image: AssetImage(firsticon),width: 30,),
               const SizedBox(width: 10,height: 20,),
                Text(firsttap,
                  style: const TextStyle(
                      color: keyDarkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      decoration: TextDecoration.none//去掉下划线
                  ),),

              ],
            )),

            const SizedBox(width: 20,height: 20,),

            const VerticalDivider(
              color: Colors.grey,
              width: 0.5,
              thickness: 1,
              indent: 15,
              endIndent: 15,
            ),

            const SizedBox(width: 20,height: 20,),

            TextButton(onPressed:onClick2, child: Row(
              children: [
                Image(image: AssetImage(secondicon),width: 30,),
                const SizedBox(width: 10,height: 20,),
                Text(secondtap,
                  style:TextStyle(
                      color: keyDarkColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      decoration: TextDecoration.none//去掉下划线
                  ),)
              ],
            )),
          ],
        ),
      ),
    );
    // TODO: implement build
  }

}

class PageButton extends StatelessWidget{
  const PageButton({
    Key? key,
    required this.logo,
    required this.num,
    required this.inform, required this.onClick,
  }) : super(key: key);
  final Function() onClick;
  final String logo;
  final String num;
  final String inform;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
      child: Container(
        width: 154,
        height: 168,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.grey),
            boxShadow: const [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(15.0, 15.0), //阴影xy轴偏移量
                  blurRadius: 50.0, //阴影模糊程度
                  spreadRadius: 50.0 //阴影扩散程度
              )
            ]
        ),
        child: Column(
          children: [
            //const SizedBox(width: 20,height: 10,),
            Row(
              children: [
                const SizedBox(width: 5,height: 20,),
                Image(image: AssetImage(logo,
                ),width: 60,color: Colors.green,),
                const SizedBox(width: 35,height: 20,),
                // MaterialButton(onPressed: (){},
                //   //minWidth: 15,
                //   child:Image(image: AssetImage('assets/icons/arrow.png',
                //   ),width: 5,),),
                IconButton(onPressed: onClick, icon: ImageIcon(
                    AssetImage('assets/icons/arrow.png'),
                  color: Color.fromARGB(255, 151, 151, 151),
                  //size: 10,
                ))
              ],
            ),
            Text(num,style: const TextStyle(
                color: Color.fromRGBO(103, 126, 91, 100),
                fontSize: 50,
                decoration: TextDecoration.none//去掉下划线
            ),
            ),

            Text(inform,style: const TextStyle(
                color: Color.fromRGBO(103, 126, 91, 100),
                fontWeight: FontWeight.w100,
                fontSize: 16,
                decoration: TextDecoration.none//去掉下划线
            ),
            )
          ],
        ),
      ),
    );
    // TODO: implement build
  }

}