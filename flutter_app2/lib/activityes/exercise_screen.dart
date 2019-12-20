import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_app/Utils/Exercise.dart';
import 'package:flutter_app/Utils/Mancare.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter_app/Utils/static_values.dart';
import 'package:flutter_app/Utils/widgets/CustomExerciseCard.dart';
import 'package:flutter_app/Utils/widgets/custom_flat_button.dart';
import 'package:flutter_app/Utils/widgets/myRaisedButton.dart';
import 'package:flutter_app/Utils/widgets/my_small_rised_button.dart';
import 'package:flutter_app/activityes/custom_tips_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseScreen extends StatefulWidget {
  @override
  _exerciseScreenState createState() {
    return _exerciseScreenState();
  }
}

class _exerciseScreenState extends State<ExerciseScreen> {
  List<Exercise> allExercises = new List();
  bool isInitializated = false;
  List<String> spinnerItems;
  String dropdownValue;
  List<List<Widget>> _allPages = new List();
  List<Widget> _getPages1 = [];
  List<Widget> _getPages2 = [];
  List<Widget> _getPages3 = [];
  List<Widget> _getPages4 = [];
  List<Widget> _getPages5 = [];
  int radioButtonFitnessValue;
  int radioButtonStrenghtValue;
  List<List<Exercise>> listOfLists = new List();
  List<Exercise> _list1 = new List();
  List<Exercise> _list2 = new List();
  List<Exercise> _list3 = new List();
  List<Exercise> _list4 = new List();
  List<Exercise> _list5 = new List();

  var selectedRadioBtn = 1;

  bool isFitness = true;

  //SwiperController swiperController1 = new SwiperController();

  void _loadExerciseLists() {
    allExercises = new List();

    if (StaticValues.person.getGender() == 1) {
      List<String> flegsexercises = new List();

      flegsexercises.add("assets/images/flegssquat.png");
      flegsexercises.add("assets/images/flegsseatedcurls.png");
      flegsexercises.add("assets/images/flegslyinglegs.png");
      flegsexercises.add("assets/images/flegsdumbelllunges.png");
      flegsexercises.add("assets/images/flegsaductormachine.png");
      flegsexercises.add("assets/images/flegsaductorkneeraise.png");
      flegsexercises.add("assets/images/flegsbulgariansplitsquat.png");
      flegsexercises.add("assets/images/flegsmachinepress.png");
      flegsexercises.add("assets/images/flegsdonkeykicks.png");
      flegsexercises.add("assets/images/flegsseatedcalfraises.png");
      flegsexercises.add("assets/images/flegsbodyweightcalfraises.png");

      for (int i = 1; i < flegsexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setCategory(AppLocalizations.of(context).translate("legs"));
        ex.setName(AppLocalizations.of(context).translate("legs"));
        ex.setPoza(flegsexercises[i - 1]);

        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> fbackexercises = new List();

      fbackexercises.add("assets/images/fbackdeadlift.png");
      fbackexercises.add("assets/images/fbackassistedpushups.png");
      fbackexercises.add("assets/images/fbackwidepull.png");
      fbackexercises.add("assets/images/fbacknarrowpull.png");
      fbackexercises.add("assets/images/fbackbentoverrow.png");
      fbackexercises.add("assets/images/fbackextensions.png");

      for (int i = 1; i < fbackexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setCategory(AppLocalizations.of(context).translate("back"));
        ex.setName(AppLocalizations.of(context).translate("back"));
        ex.setPoza(fbackexercises[i - 1]);

        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> fchestexercises = new List();

      fchestexercises.add("assets/images/fchestbenchpress.png");
      fchestexercises.add("assets/images/fchestdumbellflatbench.png");
      fchestexercises.add("assets/images/fchestinclinedumbellpress.png");
      fchestexercises.add("assets/images/fchestinclinebenchdumbellfly.png");
      fchestexercises.add("assets/images/fchestbutterflymachine.png");
      fchestexercises.add("assets/images/fchestmedicineballpushups.png");

      for (int i = 1; i < fchestexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setCategory(AppLocalizations.of(context).translate("chest"));
        ex.setName(AppLocalizations.of(context).translate("chest"));
        ex.setPoza(fchestexercises[i - 1]);

        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> ftricepsexercises = new List();

      ftricepsexercises.add("assets/images/ftricepslyingdumbell.png");
      ftricepsexercises.add("assets/images/ftricepsseated.png");
      ftricepsexercises.add("assets/images/ftricepsweightedbenchppush.png");
      ftricepsexercises.add("assets/images/ftricepsdeclineskull.png");
      ftricepsexercises.add("assets/images/ftricepslyingdumbell.png");
      ftricepsexercises.add("assets/images/ftricepsdumbellkickback.png");

      for (int i = 1; i < ftricepsexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setCategory("Triceps");
        ex.setName("Triceps");
        ex.setPoza(ftricepsexercises[i - 1]);

        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> fbicepsexercises = new List();

      fbicepsexercises.add("assets/images/fbicepsbarbellbicepsstanding.png");
      fbicepsexercises.add("assets/images/fbicepshammercurls.png");
      fbicepsexercises.add("assets/images/fbicepsconcentrationcurl.png");
      fbicepsexercises.add("assets/images/fbicepsstandingdumbbellcurl.png");
      fbicepsexercises.add("assets/images/fbicepsreversecurl.png");

      for (int i = 1; i < fbicepsexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setCategory("Biceps");
        ex.setName("Biceps");
        ex.setPoza(fbicepsexercises[i - 1]);
        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> fdeltsexercises = new List();

      fdeltsexercises.add("assets/images/fdeltsdumbellsholderseatedpress.png");
      fdeltsexercises.add("assets/images/fdeltsfrontdumbellraise.png");
      fdeltsexercises.add("assets/images/fdeltslateralraise.png");
      fdeltsexercises.add("assets/images/fdeltsreverseflyes.png");
      fdeltsexercises.add("assets/images/fdeltscableuprightrow.png");
      fdeltsexercises.add("assets/images/fdeltsreardeltpull.png");

      for (int i = 1; i < fdeltsexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setCategory(AppLocalizations.of(context).translate("umeri"));
        ex.setName(AppLocalizations.of(context).translate("umeri"));
        ex.setPoza(fdeltsexercises[i - 1]);

        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }
      List<String> fabsexercises = new List();

      fabsexercises.add("assets/images/fabshanginglegraise.png");
      fabsexercises.add("assets/images/fabsbenchkneeup.png");
      fabsexercises.add("assets/images/fabsweightedtwist.png");
      fabsexercises.add("assets/images/fabsrussiantwist.png");
      fabsexercises.add("assets/images/fabsswissbalcrunch.png");
      fabsexercises.add("assets/images/fabsjacknifesitupcrunch.png");
      fabsexercises.add("assets/images/fabsdumbellside.png");

      for (int i = 1; i < fabsexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setCategory(AppLocalizations.of(context).translate("abs"));
        ex.setName(AppLocalizations.of(context).translate("abs"));
        ex.setPoza(fabsexercises[i - 1]);

        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }
    }

    if (StaticValues.person.getGender() == 2) {
      allExercises.clear();

      List<String> mlegsexercises = new List();

      mlegsexercises.add("assets/images/mlegsbarbellsquat.png");
      mlegsexercises.add("assets/images/mlegslegpress.png");
      mlegsexercises.add("assets/images/mlegsdumbelllunges.png");
      mlegsexercises.add("assets/images/mlegssmithmachinesquats.png");
      mlegsexercises.add("assets/images/mlegsseatedmachinelegextensions.png");
      mlegsexercises.add("assets/images/mlegslyinglegcurls.png");
      mlegsexercises.add("assets/images/mlegsstandingdumbellcalfraise.png");
      mlegsexercises.add("assets/images/mlegscalfraiseseated.png");

      for (int i = 1; i < mlegsexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setCategory(AppLocalizations.of(context).translate("legs"));
        ex.setName(AppLocalizations.of(context).translate("legs"));
        ex.setPoza(mlegsexercises[i - 1]);
        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> mbackexercises = new List();

      mbackexercises.add("assets/images/mbackpullups.png");
      mbackexercises.add("assets/images/mbackromaniandeadlift.png");
      mbackexercises.add("assets/images/mbacktwoarmslongbarbellrow.png");
      mbackexercises.add("assets/images/mbackwidegrippulldown.png");
      mbackexercises.add("assets/images/mbackbentoverbarbellrow.png");
      mbackexercises.add("assets/images/mbackdumbellinclinebenchrow.png");
      mbackexercises.add("assets/images/mbackbarbellshrug.png");

      for (int i = 1; i < mbackexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setName(AppLocalizations.of(context).translate("back"));
        ex.setCategory(AppLocalizations.of(context).translate("back"));
        ex.setPoza(mbackexercises[i - 1]);

        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> mchestexercises = new List();

      mchestexercises.add("assets/images/mchestbarbellbenchpress.png");
      mchestexercises.add("assets/images/mchestinclinedbenchpress.png");
      mchestexercises.add("assets/images/mchestbarbelldeclinebenchpress.png");
      mchestexercises.add("assets/images/mchestinclinedumbellbenchpress.png");
      mchestexercises.add("assets/images/mchestcablecrossover.png");
      mchestexercises.add("assets/images/mchestdumbellpullover.png");
      mchestexercises.add("assets/images/mchestdeclinepushups.png");

      for (int i = 1; i < mchestexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setName(AppLocalizations.of(context).translate("chest"));
        ex.setCategory(AppLocalizations.of(context).translate("chest"));
        ex.setPoza(mchestexercises[i - 1]);
        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> mtricepsexercises = new List();

      mtricepsexercises.add("assets/images/mtiricepsdips.png");
      mtricepsexercises.add("assets/images/mtricepsdumbellaboveheadpush.png");
      mtricepsexercises.add("assets/images/mtricepskickback.png");
      mtricepsexercises.add("assets/images/mtricepscableropoverhead.png");
      mtricepsexercises.add("assets/images/mtricepsonearmaboveheaddumbell.png");
      mtricepsexercises.add("assets/images/mtricepscablepushdown.png");

      for (int i = 1; i < mtricepsexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setName("Triceps");
        ex.setCategory("Triceps");
        ex.setPoza(mtricepsexercises[i - 1]);
        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> mbicepsexercises = new List();

      mbicepsexercises.add("assets/images/mbicepsbarbellcurl.png");
      mbicepsexercises.add("assets/images/mbicepsseateddumbellcurl.png");
      mbicepsexercises.add("assets/images/mbicepshammers.png");
      mbicepsexercises.add("assets/images/mbicepsmachinepreacher.png");
      mbicepsexercises.add("assets/images/mbicepsconcentrationcurl.png");
      mbicepsexercises.add("assets/images/mbicepsstrapbicepscurls.png");
      mbicepsexercises.add("assets/images/mbicepsreversedumbelcurl.png");

      for (int i = 1; i < mbicepsexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setName("Biceps");
        ex.setCategory("Biceps");
        ex.setPoza(mbicepsexercises[i - 1]);

        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> mdeltsexercises = new List();

      mdeltsexercises
          .add("assets/images/mdeltsseatedbarbellmilitarypress.jpeg");
      mdeltsexercises.add("assets/images/mdeltsdumbellseatedpress.png");
      mdeltsexercises.add("assets/images/mdeltsfrontdumbelrise.png");
      mdeltsexercises.add("assets/images/mdeltslateraldumbells.png");
      mdeltsexercises.add("assets/images/mdeltsreverseflyes.png");

      for (int i = 1; i < mdeltsexercises.length + 1; i++) {
        Exercise ex = new Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setName(AppLocalizations.of(context).translate("umeri"));
        ex.setCategory(AppLocalizations.of(context).translate("umeri"));
        ex.setPoza(mdeltsexercises[i - 1]);

        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }

      List<String> mabsexercises = new List();

      mabsexercises.add("assets/images/mabslyinglegraise.png");
      mabsexercises.add("assets/images/mabssitups.png");
      mabsexercises.add("assets/images/mabsweightedtwist.png");
      mabsexercises.add("assets/images/mabswindshielwipers.png");
      mabsexercises.add("assets/images/mabsplank.png");

      for (int i = 1; i < mabsexercises.length + 1; i++) {
        Exercise ex = Exercise();
        if (i > 3) {
          ex.setLocked(true);
        }
        ex.setName(AppLocalizations.of(context).translate("abs"));
        ex.setCategory(AppLocalizations.of(context).translate("abs"));
        ex.setPoza(mabsexercises[i - 1]);

        ex.setId(i.toString() + ex.getName());

        allExercises.add(ex);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await _initData();
    _loadExerciseLists();
    _setExerciseLists(StaticValues.exerciseSpinnerIndex);
  }

  @override
  Widget build(BuildContext context) {
    spinnerItems = [
      AppLocalizations.of(context).translate("e_arms") ,
      AppLocalizations.of(context).translate("e_back") ,
      AppLocalizations.of(context).translate("e_backandbiceps") ,
      AppLocalizations.of(context).translate("e_backandtriceps") ,
      AppLocalizations.of(context).translate("e_chest") ,
      AppLocalizations.of(context).translate("e_ChestAndBiceps") ,
      AppLocalizations.of(context).translate("e_chestandtriceps") ,
      AppLocalizations.of(context).translate("e_shoulders") ,
      AppLocalizations.of(context).translate("e_fullbody") ,
      AppLocalizations.of(context).translate("e_lowerbody") ,
      AppLocalizations.of(context).translate("e_legs") ,
      AppLocalizations.of(context).translate("e_legsandabs") ,
      AppLocalizations.of(context).translate("e_upperbody") ,
    ];
    dropdownValue = spinnerItems[StaticValues.exerciseSpinnerIndex];

    if (isInitializated) {
      return Scaffold(
        backgroundColor: MyTheme.customBackgrounColor ,
        bottomSheet: Container(height: 70.0 , color: MyTheme.themeColor ,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0) ,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                children: <Widget>[
                  IconButton(icon: Icon(
                    Icons.arrow_back , color: Colors.white , size: 28.0 ,) ,
                    onPressed: () {
                      Navigator.of(context).pop();
                    } ,) ,
                  Row(
                    children: <Widget>[
                      MySmallRaisedButton(
                        mytext: AppLocalizations.of(context).translate(
                            "custom_tips") ,
                        textColor: Colors.white ,
                        fontSize: 20.0 ,
                        myIcon: Icon(Icons.info_outline, color: Colors.black),
                        myGradient: MyTheme.myVerticalGradient ,
                        myOnPressed: () { Navigator.of(context).push(
                            new MaterialPageRoute(builder: (context) {
                              return new CustomTipsScreen();
                            })
                        );} ,) ,
                    ] ,
                  )

                ] ,
              ) ,
            )) ,
        body: Container(
          child: ListView(children: <Widget>[
            SizedBox(
              height: 25.0 ,
            ) ,
            Padding(
              padding: const EdgeInsets.all(8.0) ,
              child: Text(
                StaticValues.person.getName().replaceFirst(":" , ", " , 0) +
                    AppLocalizations.of(context)
                        .translate("what_do_you_want_to_work_today") ,
                style: TextStyle(
                  fontSize: 18.0 ,
                  fontWeight: FontWeight.w600 ,
                ) ,
                textAlign: TextAlign.center ,
              ) ,
            ) ,
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0) ,
                child: Card(
                  elevation: 0.0 ,
                  color: Colors.white ,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: MyTheme.themeColor , width: 2.0) ,
                    borderRadius: BorderRadius.circular(15.0) ,
                  ) ,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0) ,
                    child: DropdownButton<String>(
                      value: dropdownValue ,
                      icon: Icon(Icons.menu) ,
                      iconSize: 24 ,
                      elevation: 16 ,
                      style: TextStyle(color: Colors.black , fontSize: 18) ,
                      onChanged: (String data) {
                        StaticValues.exerciseSpinnerIndex =
                            spinnerItems.indexOf(data);
                        setState(() {
                          _setExerciseLists(StaticValues.exerciseSpinnerIndex);
                        });
                      } ,
                      items: spinnerItems
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value ,
                          child: Text(value) ,
                        );
                      }).toList() ,
                    ) ,
                  ) ,
                ) ,
              ) ,
            ) ,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _setSelectedRadioBtn(1);
                  } ,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2.2 ,
                    child: ListTile(
                      title: Text("Fitness") ,
                      leading: Radio(
                        value: 1 ,
                        groupValue: selectedRadioBtn ,
                        activeColor: MyTheme.themeColor ,
                        onChanged: (val) {
                          _setSelectedRadioBtn(val);
                        } ,
                      ) ,
                    ) ,
                  ) ,
                ) ,
                Container(
                  height: 18 ,
                  width: 2 ,
                  color: Colors.black ,
                ) ,
                GestureDetector(
                  onTap: () {
                    _setSelectedRadioBtn(2);
                  } ,
                  child: Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 2.2 ,
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context)
                            .translate("strenghtTraining") ,
                      ) ,
                      leading: Radio(
                        value: 2 ,
                        groupValue: selectedRadioBtn ,
                        activeColor: MyTheme.themeColor ,
                        onChanged: (val) {
                          _setSelectedRadioBtn(val);
                        } ,
                      ) ,
                    ) ,
                  ) ,
                ) ,
              ] ,
            ) ,


            SizedBox(
              height: 10.0 ,
            ) ,
            Container(
              height: 180.0 ,
              //  color: Colors.red,
              constraints: BoxConstraints(
                  minWidth: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9 ,
                  minHeight: 25.0) ,
              child: _list1.length > 0
                  ? Swiper.children(
                onTap: (index) {} ,
                viewportFraction: 0.9 ,
                //                 controller: swiperController1,
                scale: 1 ,
                autoplay: false ,
                index: StaticValues.exerciseSwiperIndex1 ,
                loop: false ,
                reverse: true ,
                autoplayDisableOnInteraction: true ,
                onIndexChanged: (index) {
                  StaticValues.exerciseSwiperIndex1 = index;
                } ,
                pagination: null ,
                children: _getPages1 ,
              )
                  : Container() ,
            ) ,
            SizedBox(
              height: 10.0 ,
            ) ,

            Container(
              child: _list2.length > 0 ?
              Container(
                  height: 180.0 ,
                  //  color: Colors.red,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9 ,
                      minHeight: 25.0) ,
                  child: Swiper.children(
                    onTap: (index) {} ,
                    viewportFraction: 0.9 ,
                    //      controller: swiperController1,
                    scale: 1 ,
                    autoplay: false ,
                    index: StaticValues.exerciseSwiperIndex2 ,
                    loop: false ,
                    reverse: true ,
                    autoplayDisableOnInteraction: true ,
                    onIndexChanged: (index) {
                      StaticValues.exerciseSwiperIndex2 = index;
                    } ,
                    pagination: null ,
                    children: _getPages2 ,
                  )
              ) : Container(height: 0.0) ,
            ) ,
            SizedBox(
              height: 10.0 ,
            ) ,
            Container(
              child: _list3.length > 0 ?
              Container(
                height: 180.0 ,
                //  color: Colors.red,
                constraints: BoxConstraints(
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9 ,
                    minHeight: 25.0) ,
                child: Swiper.children(
                  onTap: (index) {} ,
                  viewportFraction: 0.9 ,
                  //    controller: swiperController1,
                  scale: 1 ,
                  autoplay: false ,
                  index: StaticValues.exerciseSwiperIndex3 ,
                  loop: false ,
                  reverse: true ,
                  autoplayDisableOnInteraction: true ,
                  onIndexChanged: (index) {
                    StaticValues.exerciseSwiperIndex3 = index;
                  } ,
                  pagination: null ,
                  children: _getPages3 ,
                ) ,)
                  : Container(height: 0.0 ,) ,
            ) ,
            SizedBox(
              height: 10.0 ,
            ) ,
            Container(
              child: _list4.length > 0 ?
              Container(
                  height: 180.0 ,
                  //  color: Colors.red,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9 ,
                      minHeight: 25.0) ,
                  child: Swiper.children(
                    onTap: (index) {} ,
                    viewportFraction: 0.9 ,
                    //       controller: swiperController1,
                    scale: 1 ,
                    autoplay: false ,
                    index: StaticValues.exerciseSwiperIndex4 ,
                    loop: false ,
                    reverse: true ,
                    autoplayDisableOnInteraction: true ,
                    onIndexChanged: (index) {
                      StaticValues.exerciseSwiperIndex4 = index;
                    } ,
                    pagination: null ,
                    children: _getPages4 ,
                  )
              ) : Container(height: 0.0 ,) ,
            ) ,
            SizedBox(
              height: 10.0 ,
            ) ,
            Container(
              child: _list5.length > 0 ?
              Container(
                height: 180.0 ,
                //  color: Colors.red,
                constraints: BoxConstraints(
                    minWidth: MediaQuery
                        .of(context)
                        .size
                        .width * 0.9 ,
                    minHeight: 25.0) ,
                child: Swiper.children(
                  onTap: (index) {} ,
                  viewportFraction: 0.9 ,
                  //   controller: swiperController1,
                  scale: 1 ,
                  autoplay: false ,
                  index: StaticValues.exerciseSwiperIndex5 ,
                  loop: false ,
                  reverse: true ,
                  autoplayDisableOnInteraction: true ,
                  onIndexChanged: (index) {
                    StaticValues.exerciseSwiperIndex5 = index;
                  } ,
                  pagination: null ,
                  children: _getPages5 ,
                ) ,) : Container(height: 0.0 ,) ,
            ) ,
            SizedBox(height: 75.0 ,)
          ]) ,
        ) ,
      );
    } else {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0) ,
          child: ListView(children: <Widget>[
            SizedBox(
              height: 40.0 ,
            ) ,
            Center(
              child: SizedBox(
                height: 80.0 ,
                width: 80.0 ,
                child: CircularProgressIndicator(
                  semanticsValue: "This text is value" ,
                  backgroundColor: Colors.grey ,
                  semanticsLabel: "This text is label" ,
                ) ,
              ) ,
            ) ,
          ]) ,
        ) ,
      );
    }
  }

  void _setExerciseLists(int position) {
    _list1.clear();
    _list2.clear();
    _list3.clear();
    _list4.clear();
    _list5.clear();

    if (position == 0) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() == "Triceps") {
          _list1.add(allExercises[i]);
        }

        if (allExercises[i].getName() == "Biceps") _list2.add(allExercises[i]);
      }
    }

    if (position == 1) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("back")) {
          _list1.add(allExercises[i]);
        }
      }
    }
    if (position == 2) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("back")) {
          _list1.add(allExercises[i]);
        }

        if (allExercises[i].getName() == "Biceps") {
          _list2.add(allExercises[i]);
        }
      }
    }
    if (position == 3) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("back")) {
          _list1.add(allExercises[i]);
        }

        if (allExercises[i].getName() == "Triceps") {
          _list2.add(allExercises[i]);
        }
      }
    }
    if (position == 4) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("chest")) {
          _list1.add(allExercises[i]);
        }
      }
    }
    if (position == 5) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("chest")) {
          _list1.add(allExercises[i]);
        }

        if (allExercises[i].getName() == "Biceps") {
          _list2.add(allExercises[i]);
        }
      }
    }
    if (position == 6) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("chest")) {
          _list1.add(allExercises[i]);
        }
        if (allExercises[i].getName() == "Triceps") {
          _list2.add(allExercises[i]);
        }
      }
    }

    if (position == 7) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("umeri"))
          _list1.add(allExercises[i]);
      }
    }
    if (position == 8) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("chest")) {
          _list1.add(allExercises[i]);
        }
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("back")) {
          _list2.add(allExercises[i]);
        }
        if (allExercises[i].getName() == "Triceps") {
          _list3.add(allExercises[i]);
        }

        if (allExercises[i].getName() == "Biceps") {
          _list3.add(allExercises[i]);
        }
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("legs")) {
          _list4.add(allExercises[i]);
        }
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("umeri")) {
          _list5.add(allExercises[i]);
        }
      }
    }
    if (position == 9) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("legs")) {
          _list1.add(allExercises[i]);
        }

        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("abs")) {
          _list2.add(allExercises[i]);
        }
      }
    }
    if (position == 10) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("legs")) {
          _list1.add(allExercises[i]);
        }
      }
    }
    if (position == 11) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("legs")) {
          _list1.add(allExercises[i]);
        }

        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("abs")) {
          _list2.add(allExercises[i]);
        }
      }
    }
    if (position == 12) {
      for (int i = 0; i < allExercises.length; i++) {
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("back")) {
          _list1.add(allExercises[i]);
        }

        if (allExercises[i].getName() == "Biceps") {
          _list1.add(allExercises[i]);
        }

        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("chest")) {
          _list2.add(allExercises[i]);
        }

        if (allExercises[i].getName() == "Triceps") {
          _list2.add(allExercises[i]);
        }
        if (allExercises[i].getName() ==
            AppLocalizations.of(context).translate("umeri")) {
          _list3.add(allExercises[i]);
        }
      }
    }
    StaticValues.exerciseSwiperIndex1 = 0;
    StaticValues.exerciseSwiperIndex2 = 0;
    StaticValues.exerciseSwiperIndex3 = 0;
    StaticValues.exerciseSwiperIndex4 = 0;
    StaticValues.exerciseSwiperIndex5 = 0;

    _loadPages();
  }

  Future<void> _loadPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("spinnerIndex" , StaticValues.exerciseSpinnerIndex);

    _getPages1.clear();
    _getPages2.clear();
    _getPages3.clear();
    _getPages4.clear();
    _getPages5.clear();

    listOfLists.clear();
    listOfLists.add(_list1);
    listOfLists.add(_list2);
    listOfLists.add(_list3);
    listOfLists.add(_list4);
    listOfLists.add(_list5);

    _allPages.clear();
    _allPages.add(_getPages1);
    _allPages.add(_getPages2);
    _allPages.add(_getPages3);
    _allPages.add(_getPages4);
    _allPages.add(_getPages5);

    if (isFitness) {
      _updateRepsAndSets(1);
      selectedRadioBtn = 1;
    } else {
      _updateRepsAndSets(2);
      selectedRadioBtn = 2;
    }

    for (int j = 0; j < listOfLists.length; j++) {
      if (listOfLists[j].length > 0) {
        for (int i = 0; i < listOfLists[j].length; i++) {
          Exercise exercise = listOfLists[j][i];

          _allPages[j].add(new CustomExerciseCard(
            id: exercise.getId() ,
            cathegory: exercise.getCategory() ,
            position:
            (i + 1).toString() + "/" + listOfLists[j].length.toString() ,
            exerciseName: exercise.getName() ,
            isFavorite:
            prefs.getBool(exercise.id.toString() + "isfavexercise") ??
                false ,
            assetPath: exercise.getPoza() ,
            link: exercise.getLink() ,
            sets: exercise.getSets() ,
            reps: exercise.getReps() ,
          ));
        }
      }
    }

    setState(() {
      isInitializated = true;
    });
  }

  Future<void> _setSelectedRadioBtn(val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (val == 1) {
      selectedRadioBtn = 1;
      prefs.setBool("isFitness" , true);
      isFitness = true;
    }
    if (val == 2) {
      selectedRadioBtn = 2;
      prefs.setBool("isFitness" , false);
      isFitness = false;
    }
    _loadPages();
  }

  void _updateRepsAndSets(int savedRadioButtonSelected) {
    if (savedRadioButtonSelected == 1) {
      for (int i = 0; i < allExercises.length; i++) {
        allExercises[i].setSets("3-4");
        allExercises[i].setReps("8-12");
      }
    }

    if (savedRadioButtonSelected == 2) {
      for (int i = 0; i < allExercises.length; i++) {
        allExercises[i].setSets("3-4");
        allExercises[i].setReps("5-8");
      }
    }
  }

  Future<void> _initData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt("spinnerIndex").toString() != "null") {
      StaticValues.exerciseSpinnerIndex = prefs.getInt("spinnerIndex");
    }
    if (prefs.getBool("isFitness").toString() != "null") {
      isFitness = prefs.getBool("isFitness");
    }
  }
}
