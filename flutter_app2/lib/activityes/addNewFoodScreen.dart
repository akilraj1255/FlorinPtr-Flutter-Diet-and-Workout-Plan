import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_app/Utils/widgets/my_small_rised_button.dart';

class AddNewFoodScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _addFoodScreenState();
  }

}

class _addFoodScreenState extends State {

  bool isImageAdded = false;
  File  myImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(appBar: AppBar(title: Text("..."), centerTitle: true,),
    body: ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Text("..."),
          SizedBox(height: 10,),
          Container(
            width: MediaQuery.of(context).size.width/2,
          height: MediaQuery.of(context).size.width/2,
          child: Center(child: isImageAdded? Image.file(myImage): MySmallRaisedButton(
            mytext: "SelectImageText",
             myGradient: MyTheme.myLinearGradient,
             myIcon : Icon(Icons.add)),),),

        ],),
      )
    ],),);
  }

}