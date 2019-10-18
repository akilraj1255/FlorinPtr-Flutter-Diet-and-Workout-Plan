import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomFoodCard extends StatefulWidget{
  
  String cathegory;
  String assetPath;
  String foodName;
  bool isFavorite = false;
  bool isAddGroceryOpen;
  String grams;
  String position;
  
  CustomFoodCard({
    this.cathegory,
    this.assetPath,
    this.foodName,
    this.isFavorite = false,
    this.isAddGroceryOpen = false,
    this.grams,
    this.position,
  });

  @override
  _customFoodCardState createState() {
    return _customFoodCardState();
  }
}

class _customFoodCardState  extends State<CustomFoodCard>{
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          color: Colors.white,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.green, width: 2.0),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(
              height: 140.0,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(height: 130, width: 130,
                            child: Image(image: AssetImage(widget.assetPath),)),
                  ),
                  Column(
                    children: <Widget>[
                           Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                Card(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(color: Colors.green, width: 2.0),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(widget.position),
                                    )),
                                SizedBox(width: MediaQuery.of(context).size.width /4,),
                                IconButton(icon: Icon(MdiIcons.heartOutline, size: 30.0,
                                  color: widget.isFavorite? Colors.red : Colors.black54),
                                  onPressed: () {},)
                              ],),

                            Container(
                                color: Colors.white,
                                height: 35.0,
                                width: MediaQuery.of(context).size.width / 2.1,
                                  child: Text(widget.foodName, style: TextStyle(fontSize: 15.0), maxLines: null,)),

                              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                Text(widget.grams + "g  ", style: TextStyle(fontSize: 16.0,
                                    fontWeight: FontWeight.w500),),
                                Text(AppLocalizations.of(context).translate("detalii"),
                                style: TextStyle(fontSize: 16.0, color: Colors.blueAccent),),
                                SizedBox(width: 10.0,),
                                Container(
                                  child: widget.isAddGroceryOpen?
                                      IconButton(icon: Icon(Icons.add_circle, size: 40.0,),
                                      onPressed: (){},): Container())
                              ],),
                       ],
                      ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}