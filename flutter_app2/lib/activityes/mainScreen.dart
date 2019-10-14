import 'dart:io';
import 'dart:math';
import 'dart:ui' as prefix0;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_app/Utils/Person.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter_app/Utils/widgets/myRaisedButton.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter_app/Utils/widgets/my_small_rised_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'goPremium.dart';

class MainScreen extends StatefulWidget {

  @override
  _MainSCreenState createState() {
    return new _MainSCreenState();
  }
}

class _MainSCreenState extends State<MainScreen> {
  int _backPressedCounter = 0;
  Person person = new Person();
  String _personName = " ";
  String _currentGoal = " ";
  String _bmr = " ";
  SharedPreferences prefs;
  bool isProfilePic = false;
  String firstRandomInt;
  String secondRandomTipInt;
  bool isInitializated = false;
  bool isPremiumVersion = false;


  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    onStart();
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    if (_backPressedCounter == 2) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    } else {
      _backPressedCounter++;
      Fluttertoast.showToast(
          msg: AppLocalizations.of(context).translate("app_exit_toast"),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.black87,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return true;
  }

  void onStart() async {
    await _initialSetup();
  }

  Future <bool> _initialSetup() async {

    SetTips();

    prefs = await SharedPreferences.getInstance();
    person.setCaloriesNeeded(prefs.getInt("calneed"));
    person.setName(prefs.getString("nume"));
    person.setAge(prefs.getInt("varsta"));
    person.setHeight(prefs.getInt("inaltimea"));
    person.setCurrentWeight(prefs.getInt("greutatea"));
    person.setGoalWeight(prefs.getInt("greutateadorita"));
    person.setActivityIntensity(prefs.getInt("activitate"));
    person.setTrainPerWeek(prefs.getInt("antrenamente"));
    person.setGender(prefs.getInt("gender"));
    person.setProcessSpeed(prefs.getInt("processSpeed"));
    person.setUseImperial(prefs.getBool("useImperial"));
    person.setId(prefs.getString("personId"));
    person.setEmail(prefs.getString("email"));
    person.setBmr(prefs.getInt("bmr"));

      if (true) {
        // todo check if is buyed then hide go premium btn
      }
      String orentation = "";

      if (person.getCurrentWeight() > person.getGoalWeight()) {
        orentation = " <";
      }
      if (person.getCurrentWeight() < person.getGoalWeight()) {
        orentation = " >";
      }
      if (person.getCurrentWeight() == person.getGoalWeight()) {
        orentation = " =";
      }
      _personName = person.getName();
      _currentGoal =
          AppLocalizations.of(context).translate("profile_current_goal") +
              "\n" + orentation + person.getCaloriesNeeded().toString() + " " +
              AppLocalizations.of(context).translate("kcal_day");

      _bmr = AppLocalizations.of(context).translate("bmr_") + " " +
          person.getBmr().toString();

      isInitializated = true;
      setState(() {});
      CheckAndUploadUserData(person);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    _backPressedCounter = 0;
    if(isInitializated) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false ,
        ) ,
        body: Container(
          color: Colors.white70 ,
          padding: EdgeInsets.symmetric(horizontal: 15.0) ,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 40.0 ,
              ) ,
              Text(
                AppLocalizations.of(context).translate("app_name") ,
                textAlign: TextAlign.center ,
                style: TextStyle(fontSize: 23.0 , fontWeight: FontWeight.w600) ,
              ) ,
              SizedBox(height: 5.0) ,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0) ,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start ,
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: <Widget>[
                    Container(
                      height: 70.0 ,
                      child: Image(
                          image: AssetImage("assets/images/ganteragreen.png")) ,
                    ) ,
                    MySmallRaisedButton(
                      myOnPressed: () {},
                      mytext: "About" ,
                      myGradient: MyTheme.myVerticalGradient ,
                      myIcon: MdiIcons.informationOutline ,
                    ) ,
                    SizedBox(
                      width: 5.0 ,
                    ) ,
                    MySmallRaisedButton(
                      myOnPressed: () {} ,
                      mytext: AppLocalizations.of(context).translate("share_") ,
                      myGradient: MyTheme.myVerticalGradient ,
                      myIcon: MdiIcons.share ,
                    )
                  ] ,
                ) ,
              ) ,
              SizedBox(height: 20.0) ,
              MyRaisedButton(
                myOnPressed: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return new GoPremium();
                  }));
                } ,
                mytext: AppLocalizations.of(context).translate(
                    "go_premium_text") ,
                myGradient: MyTheme.myLinearGradient ,
                myIcon: MdiIcons.seal ,
              ) ,
              SizedBox(height: 20.0) ,
              Text(
                AppLocalizations.of(context)
                    .translate("click_on_name_bellow_for_detailas") ,
              ) ,
              Card(
                elevation: 15.0 ,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.green , width: 2.0) ,
                  borderRadius: BorderRadius.circular(20.0) ,
                ) ,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 18.0 , left: 15.0) ,
                          child: Row(
                     //       crossAxisAlignment: CrossAxisAlignment.start ,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.65 ,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    _personName ,
                                    maxLines: null,
                                    style: TextStyle(
                                        fontSize: 19.0 ,
                                        color: Colors.black ,
                                        fontWeight: FontWeight.w700) ,
                                  ),
                                ) ,
                              ) ,
                              Icon(
                                MdiIcons.seal ,
                                size: 45.0 ,
                                color: Colors.grey ,
                              ) ,
                            ] ,
                          ) ,
                        ) ,
                      ] ,
                    ) ,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0) ,
                              child: Container(
                                height: 150.0 ,
                                width: 140.0 ,
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black12 ,
                                        borderRadius: BorderRadius.circular(
                                            8.0)) ,
                                    padding: EdgeInsets.all(7.0) ,
                                    child: FutureBuilder(
                                      future: _getLocalFile("userimage.png") ,
                                      builder: (context , snapshot) {
                                        if (!isProfilePic) {
                                          return new Image.asset(
                                              "assets/images/facebook_user_image.png");
                                        } else {
                                          return new Image.file(snapshot.data);
                                        }
                                      } ,
                                    )) ,
                              ) ,
                            ) ,
                            SizedBox(
                              height: 20.0 ,
                            ) ,
                          ] ,
                        ) ,
                        Column(
                          children: <Widget>[
                            Container(
                              width: 140.0 ,
                              height: 160.0 ,
                              child: Padding(
                                padding: const EdgeInsets.only(right:5.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      //     " Un text foarte lung sa vedem cum reactioneaza",
                                      _currentGoal ,
                                      style: TextStyle(
                                          fontSize: 16.0 ,
                                          fontWeight: FontWeight.w600) ,
                                      maxLines: null ,
                                    ) ,
                                    SizedBox(
                                      height: 10.0 ,
                                    ) ,
                                    Text(
                                      _bmr ,
                                      style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500) ,
                                      maxLines: null ,
                                    ) ,
                                    SizedBox(
                                      height: 10.0 ,
                                    ) ,
                                    MyRaisedButton(
                                      mytext: "Ideas:" ,
                                      //       mytext: AppLocalizations.of(context).translate("idei"),
                                      myGradient: MyTheme.myLinearGradient ,
                                      myOnPressed: () {} ,
                                      myIcon: MdiIcons.lightbulbOn ,
                                    ) ,
                                  ] ,
                                ),
                              ) ,
                            )
                          ] ,
                        )
                      ] ,
                    )
                  ] ,
                ) ,
              ) ,
              SizedBox(height: 30.0 ,) ,
              Card(
                  elevation: 10.0 ,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green , width: 2.0) ,
                    borderRadius: BorderRadius.circular(20.0) ,
                  ) ,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0) ,
                    child: Column(
                      children: <Widget>[Row(
                        //    crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0) ,
                            child: Container(
                              height: 55.0 ,
                              child: Image(
                                  image: AssetImage(
                                      "assets/images/ganteragreen.png")) ,
                            ) ,
                          ) ,
                          Text(AppLocalizations.of(context).translate(
                              "tips_and_curiosities") ,
                            style: TextStyle(
                                fontSize: 19.0 , fontWeight: FontWeight.w700) ,)
                        ] ,
                      ) ,
                        SizedBox(height: 5.0 ,) ,
                        Padding(
                          padding: const EdgeInsets.all(8.0) ,
                          child: Text("  1) " +
                              AppLocalizations.of(context).translate(
                                  "tc" + firstRandomInt) + "\n" + "\n" +
                              "  2) " +
                              AppLocalizations.of(context).translate("tc" +
                                  secondRandomTipInt) + "\n" ,
                            maxLines: null ,

                            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400) ,) ,
                        ) ,
                        SizedBox(height: 10.0 ,) ,

                      ] ,

                    ) ,
                  )) ,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: <Widget>[
                  SizedBox(width: 10.0 ,) ,
                  MySmallRaisedButton(
                    myOnPressed: (){} ,
                    mytext: AppLocalizations.of(context).translate("share_") ,
                    myGradient: MyTheme.myVerticalGradient ,
                    myIcon: MdiIcons.share ,
                  ) ,
                ] ,
              ) ,
              SizedBox(height: 60.0 ,)
            ] ,
          ) ,
        ) ,
      );
    }
    else {
      return Scaffold(
          appBar: AppBar(
            title: Text("Please Wait"),
          ) ,
          body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0) ,
    child: ListView(
    children: <Widget>[
    SizedBox(
    height: 40.0 ,
    ),
      Center(
        child: SizedBox(
          height:80.0,
          width: 80.0,
          child: CircularProgressIndicator(
            semanticsValue: "This text is value",
            backgroundColor: Colors.grey,
            semanticsLabel: "This text is label",
          ),
        ),
      ),

     ]
    ),
    ),
      );

    }
  }

  Future<File> _getLocalFile(String filename) async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    File f = new File('$dir/$filename');
    bool output;
    await f.exists() ? output = true : output = false;
    isProfilePic = output;
    return f;
  }


  GoToSite() {}

  ShareApp() {

   // "https://play.google.com/store/apps/details?id=patrascuflorinapps.impactgymapp");
  }

  void CheckAndUploadUserData(Person person) {
    //todo
  }



  void SetTips() {
    int min = 1;
    int max = 27;
    var rnd = new Random();
    firstRandomInt = (min + rnd.nextInt(max - min)).toString();
    secondRandomTipInt = (min + rnd.nextInt(max - min)).toString();
    if(firstRandomInt == secondRandomTipInt){
      SetTips();
    }

   }
  ShareLayout() {

  }
}

