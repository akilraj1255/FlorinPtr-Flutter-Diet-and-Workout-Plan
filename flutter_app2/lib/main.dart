import 'package:flutter/services.dart';
import 'package:flutter_app/activityes/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'activityes/myWelcome.dart';


void main() {

  WidgetsFlutterBinding.ensureInitialized();
  nextAction().then((bool isP){
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp(isP));
  });
  });
}


Future <bool> nextAction () async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String pName =  prefs.getString("nume" ?? null);
  if(pName != null){
    return true;
  } else {
    return false;
  }
}

class MyApp extends StatelessWidget {
  bool isPerson;
  Widget w;

  MyApp(bool isPerson){
    this.isPerson = isPerson;
  }

  @override
  Widget build(BuildContext context) {

    isPerson ? w = MainScreen() : w= MyWelcome();

    return MaterialApp(
        title: 'Flutter ' ,
        theme: ThemeData(
          primarySwatch: Colors.green ,
        ) ,
        // List all of the app's supported locales here
        supportedLocales: [
          Locale('en' , 'US') ,
          Locale('ro' , 'RO') ,
        ] ,
        // These delegates make sure that the localization data for the proper language is loaded
        localizationsDelegates: [
          // THIS CLASS WILL BE ADDED LATER
          // A class which loads the translations from JSON files
          AppLocalizations.delegate ,
          // Built-in localization of basic text for Material widgets
          GlobalMaterialLocalizations.delegate ,
          // Built-in localization for text direction LTR/RTL
          GlobalWidgetsLocalizations.delegate ,
        ] ,
        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale , supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        } ,

        home: w
    );
  }
}
