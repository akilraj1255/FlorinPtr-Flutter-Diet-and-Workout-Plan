
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter_app/Utils/static_values.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomFoodCard extends StatefulWidget{

  int id;
  String cathegory;
  String assetPath;
  String foodName;
  bool isFavorite = false;
  String grams;
  String position;
  void updateParent;


      CustomFoodCard({
    this.id,
    this.cathegory,
    this.assetPath,
    this.foodName,
    this.isFavorite = false,
    this.grams,
    this.position,
    this.updateParent,
  });

  @override
  _customFoodCardState createState() {
    return _customFoodCardState();
  }
}

class _customFoodCardState  extends State<CustomFoodCard>{
  
  @override
  Widget build(BuildContext context) {
    return
    Stack(
    children: <Widget>[
    Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Card(
            color: Colors.white,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: MyTheme.themeColor, width: 2.0),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                height: 170.0,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(height: 140, width: 140,
                              child: Image(image: AssetImage(widget.assetPath),)),
                    Column(
                      children: <Widget>[
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3, height: 40.0,),
                              Container( height: 42.0,
                                child: IconButton(icon: Icon(MdiIcons.heart, size: 30.0,
                                    color: widget.isFavorite? Colors.red : Colors.grey[400]),
                                  onPressed: () {_setFavorite();},),
                              ),
                            ],
                          ),
                              Container(
                                    color: Colors.white,
                                    height: 35.0,
                                    width: MediaQuery.of(context).size.width / 2.2,
                                      child: Text(widget.foodName, style: TextStyle(fontSize: 15.0), maxLines: null,)),

                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                  Text(widget.grams + "g  ", style: TextStyle(fontSize: 16.0,
                                      fontWeight: FontWeight.w500),),
                                  Text(AppLocalizations.of(context).translate("detalii"),
                                  style: TextStyle(fontSize: 16.0, color: Colors.blueAccent),),
                                  SizedBox(width: 10.0,),
                                  Container(
                                    child: StaticValues.isAddGroceryOpen?
                                        IconButton(icon: Icon(Icons.add_circle,
                                          color: MyTheme.themeColor, size: 40.0,),
                                        onPressed: (){},):
                                    IconButton(icon: Icon(Icons.check,
                                      color: isFoodConsumed(widget.id)?
                                      Colors.green: Colors.black38, size: 40.0,),
                                      onPressed: (){UpdateConsumed(widget.id);},))
                                ],),
                         ],
                        ),
                  ],
                ),
              ),
            ),
      ),
    ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            color: Colors.yellow[100],
            shape: RoundedRectangleBorder(
              side: BorderSide(color: MyTheme.themeColor, width: 2.0),
              borderRadius: BorderRadius.circular(20.0),),
            child: Padding(padding: const EdgeInsets.symmetric( horizontal :10.0),
              child: Container(child:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                        widget.cathegory,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17.0, color: Colors.black54,
                            fontWeight: FontWeight.w700)),
                    Padding(
                      padding: const EdgeInsets.all(7.0),
                      child: Text(widget.position, textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17.0, color: Colors.black54,
                              fontWeight: FontWeight.w700)),
                    ),
                  ],),
              ),
            ),
          ),
        ],
      ),
    ],
    );
  }

  Future<void> _setFavorite() async {
    bool isFav;
    if(!widget.isFavorite){isFav = true;}
    if(widget.isFavorite){isFav = false;}
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.id.toString() + "isfav", isFav);

    setState(() {
      widget.isFavorite = isFav;
    });
  }
  bool isFoodConsumed(int id){

      if (StaticValues.consumedFoodsToday.contains(id)) {
        return true;
      }
    else{return false;}
  }

  void UpdateConsumed(int id) {

    if(StaticValues.consumedFoodsToday.contains(id)) {
      StaticValues.consumedFoodsToday.remove(id);
    }else {
      List <int> ints = new List();
      String current = id.toString().substring(0,1);
      for (int x in StaticValues.consumedFoodsToday){
        String currentIntCat = x.toString().substring(0,1);
        if(current == currentIntCat){
          ints.add(x);
        }
      }
      for (int y in ints) {
        StaticValues.consumedFoodsToday.remove(y);
      }
       StaticValues.consumedFoodsToday.add(id);
    }
    widget.updateParent;
  }
}