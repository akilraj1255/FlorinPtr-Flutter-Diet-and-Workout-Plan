
import 'package:flutter/cupertino.dart';
import 'app_localizations.dart';

class ConverterClass  {

   static String Convert (BuildContext context, String ingredient, int value){

    String output;

    if (ingredient == AppLocalizations.of(context).translate("chiken_eggs")){
      int myInt = (value/ 57).round();
      if (myInt>1) {
        output = (myInt).toString() + " " + AppLocalizations.of(context).translate("eggs_");
      }
      else {
        output = (myInt).toString() + " " + AppLocalizations.of(context).translate("single_egg");
      }
    }

    else if (ingredient == AppLocalizations.of(context).translate("lapte") ||
        ingredient == AppLocalizations.of(context).translate("lapte_sau_lapte_cocos")
        || ingredient == AppLocalizations.of(context).translate("ulei_masline")
        || ingredient == AppLocalizations.of(context).translate("lapte_migdale")){
      output = value.toString() + "ml";
    }

    else {
      output = value.toString() + "g";
    }

    return  output;
  }

 }