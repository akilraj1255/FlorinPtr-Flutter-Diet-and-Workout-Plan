import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_app/Utils/Mancare.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter_app/Utils/converter_class.dart';
import 'package:flutter_app/Utils/static_values.dart';
import 'package:flutter_app/Utils/widgets/my_small_rised_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:screenshot/screenshot.dart';

class FoodDetailsScreen extends StatelessWidget{

  Mancare food;

  Map<String, double> dataMap = new Map();
  List<Color> colorList = [
    Colors.red[300],
    Colors.orange[200],
    Colors.green[300],
    Colors.yellow[100],
  ];

  ScreenshotController screenshotController = new ScreenshotController();

  FoodDetailsScreen(Mancare food){this.food = food;}


  @override
  Widget build(BuildContext context) {

    dataMap.putIfAbsent(AppLocalizations.of(context).translate("proteine_"),
            () => food.getProteina()*_calculateMeals(food)/100);
    dataMap.putIfAbsent(AppLocalizations.of(context).translate("carbo_"),
            () => food.getCarbo()*_calculateMeals(food)/100);
    dataMap.putIfAbsent(AppLocalizations.of(context).translate("fibre_"),
            () => food.getFibers()*_calculateMeals(food)/100);
    dataMap.putIfAbsent(AppLocalizations.of(context).translate("fats_"),
            () => food.getGrasimi()*_calculateMeals(food)/100);

    return Scaffold(
      appBar: AppBar(title: Text(food.getNume(), maxLines: null,),centerTitle: true,),
      body: ListView(
        children: <Widget>[
          Screenshot( controller: screenshotController,
            child: Container( color: Colors.white,
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(width: MediaQuery.of(context).size.width,
                        height: 150.0,
                        color: MyTheme.customBackgrounColor,),
                      Center(
                        child: Container(width: MediaQuery.of(context).size.width * 0.7,
                          height: 200.0,
                        child: Image(image: AssetImage(food.getPoza()),),),
                      )
                    ],
                  ),

              Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      Text(food.getDescriere(), maxLines: null,textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 16.0),),
                     SizedBox(height: 10.0,),

                     Padding(
                       padding: const EdgeInsets.all(5.0),
                       child:food.getCantitati().length > 1 ?
                       Column(crossAxisAlignment: CrossAxisAlignment.start,
                         children: <Widget>[
                        //   SizedBox(height: 10,),
                             Text(AppLocalizations.of(context).translate("cantitati_mancare"),
                             style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600,)),
                           SizedBox(height: 5,),
                     Text(_getQuantitiesText(context).substring(0, _getQuantitiesText(context).length-1),
                       maxLines: null,
                      style: TextStyle(color: Colors.black87, fontSize: 16.0),),
                          SizedBox(height: 5,),
                          Text("Total: " + _calculateMeals(food).toString() + "g" + " - " +
                  (food.getCalorii() *_calculateMeals(food)/100).round().toString() + " kcal",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                          Text("   " + AppLocalizations.of(context).translate("values_before_cooking"),
                          style: TextStyle(fontSize: 14, color: Colors.grey[500]),),
                          SizedBox(height: 15,),
                          Text(AppLocalizations.of(context).translate("the_graphic_below_represent_macronutrients_percentage"),
                          textAlign: TextAlign.center, style: TextStyle(),),
                          PieChart(dataMap: dataMap, colorList: colorList,)

                         ],
                       ) : Column(crossAxisAlignment: CrossAxisAlignment.center,
                           children: <Widget>[Text(" "),
                             Text(AppLocalizations.of(context).translate("the_graphic_below_represent_macronutrients_percentage"),
                               textAlign: TextAlign.center, style: TextStyle(),),
                             PieChart(dataMap: dataMap, colorList: colorList,)
                           ])
                     ),
                          SizedBox(height: 10,),
                  ]),
                  ),

        ],
      ),
            ),
          ),
          Center(
            child: Container(
                width: 130,
                child:MySmallRaisedButton(
                  myOnPressed: () {
                    _shareLayout();
                  },
                  mytext: AppLocalizations.of(context).translate("share_"),
                  myGradient: MyTheme.myVerticalGradient,
                  myIcon: Icon(MdiIcons.share, color: Colors.black,),
                )
            ),
          ),
          SizedBox(height: 35,)
        ],
      ),
    );
  }
  _shareLayout() {
    screenshotController.capture().then((File image) async {
      //Capture Done
      // todo beforae use for ios share check docs esys_flutter_share

      Uint8List byte = await image.readAsBytes();
      Share.file('Tips', ' ', byte, 'image/png');
    }).catchError((onError) {
      print(onError);
    });
  }

  String _getQuantitiesText(BuildContext context) {
    String outpuCantitati = "";

    if (food.getCantitati().length>1) {
      String _rawText = food.getCantitati();
      List<String> ingredients = new List();
      List<int> values = new List();
      int lastEqualIndex = 0;
      int lastComaIndex = 0;
      do {
        String x =_rawText.substring(lastEqualIndex,_rawText.length);
        int indexOfEqual = x.indexOf("=") + lastEqualIndex;
        String y = _rawText.substring(lastComaIndex, _rawText.length);
        int indexOfComa = y.indexOf(",") + lastComaIndex;
        String currentIngred = _rawText.substring(lastComaIndex , indexOfEqual);
        String currentValue = _rawText.substring(
            indexOfEqual + 1 , _rawText.indexOf("," , indexOfEqual));
        lastEqualIndex = indexOfEqual + 1;
        lastComaIndex = indexOfComa + 1;
        int result = ((int.parse(currentValue)*_calculateMeals(food))/100).round();
        outpuCantitati += currentIngred + " - " +
            ConverterClass.Convert(context, currentIngred, result) + "\n";
      //  String example = "Yogurt 2.5 percent fat=60,Oatmeal=20,Seeds=10,Fruits at your choice=10,";
      }
      while(lastEqualIndex < _rawText.length - 5);
    }


    return outpuCantitati;
  }

  int _calculateMeals(Mancare food) {
    int ratie = 0;
    if(food.getCategoria() == 1) {ratie = StaticValues.micDejunCaloriesFromAllCalories;}
    if(food.getCategoria() == 2) {ratie = StaticValues.g1CaloriesFromAllCalories;}
    if(food.getCategoria() == 3) {ratie = StaticValues.pranzCaloriesFromAllCalories;}
    if(food.getCategoria() == 4) {ratie = StaticValues.g2CaloriesFromAllCalories;}
    if(food.getCategoria() == 5) {ratie = StaticValues.cinaCaloriesFromAllCalories;}
    int grams = ((ratie * 100) / food.getCalorii()).round();
    String mealgrams = grams.toString();

    int roundedMealGrams = 0;

    if (mealgrams.length == 4) {
      roundedMealGrams =
          int.parse((mealgrams.substring(0, 3).toString() + "0"));
    }

    if (mealgrams.length == 3) {
      roundedMealGrams =
          int.parse((mealgrams.substring(0, 2).toString() + "0"));
    }
    if (mealgrams.length == 2) {
      roundedMealGrams =
          int.parse((mealgrams.substring(0, 1) + "0").toString());
    }
    return roundedMealGrams;
  }

}