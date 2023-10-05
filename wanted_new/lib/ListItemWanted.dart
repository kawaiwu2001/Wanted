import 'package:flutter/material.dart';
import 'package:wanted_new/constants.dart';

class ListItemWanted extends StatefulWidget{
   ListItemWanted({Key? key}) : super(key: key);

  @override
  _ListItemState createState() => _ListItemState();
}

class _ListItemState extends State<ListItemWanted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children:[
            Column(
              children: [
                SizedBox(width: 20,height: 50,),
                ItemView("拿快递","急","1","assets/images/picture4.png"),
                SizedBox(width: 20,height: 50,),
                ItemView("拿快递","急","1","assets/images/picture4.png"),
                SizedBox(width: 20,height: 50,),
                ItemView("拿快递","急","1","assets/images/picture4.png"),

              ]

            ),

            ]
        ),
      ),
    );
    // TODO: implement build
  }
}

class ItemView extends StatefulWidget{
  String text,label,price,picture;

  ItemView(this.text,this.label,this.price,this.picture,{Key? key}) : super(key: key);

  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(25.0)),
      child: Center(
        child:Container(
          width: 354,
          height: 136,
          decoration: BoxDecoration(
            color: Color.fromRGBO(233, 246, 237, 100),
            borderRadius: BorderRadius.circular(25.0),
            border: Border.all(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.grey),

        ),
          child: Row(
          children: [
            ClipRRect(
              child: Image.asset(
                this.widget.picture,
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.all(
               Radius.circular(5),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:EdgeInsets.all(4.0),
                  child: Text(this.widget.text,style: TextStyle(fontSize: 18,color:keyDarkColor)),
                ),
                Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Container(
                        child: Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(this.widget.label,style: TextStyle(fontSize: 12,color: keyDarkColor),textAlign: TextAlign.center,),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color:keyColor),
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.white
                      )
                    )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding:  EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Text(this.widget.price,style: TextStyle(fontSize: 25,color: keyColor,fontWeight: FontWeight.bold)),
                      SizedBox(width: 120),

                      IconButton(onPressed: (){},
                          icon: ImageIcon(AssetImage('assets/icons/massage.png'),size: 25,color: keyColor,)),
                      IconButton(onPressed: (){},
                          icon:  ImageIcon(AssetImage('assets/icons/link-to.png'),size: 25,color: keyColor,))
                    ],
                  ),
                )

              ],
            )
           ]
        ),
      ),
      ),
    );
    // TODO: implement build
  }
}