import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_app/Utils/Person.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter_app/Utils/static_values.dart';
import 'package:flutter_app/Utils/widgets/custom_flat_button.dart';
import 'package:flutter_app/Utils/widgets/myRaisedButton.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter_app/Utils/widgets/my_small_rised_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'details_screen.dart';
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
  bool _hideGoPremium = false;
  File image_file;
  ScreenshotController screenshotController = new ScreenshotController();

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
    onStartSetup();
    _getLocalFile("userimage.png");
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent) {
    if (_backPressedCounter >= 1) {
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

  void onStartSetup() async {
    await _initialSetup();
  }
  
  Future<bool> _initialSetup() async {
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

    StaticValues.person = person;

    if (StaticValues.isPremiumVersion == true) {
      _hideGoPremium = true;
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
            "\n" +
            orentation +
            person.getCaloriesNeeded().toString() +
            " " +
            AppLocalizations.of(context).translate("kcal_day");

    _bmr = AppLocalizations.of(context).translate("bmr_") +
        " " +
        person.getBmr().toString();

    isInitializated = true;
    setState(() {});
    CheckAndUploadUserData(person);

    return true;
  }

  @override
  Widget build(BuildContext context) {
    _backPressedCounter = 0;
    if (StaticValues.uploadPhoto) {
      StaticValues.uploadPhoto = false;
      _getPickedFile();
    }
    if (isInitializated) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: Colors.white70,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Text(
                AppLocalizations.of(context).translate("app_name"),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      child: Image(
                          image: AssetImage("assets/images/ganteragreen.png")),
                    ),
                    MySmallRaisedButton(
                      myOnPressed: () {
                        _launchURL();
                      },
                      mytext: "About",
                      myGradient: MyTheme.myVerticalGradient,
                      myIcon: Icon(MdiIcons.informationOutline, color: Colors.black),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    MySmallRaisedButton(
                      myOnPressed: () {
                        _shareDownloadLink();
                      },
                      mytext: AppLocalizations.of(context).translate("share_"),
                      myGradient: MyTheme.myVerticalGradient,
                      myIcon: Icon(MdiIcons.share, color: Colors.black),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              MyRaisedButton(
                isInvisible: _hideGoPremium,
                myOnPressed: () {
                  Navigator.of(context)
                      .push(new MaterialPageRoute(builder: (context) {
                    return new GoPremium();
                  }));
                },
                mytext:
                    AppLocalizations.of(context).translate("go_premium_text"),
                myGradient: MyTheme.myLinearGradient,
                myIcon: MdiIcons.seal,
              ),
              SizedBox(height: 20.0),
              Text(
                AppLocalizations.of(context)
                    .translate("click_on_name_bellow_for_detailas"),
              ),
              Card(
                elevation: 15.0,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: MyTheme.themeColor, width: 2.0),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 18.0, left: 15.0),
                          child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.start ,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    _personName,
                                    maxLines: null,
                                    style: TextStyle(
                                        fontSize: 19.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              Icon(
                                MdiIcons.seal,
                                size: 45.0,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () => showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return new _choosePictureDialog();
                                  },
                                ),
                                child: Container(
                                  height: 150.0,
                                  width: 140.0,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      padding: EdgeInsets.all(7.0),
                                      child: image_file != null ?
                                          Image.file(image_file):
                                        Image.asset("assets/images/facebook_user_image.png"),),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              width: 140.0,
                              height: 160.0,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      //     " Un text foarte lung sa vedem cum reactioneaza",
                                      _currentGoal,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                      maxLines: null,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    Text(
                                      _bmr,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w500),
                                      maxLines: null,
                                    ),
                                    SizedBox(
                                      height: 10.0,
                                    ),
                                    MyRaisedButton(
                                      isInvisible: false,
                                      mytext: "Ideas:",
                                      //       mytext: AppLocalizations.of(context).translate("idei"),
                                      myGradient: MyTheme.myLinearGradient,
                                      myOnPressed: () {
                                        Navigator.of(context).push(
                                            new MaterialPageRoute(
                                                builder: (context) {
                                          return new DetailsScreen();
                                        }));
                                      },
                                      myIcon: MdiIcons.lightbulbOn,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Screenshot(     controller: screenshotController,
                child: Container(color: Colors.white,
                  child: Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: MyTheme.themeColor, width: 2.0),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              //    crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 55.0,
                                    child: Image(
                                        image: AssetImage(
                                            "assets/images/ganteragreen.png")),
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)
                                      .translate("tips_and_curiosities"),
                                  style: TextStyle(
                                      fontSize: 19.0, fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "  1) " +
                                    AppLocalizations.of(context)
                                        .translate("tc" + firstRandomInt) +
                                    "\n" +
                                    "\n" +
                                    "  2) " +
                                    AppLocalizations.of(context)
                                        .translate("tc" + secondRandomTipInt) +
                                    "\n",
                                maxLines: null,
                                style: TextStyle(
                                    fontSize: 16.0, fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  MySmallRaisedButton(
                    myOnPressed: () {_shareLayout();},
                    mytext: AppLocalizations.of(context).translate("share_"),
                    myGradient: MyTheme.myVerticalGradient,
                    myIcon: Icon(MdiIcons.share, color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 60.0,
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Please Wait"),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: SizedBox(
                height: 80.0,
                width: 80.0,
                child: CircularProgressIndicator(
                  semanticsValue: "This text is value",
                  backgroundColor: Colors.grey,
                  semanticsLabel: "This text is label",
                ),
              ),
            ),
          ]),
        ),
      );
    }
  }

  Future<void> _getLocalFile(String filename) async {
    File f = new File("");
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    // load facebook profile image
    image_file = new File('$path/$filename');
    bool isFile = await image_file.exists();
    if (isFile) {
      setState(() {});
    }
  }

  Future<void> _getPickedFile() async {
    File f = new File("");
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String path = appDocDir.path;
    image_file = await ImagePicker.pickImage(source: ImageSource.gallery);
    String name = "userimage.png";
    bool isFile = await image_file.exists();
    if (isFile) {
      imageCache.clear();
      f = await image_file.copy('$path/$name');
      setState(() {});
    }
  }

  GoToSite() {}

  ShareApp() {
    // "https://play.google.com/store/apps/details?id=patrascuflorinapps.impactgymapp");
  }

  void CheckAndUploadUserData(Person person) {
    //todo
  }

  _shareDownloadLink() async {
    // todo check package docs for ios error
    // todo set link for each store

    String appname = AppLocalizations.of(context).translate("app_name");

    if (Platform.isIOS) {
      //todo
    } else {
      Share.text(appname + ' download Link: ',
          'https://www.diet-and-workout-plan.com/', "text/plain");
    }
  }

  _launchURL() async {
    const url = 'https://www.diet-and-workout-plan.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void SetTips() {
    int min = 1;
    int max = 27;
    var rnd = new Random();
    firstRandomInt = (min + rnd.nextInt(max - min)).toString();
    secondRandomTipInt = (min + rnd.nextInt(max - min)).toString();
    if (firstRandomInt == secondRandomTipInt) {
      SetTips();
    }
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
}

class _choosePictureDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(10.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      title: Text(
        AppLocalizations.of(context).translate("upload_photo"),
        softWrap: true,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          decoration: TextDecoration.none,
          fontSize: 18,
          fontWeight: FontWeight.w700,
          fontFamily: "OpenSans",
        ),
      ),
      content: Container(
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate("choose_another_photo"),
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black87,
                decoration: TextDecoration.none,
                fontSize: 17,
                fontWeight: FontWeight.w400,
                fontFamily: "OpenSans",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomFlatButton(
                    title: AppLocalizations.of(context).translate("no_"),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    color: MyTheme.themeColor,
                    splashColor: Colors.black12,
                    borderColor: Colors.black12,
                    borderWidth: 2,
                  ),
                  CustomFlatButton(
                    title: AppLocalizations.of(context).translate("yes_"),
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textColor: Colors.white,
                    onPressed: () {
                      StaticValues.uploadPhoto = true;
                      Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) {
                        return new MainScreen();
                      }));
                    },
                    color: MyTheme.themeColor,
                    splashColor: Colors.black12,
                    borderColor: Colors.black12,
                    borderWidth: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
