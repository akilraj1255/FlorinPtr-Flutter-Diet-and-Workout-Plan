import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter_app/Utils/static_values.dart';
import 'package:flutter_app/Utils/widgets/my_small_rised_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomTipsScreen extends StatelessWidget{
  String custom_tips = "      ";

  @override
  Widget build(BuildContext context) {
    custom_tips +=  AppLocalizations.of(context).translate("your_bmr_is") + " " +
        StaticValues.person.getBmr().toString()  +  
       AppLocalizations.of(context).translate("bmr_starting_point");

    if (StaticValues.person.getCurrentWeight() > StaticValues.person.getGoalWeight()) {
     custom_tips += AppLocalizations.of(context).translate("obiectiv_title") + " " + 
         AppLocalizations.of(context).translate("obiectiv_text");
    }

    if (StaticValues.person.getCurrentWeight() < StaticValues.person.getGoalWeight()) {
     custom_tips += AppLocalizations.of(context).translate("obiectiv_title") + " " +
         AppLocalizations.of(context).translate("obiectiv_text_masa");
    }

    String trainsperweek = StaticValues.person.getTrainPerWeek().toString();
   custom_tips += "\n"+    AppLocalizations.of(context).translate("antrnamente_setate");

    if(trainsperweek == "0"){
     custom_tips += "0"+ " " + AppLocalizations.of(context).translate("antrenamente_zero");
    }

    if(trainsperweek == "2"){
     custom_tips += trainsperweek + " " +
         AppLocalizations.of(context).translate("antrenament_doua_zile");
    }

    if(trainsperweek == "3") {
     custom_tips += trainsperweek+  " " +
         AppLocalizations.of(context).translate("antrenament_trei_zile");
    }

    if(trainsperweek == "4") {
     custom_tips += trainsperweek+ " " +
         AppLocalizations.of(context).translate("antrenament_patru_zile");
    }
   if(trainsperweek == "5") {
     //todo
  //   custom_tips += trainsperweek + " " +
       //  AppLocalizations.of(context).translate("antrenament_cinci_zile");
   }
   custom_tips += "\n      " +    AppLocalizations.of(context).translate("diet_matters");
    String waterNeed = (StaticValues.person.getCurrentWeight()*0.033).toString().substring(0, 3);
    waterNeed += " " +     AppLocalizations.of(context).translate("litri_");
   custom_tips += AppLocalizations.of(context).translate("last_tip") + " " +
       waterNeed + " "  +  AppLocalizations.of(context).translate("of_water");
    
    return Scaffold(appBar: AppBar(backgroundColor: MyTheme.themeColor, title:
     Text( AppLocalizations.of(context).translate("custom_tips")), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 20,),
          Text(StaticValues.person.getName().replaceFirst(":", ","),
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700), textAlign: TextAlign.center,),
          SizedBox(height: 20,),
          Text(custom_tips, style: TextStyle(fontSize: 17),),
          SizedBox(height: 30.0,),
            ],
          ),
        ],),
      ),);
  }

}