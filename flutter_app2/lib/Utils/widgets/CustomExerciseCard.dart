import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomExerciseCard extends StatefulWidget{

  String id;
  String cathegory;
  String assetPath;
  String exerciseName;
  bool isFavorite = false;
  bool isAddGroceryOpen;
  String grams;
  String position;
  String sets;
  String reps;
  String link;


  CustomExerciseCard({
    this.id,
    this.cathegory,
    this.assetPath,
    this.exerciseName,
    this.isFavorite = false,
    this.sets,
    this.reps,
    this.link,
    this.position,
  });

  @override
  _customExerciseCardState createState() {
    return _customExerciseCardState();
  }
}

class _customExerciseCardState  extends State<CustomExerciseCard> {

  @override
  Widget build(BuildContext context) {
    return
      Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20.0) ,
            child: Card(
              color: Colors.white ,
              elevation: 5.0 ,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: MyTheme.themeColor , width: 2.0) ,
                borderRadius: BorderRadius.circular(20.0) ,
              ) ,
              child: Padding(
                padding: const EdgeInsets.all(3.0) ,
                child: Container(
                  height: 180.0 ,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9 ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: <Widget>[
                      Container(
                        //  color: Colors.black38,
                          height: 170 , width: 170 ,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image(image: AssetImage(widget.assetPath) ,),
                          )) ,
                      Column(mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                            children: <Widget>[
                              Container(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 5.5 , height: 43.0 ,) ,
                              Container(height: 25.0 ,
                                child: IconButton(
                                  icon: Icon(MdiIcons.heart , size: 30.0 ,
                                      color: widget.isFavorite
                                          ? Colors.red
                                          : Colors.grey[400]) ,
                                  onPressed: () {
                                    _setFavorite();
                                  } ,) ,
                              ) ,
                            ] ,
                          ) ,
                          Container(
                              color: Colors.white ,
                              height: 40.0 ,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.8 ,
                              child: Text(widget.exerciseName , style: TextStyle(
                                  fontSize: 15.0) , maxLines: null ,)) ,
                          Container(
                              color: Colors.white ,
                              height: 40.0 ,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width / 2.8 ,
                              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(AppLocalizations.of(context).translate("sets") + " " +
                                      widget.sets , style: TextStyle(
                                      fontSize: 15.0) , maxLines: null ,),
                                  Text(AppLocalizations.of(context).translate("reps") + " " +
                                      widget.reps , style: TextStyle(
                                      fontSize: 15.0) , maxLines: null ,),
                                ],
                              )) ,

                        ] ,
                      ) ,
                    ] ,
                  ) ,
                ) ,
              ) ,
            ) ,
          ) ,
          Row(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: <Widget>[
              Card(
                color: Colors.yellow[100] ,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: MyTheme.themeColor , width: 2.0) ,
                  borderRadius: BorderRadius.circular(20.0) ,) ,
                child: Padding(padding: const EdgeInsets.symmetric(
                    horizontal: 10.0) ,
                  child: Container(child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: <Widget>[
//                      Text(
//                          widget.cathegory ,
//                          textAlign: TextAlign.center ,
//                          style: TextStyle(
//                              fontSize: 17.0 , color: Colors.black54 ,
//                              fontWeight: FontWeight.w700)) ,
                      Padding(
                        padding: const EdgeInsets.all(7.0) ,
                        child: Text(
                            widget.position , textAlign: TextAlign.center ,
                            style: TextStyle(fontSize: 17.0 , color: Colors
                                .black54 ,
                                fontWeight: FontWeight.w700)) ,
                      ) ,
                    ] ,) ,
                  ) ,
                ) ,
              ) ,
            ] ,
          ) ,
        ] ,
      );
  }


  Future<void> _setFavorite() async {
    bool isFav;
    if (!widget.isFavorite) {
      isFav = true;
    }
    if (widget.isFavorite) {
      isFav = false;
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.id.toString() + "isfavexercise" , isFav);

    setState(() {
      widget.isFavorite = isFav;
    });
  }

}