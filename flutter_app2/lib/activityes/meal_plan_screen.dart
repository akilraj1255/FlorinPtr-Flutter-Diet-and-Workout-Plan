import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_app/Utils/Mancare.dart';
import 'package:flutter_app/Utils/Person.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter_app/Utils/static_values.dart';
import 'package:flutter_app/Utils/widgets/custom_food_card.dart';
import 'package:flutter_app/Utils/widgets/my_small_rised_button.dart';
import 'package:flutter_app/activityes/settings_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'food_details.dart';
import 'grocery_lists_activity.dart';

class MealPlanScreen extends StatefulWidget {
  @override
  MealPlanScreenState createState() {
    return MealPlanScreenState();
  }
}

class MealPlanScreenState extends State<MealPlanScreen> {
  Person person;
  int necesarcaloric = 0;
  int micDejunGrame = 1 ,
      gustareUnuGrame = 1 ,
      pranzGrame = 1 ,
      gustareDoiGrame = 1 ,
      cinaGrame = 1;

  Swiper recyclerMicDejun;
  Swiper recyclerPranz;
  Swiper recyclerCina;
  Swiper recyclerGustareUnu;
  Swiper recyclerGustaredoi;

  List<Mancare> micDejunList = new List();
  List<Mancare> gustareUnuList = new List();
  List<Mancare> pranzList = new List();
  List<Mancare> gustareDoiList = new List();
  List<Mancare> cinaList = new List();
  List<Mancare> allFoods = new List();
  double micDejunCalo , gustareUnuCalo , pranzCalo , gustareDoiCalo , cinaCalo;
  double micDejunProt , gustareUnuProt , pranzProt , gustareDoiProt , cinaProt;
  double micDejunCarbo , gustareUnuCarbo , pranzCarbo , gustareDoiCarbo ,
      cinaCarbo;
  double micDejunFats , gustareUnuFats , pranzFats , gustareDoiFats , cinaFats;
  bool isInitializated = false;
  List<Widget> _getPagesBreakfast = [];
  List<Widget> _getPagesFirstTasting = [];
  List<Widget> _getPagesLunch = [];
  List<Widget> _getPagesSecondTasting = [];
  List<Widget> _getPagesDinner = [];
  String _totalText = "Total ";
  String _proteinText = "Protein ";
  String _carbsText = "Carbs ";
  String _fatsText = "Fats ";


  void _updateTotalCalo() {
//    Animation animation = AnimationUtils.loadAnimation(getActivity(),
//        R.anim.bounce);
//    //    totalTextView.startAnimation(animation);
//    proteinTextView.startAnimation(animation);
//    carbsTextView.startAnimation(animation);
//    fatsTextView.startAnimation(animation);


    int totalProtein = (micDejunProt + gustareUnuProt + pranzProt +
        gustareDoiProt + cinaProt).round();
    int totalFats = (micDejunFats + gustareUnuFats + pranzFats +
        gustareDoiFats + cinaFats).round();
    int totalCarbs = (micDejunCarbo + gustareUnuCarbo + pranzCarbo +
        gustareDoiCarbo + cinaCarbo).round();
    int total = (micDejunCalo + gustareUnuCalo + pranzCalo + gustareDoiCalo +
        cinaCalo).round();

    _proteinText =
        AppLocalizations.of(context).translate("proteintxt") + " " +
            (totalProtein).toString();
    _carbsText = AppLocalizations.of(context).translate("carbstxt") + " " +
        (totalCarbs).toString();
    _fatsText = AppLocalizations.of(context).translate("fatstxt") + " " +
        totalFats.toString();
    _totalText =
        "Total: " + getConsumedFoods() + "/" + (total).toString() + " kcal";

  }

  void _loadPages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _getPagesBreakfast.clear();
    _getPagesFirstTasting.clear();
    _getPagesLunch.clear();
    _getPagesSecondTasting.clear();
    _getPagesDinner.clear();

    for (int i = 0; i < micDejunList.length; i++) {
      Mancare food = micDejunList[i];
      _getPagesBreakfast.add(new CustomFoodCard(
        updateParent: updateState() ,
        id: food.getId() ,
        cathegory: AppLocalizations.of(context).translate("mic_dejun") ,
        position: (i + 1).toString() + "/" +
            micDejunList.length.toString() ,
        foodName: food.getNume() ,
        isFavorite: prefs.getBool(food.id.toString() + "isfav") ?? false ,
        assetPath: food.getPoza() ,
        grams: _calculateMeals(
            food , StaticValues.micDejunCaloriesFromAllCalories)
            .toString() ,
      ));
    }
    for (int i = 0; i < gustareUnuList.length; i++) {
      Mancare food = gustareUnuList[i];
      _getPagesFirstTasting.add(new CustomFoodCard(
        updateParent: updateState() ,
        id: food.getId() ,
        position: (i + 1).toString() + "/" +
            gustareUnuList.length.toString() ,
        cathegory: AppLocalizations.of(context).translate("prima_gustare") ,
        foodName: food.getNume() ,
        isFavorite: prefs.getBool(food.id.toString() + "isfav") ?? false ,
        assetPath: food.getPoza() ,
        grams: _calculateMeals(
            food , StaticValues.g1CaloriesFromAllCalories)
            .toString() ,
      ));
    }
    for (int i = 0; i < pranzList.length; i++) {
      Mancare food = pranzList[i];
      _getPagesLunch.add(new CustomFoodCard(
        updateParent: updateState() ,
        id: food.getId() ,
        cathegory: AppLocalizations.of(context).translate("pranz") ,
        position: (i + 1).toString() + "/" +
            pranzList.length.toString() ,
        foodName: food.getNume() ,
        isFavorite: prefs.getBool(food.id.toString() + "isfav") ?? false ,
        assetPath: food.getPoza() ,
        grams: _calculateMeals(
            food , StaticValues.pranzCaloriesFromAllCalories)
            .toString() ,
      ));
    }
    for (int i = 0; i < gustareDoiList.length; i++) {
      Mancare food = gustareDoiList[i];
      _getPagesSecondTasting.add(new CustomFoodCard(
        updateParent: updateState() ,
        id: food.getId() ,
        cathegory: AppLocalizations.of(context).translate("a_doua_gustare") ,
        position: (i + 1).toString() + "/" +
            gustareDoiList.length.toString() ,
        foodName: food.getNume() ,
        isFavorite: prefs.getBool(food.id.toString() + "isfav") ?? false ,
        assetPath: food.getPoza() ,
        grams: _calculateMeals(
            food , StaticValues.g2CaloriesFromAllCalories)
            .toString() ,
      ));
    }
    for (int i = 0; i < cinaList.length; i++) {
      Mancare food = cinaList[i];
      _getPagesDinner.add(new CustomFoodCard(
        updateParent: updateState() ,
        id: food.getId() ,
        cathegory: AppLocalizations.of(context).translate("cina") ,
        position: (i + 1).toString() + "/" +
            cinaList.length.toString() ,
        foodName: food.getNume() ,
        isFavorite: prefs.getBool(food.id.toString() + "isfav") ?? false ,
        assetPath: food.getPoza() ,
        grams: _calculateMeals(
            food , StaticValues.cinaCaloriesFromAllCalories)
            .toString() ,
      ));
    }

    if (!isInitializated) {
      setState(() {
        isInitializated = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getPersonInfo();

  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _loadFoods();
    _initialSetup();
  }

  @override
  Widget build(BuildContext context) {

    _loadPages();

    if (isInitializated) {
      return Scaffold(
        backgroundColor: MyTheme.customBackgrounColor ,
        bottomSheet: Container(height: 100.0 , color: MyTheme.themeColor ,
          child: Column(
            children: <Widget>[
              SizedBox(height: 7 ,) ,
              Container(height: StaticValues.isAddGroceryOpen ? 0 : 7 ,
                color: Colors.white ,
                child: Row(mainAxisAlignment: MainAxisAlignment.start ,
                  children: <Widget>[
                    Container(height: 6 ,
                        width: (MediaQuery
                            .of(context)
                            .size
                            .width * consumedFoodsPercentage()) / 100 ,
                        color: Colors.yellowAccent) ,
                  ] ,
                ) ,) ,
              Stack(children: <Widget>[
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width ,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 12.0) ,
                    child: Text(_totalText , textAlign: TextAlign.center ,
                      style: TextStyle(color: Colors.white ,
                          fontSize: 20.0 , fontWeight: FontWeight.w700) ,) ,
                  ) ,) ,
                Container(alignment: Alignment.topLeft ,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back , color: Colors.white ,) ,
                    onPressed: () {
                      Navigator.of(context).pop();
                    } ,) ,
                ) ,
                Container(alignment: Alignment.topRight ,
                  child: IconButton(
                    icon: Icon(Icons.settings , color: Colors.white ,) ,
                    onPressed: () {
                      Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                        return new SettingsScreen();
                      }));
                    } ,) ,
                ) ,
              ] ,) ,
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                children: <Widget>[
                  Row(children: <Widget>[
                    Icon(MdiIcons.egg , color: Colors.white ,) ,
                    Text(_proteinText , style: TextStyle(color: Colors.white) ,)
                  ] ,) ,
                  Row(children: <Widget>[
                    Icon(MdiIcons.foodAppleOutline , color: Colors.white ,
                      size: 26.0 ,) ,
                    Text(_carbsText , style: TextStyle(color: Colors.white) ,)
                  ] ,) ,
                  Row(children: <Widget>[
                    Container(height: 25.0 , width: 25.0 ,
                        child: Image(
                          image: AssetImage("assets/images/avocado_icon.png") ,
                          color: Colors.white ,)) ,
                    Text(_fatsText , style: TextStyle(color: Colors.white) ,)
                  ] ,)
                ] ,)
            ] ,
          ) ,) ,
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20.0 ,) ,
            Padding(
              padding: EdgeInsets.all(15.0) ,
              child: MySmallRaisedButton(
                  myIcon: Icon(MdiIcons.clipboardListOutline ,
                    color: Colors.black , size: 30 ,) ,
                  mytext: StaticValues.isAddGroceryOpen
                      ?
                  AppLocalizations.of(context).translate("close_meal_plan_mode")
                      :
                  AppLocalizations.of(context).translate("meal_plan_mode") ,
                  myGradient: MyTheme.myLinearGradient ,
                  myOnPressed: () {
                    StaticValues.isAddGroceryOpen ?
                    StaticValues.isAddGroceryOpen = false :
                    StaticValues.isAddGroceryOpen = true;
                    setState(() {});
                  }) ,
            ) ,
            Container(
                child: StaticValues.isAddGroceryOpen ? Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: <Widget>[
                    FloatingActionButton(child: Icon(Icons.shopping_basket) ,
                        onPressed: () {
                          Navigator.of(context).push(
                              new MaterialPageRoute(builder: (context) {
                                return new GroceryListsActivity();
                              }));
                        }) ,
                  ] ,
                ) : Container(height: 0.0 ,)
            ) ,
            SizedBox(height: 20 ,) ,
            Container(
              height: 162.0 ,
              //  color: Colors.red,
              constraints: BoxConstraints(
                  minWidth: MediaQuery
                      .of(context)
                      .size
                      .width * 0.9 ,
                  minHeight: 25.0) ,
              child: Swiper.children(
                onTap: (index) {
                  _openFoodDetails(
                      micDejunList[StaticValues.breakfastcurrentIndex]);
                } ,
                viewportFraction: 0.9 ,
                scale: 1 ,
                autoplay: false ,
                index: StaticValues.breakfastcurrentIndex ,
                loop: false ,
                reverse: true ,
                autoplayDisableOnInteraction: true ,
                onIndexChanged: (index) {
                  Mancare food = micDejunList[index];
                  micDejunGrame = _calculateMeals(
                      food , StaticValues.micDejunCaloriesFromAllCalories);
                  micDejunCalo = (food.getCalorii() * micDejunGrame) / 100;
                  micDejunProt = (food.getProteina() * micDejunGrame) / 100;
                  micDejunCarbo = (food.getCarbo() * micDejunGrame) / 100;
                  micDejunFats = (food.getGrasimi() * micDejunGrame) / 100;
                  StaticValues.breakfastcurrentIndex = index;
                  _updateTotalCalo();
                  setState(() {
                  });
                } ,
                pagination: null ,
                children: _getPagesBreakfast ,
              ) ,
            ) ,
            Column(
              children: <Widget>[
                SizedBox(height: 10.0 ,) ,
                Container(
                  height: 162.0 ,
                  //  color: Colors.yellow,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9 ,
                      minHeight: 25.0) ,
                  child: Swiper.children(
                    onTap: (index) {
                      _openFoodDetails(gustareUnuList[StaticValues
                          .firstTastingCurrentIndex]);
                    } ,
                    viewportFraction: 0.9 ,
                    scale: 1 ,
                    autoplay: false ,
                    index: StaticValues.firstTastingCurrentIndex ,
                    loop: false ,
                    autoplayDisableOnInteraction: true ,
                    onIndexChanged: (index) {
                      Mancare food = gustareUnuList[index];
                      gustareUnuGrame = _calculateMeals(
                          food , StaticValues.g1CaloriesFromAllCalories);
                      gustareUnuCalo =
                          (food.getCalorii() * gustareUnuGrame) / 100;
                      gustareUnuProt =
                          (food.getProteina() * gustareUnuGrame) / 100;
                      gustareUnuCarbo =
                          (food.getCarbo() * gustareUnuGrame) / 100;
                      gustareUnuFats =
                          (food.getGrasimi() * gustareUnuGrame) / 100;
                      StaticValues.firstTastingCurrentIndex = index;
                      _updateTotalCalo();
                      setState(() {

                      });
                    } ,
                    pagination: null ,
                    children: _getPagesFirstTasting ,
                  ) ,
                ) ,
              ] ,
            ) ,
            Column(
              children: <Widget>[
                SizedBox(height: 10.0 ,) ,
                Container(
                  height: 162.0 ,
                  //  color: Colors.blue,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9 ,
                      minHeight: 25.0) ,
                  child: Swiper.children(
                    onTap: (index) {
                      _openFoodDetails(
                          pranzList[StaticValues.lunchCurrentIndex]);
                    } ,
                    viewportFraction: 0.9 ,
                    scale: 1 ,
                    autoplay: false ,
                    index: StaticValues.lunchCurrentIndex ,
                    loop: false ,
                    autoplayDisableOnInteraction: true ,
                    onIndexChanged: (index) {
                      Mancare food = pranzList[index];
                      pranzGrame = _calculateMeals(
                          food , StaticValues.pranzCaloriesFromAllCalories);
                      pranzCalo = (food.getCalorii() * pranzGrame) / 100;
                      pranzProt = (food.getProteina() * pranzGrame) / 100;
                      pranzCarbo = (food.getCarbo() * pranzGrame) / 100;
                      pranzFats = (food.getGrasimi() * pranzGrame) / 100;
                      StaticValues.lunchCurrentIndex = index;
                      _updateTotalCalo();
                      setState(() {

                      });
                    } ,
                    pagination: null ,
                    children: _getPagesLunch ,
                  ) ,
                ) ,
              ] ,
            ) ,
            Column(
              children: <Widget>[
                SizedBox(height: 10.0 ,) ,
                Container(
                  height: 162.0 ,
                  //  color: Colors.green,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9 ,
                      minHeight: 25.0) ,
                  child: Swiper.children(
                    onTap: (index) {
                      _openFoodDetails(gustareDoiList[StaticValues
                          .secondTastingCurrentIndex]);
                    } ,
                    viewportFraction: 0.9 ,
                    scale: 1 ,
                    autoplay: false ,
                    index: StaticValues.secondTastingCurrentIndex ,
                    loop: false ,
                    autoplayDisableOnInteraction: true ,
                    onIndexChanged: (index) {
                      Mancare food = gustareDoiList[index];
                      gustareDoiGrame = _calculateMeals(
                          food , StaticValues.g2CaloriesFromAllCalories);
                      gustareDoiCalo =
                          (food.getCalorii() * gustareDoiGrame) / 100;
                      gustareDoiProt =
                          (food.getProteina() * gustareDoiGrame) / 100;
                      gustareDoiCarbo =
                          (food.getCarbo() * gustareDoiGrame) / 100;
                      gustareDoiFats =
                          (food.getGrasimi() * gustareDoiGrame) / 100;
                      StaticValues.secondTastingCurrentIndex = index;
                      _updateTotalCalo();
                      setState(() {

                      });
                    } ,
                    pagination: null ,
                    children: _getPagesSecondTasting ,
                  ) ,
                ) ,
              ] ,
            ) ,
            Column(
              children: <Widget>[
                SizedBox(height: 10.0 ,) ,
                Container(
                  height: 162.0 ,
                  //  color: Colors.orange,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width * 0.9 ,
                      minHeight: 25.0) ,
                  child: Swiper.children(
                    onTap: (index) {
                      _openFoodDetails(
                          cinaList[StaticValues.dinnerCurrentIndex]);
                    } ,
                    viewportFraction: 0.9 ,
                    scale: 1 ,
                    autoplay: false ,
                    index: StaticValues.dinnerCurrentIndex ,
                    loop: false ,
                    autoplayDisableOnInteraction: true ,
                    onIndexChanged: (index) {
                      Mancare food = cinaList[index];
                      cinaGrame = _calculateMeals(
                          food , StaticValues.cinaCaloriesFromAllCalories);
                      cinaCalo = (food.getCalorii() * cinaGrame) / 100;
                      cinaProt = (food.getProteina() * cinaGrame) / 100;
                      cinaCarbo = (food.getCarbo() * cinaGrame) / 100;
                      cinaFats = (food.getGrasimi() * cinaGrame) / 100;
                      StaticValues.dinnerCurrentIndex = index;
                      _updateTotalCalo();
                      setState(() {

                      });
                    } ,
                    pagination: null ,
                    children: _getPagesDinner ,
                  ) ,
                ) ,
              ] ,
            ) ,
            SizedBox(height: 110.0 ,)
          ] ,
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

  void _initialSetup() {
    Mancare food = micDejunList[0];
    micDejunGrame =
        _calculateMeals(food , StaticValues.micDejunCaloriesFromAllCalories);
    micDejunCalo = (food.getCalorii() * micDejunGrame) / 100;
    micDejunProt = (food.getProteina() * micDejunGrame) / 100;
    micDejunCarbo = (food.getCarbo() * micDejunGrame) / 100;
    micDejunFats = (food.getGrasimi() * micDejunGrame) / 100;

    Mancare foodg1 = gustareUnuList[0];
    gustareUnuGrame =
        _calculateMeals(foodg1 , StaticValues.g1CaloriesFromAllCalories);
    gustareUnuCalo = (foodg1.getCalorii() * gustareUnuGrame) / 100;
    gustareUnuProt = (foodg1.getProteina() * gustareUnuGrame) / 100;
    gustareUnuCarbo = (foodg1.getCarbo() * gustareUnuGrame) / 100;
    gustareUnuFats = (foodg1.getGrasimi() * gustareUnuGrame) / 100;

    Mancare food2 = pranzList[0];
    pranzGrame =
        _calculateMeals(food2 , StaticValues.pranzCaloriesFromAllCalories);
    pranzCalo = (food2.getCalorii() * pranzGrame) / 100;
    pranzProt = (food2.getProteina() * pranzGrame) / 100;
    pranzCarbo = (food2.getCarbo() * pranzGrame) / 100;
    pranzFats = (food2.getGrasimi() * pranzGrame) / 100;

    Mancare foodg2 = gustareDoiList[0];
    gustareDoiGrame =
        _calculateMeals(foodg2 , StaticValues.g2CaloriesFromAllCalories);
    gustareDoiCalo = (foodg2.getCalorii() * gustareDoiGrame) / 100;
    gustareDoiProt = (foodg2.getProteina() * gustareDoiGrame) / 100;
    gustareDoiCarbo = (foodg2.getCarbo() * gustareDoiGrame) / 100;
    gustareDoiFats = (foodg2.getGrasimi() * gustareDoiGrame) / 100;

    Mancare food3 = cinaList[0];
    cinaGrame =
        _calculateMeals(food3 , StaticValues.cinaCaloriesFromAllCalories);
    cinaCalo = (food3.getCalorii() * cinaGrame) / 100;
    cinaProt = (food3.getProteina() * cinaGrame) / 100;
    cinaCarbo = (food3.getCarbo() * cinaGrame) / 100;
    cinaFats = (food3.getGrasimi() * cinaGrame) / 100;

    setState(() {
      _updateTotalCalo();
    });
  }

  void _getPersonInfo() {
    person = StaticValues.person;
    necesarcaloric = person.getCaloriesNeeded();

    if (person.getCurrentWeight() < person.getGoalWeight()) {
      necesarcaloric = (necesarcaloric + (necesarcaloric / 20)).round();
    }
    if (person.getCurrentWeight() > person.getGoalWeight()) {
      necesarcaloric = (necesarcaloric - (necesarcaloric / 20)).round();
    }
    StaticValues.micDejunCaloriesFromAllCalories =
        ((necesarcaloric / 100) * StaticValues.percentageMicDejun).round();
    StaticValues.g1CaloriesFromAllCalories =
        ((necesarcaloric / 100) * StaticValues.percentageG1).round();
    StaticValues.pranzCaloriesFromAllCalories =
        ((necesarcaloric / 100) * StaticValues.percentagePranz).round();
    StaticValues.g2CaloriesFromAllCalories =
        ((necesarcaloric / 100) * StaticValues.percentageG2).round();
    StaticValues.cinaCaloriesFromAllCalories =
        ((necesarcaloric / 100) * StaticValues.percentageCina).round();
  }

  int _calculateMeals(Mancare food , int ratie) {
    int grams = ((ratie * 100) / food.getCalorii()).round();
    String mealgrams = grams.toString();

    int roundedMealGrams = 0;

    if (mealgrams.length == 4) {
      roundedMealGrams =
          int.parse((mealgrams.substring(0 , 3).toString() + "0"));
    }

    if (mealgrams.length == 3) {
      roundedMealGrams =
          int.parse((mealgrams.substring(0 , 2).toString() + "0"));
    }
    if (mealgrams.length == 2) {
      roundedMealGrams =
          int.parse((mealgrams.substring(0 , 1) + "0").toString());
    }
    return roundedMealGrams;
  }

  void _loadFoods() {
    micDejunList.clear();
    gustareUnuList.clear();
    pranzList.clear();
    gustareDoiList.clear();
    cinaList.clear();

    String fat_loss = "fat_loss ";
    String mass_gain = "mass_gain ";
    String weight_gain = "weight_gain ";
    String energy = "energy";
    String vegan = "vegan";

    var cantitati = new Map<String , int>();

    // mic dejun

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("iaurt_2") , () => 60);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("fulgi_ovaz") , () => 20);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("seminte") , () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("fructe_alegere") , () => 10);
    Mancare ovazIaurt = new Mancare(
        11 ,
        false ,
        false ,
        AppLocalizations.of(context).translate("iaurt_ovaz_seminte") ,
        AppLocalizations.of(context).translate("ovaz_iaurt_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/iaurt_ovaz.png" ,
        1 ,
        200 ,
        8 ,
        14 ,
        4 ,
        5 ,
        fat_loss + mass_gain + energy);
    micDejunList.add(ovazIaurt);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("chiken_eggs") , () => 50);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("whole_wheat") , () => 30);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("salata_verdeturi") , () => 20);
    Mancare omleta = new Mancare(
        12 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("omleta_verdeturi") ,
        "" ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/omleta.png" ,
        1 ,
        180 ,
        12 ,
        11 ,
        3 ,
        5 ,
        fat_loss + mass_gain);
    micDejunList.add(omleta);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("chiken_eggs") , () => 40);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("whole_wheat") , () => 30);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("avocado") , () => 30);
    Mancare ouaAvocado = new Mancare(
        13 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("oua_avocado_oaine") ,
        "" ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/eggs_avocado_whole_wheat.png" ,
        1 ,
        220 ,
        12 ,
        7 ,
        7 ,
        7 ,
        mass_gain + fat_loss);
    micDejunList.add(ouaAvocado);
    cantitati.clear();


    Mancare laptecereale = new Mancare(
        14 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("lapte_cereale") ,
        AppLocalizations.of(context).translate("lapte_cereale_descriere") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/laptecereale.png" ,
        1 ,
        190 ,
        8 ,
        15 ,
        3 ,
        4 ,
        mass_gain);
    micDejunList.add(laptecereale);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("fulgi_ovaz") , () => 20);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("chia_") , () => 15);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("fructe_alegere") , () => 65);
    Mancare terci = new Mancare(
        15 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("porridge_text") ,
        AppLocalizations.of(context).translate("terci_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/porridge.png" ,
        1 ,
        125 ,
        5 ,
        8 ,
        6 ,
        2 ,
        mass_gain);
    micDejunList.add(terci);
    cantitati.clear();

    Mancare clatite = new Mancare(
        16 ,
        true ,
        false
        ,
        AppLocalizations.of(context).translate("clatite") ,
        AppLocalizations.of(context).translate("clatite_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/pancakes.png" ,
        1 ,
        260 ,
        4 ,
        35 ,
        5 ,
        6 ,
        weight_gain);
    micDejunList.add(clatite);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("lapte_migdale") , () => 60);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("chia_") , () => 30);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("fructe_alegere") , () => 10);
    Mancare budincachia = new Mancare(
        17 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("budinca_chia") ,
        AppLocalizations.of(context).translate("budica_chia_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/budinca_chia.png" ,
        1 ,
        120 ,
        5 ,
        8 ,
        6 ,
        4 ,
        vegan + fat_loss);
    micDejunList.add(budincachia);
    cantitati.clear();


    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("chiken_eggs") , () => 50);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("broccoli_") , () => 35);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("sos_rosii") , () => 15);
    Mancare broccoli_omelet = new Mancare(
        18 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("oleta_broccoli_nume") ,
        "" ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/omleta_brocoli.png" ,
        1 ,
        120 ,
        10 ,
        10 ,
        2 ,
        3 ,
        fat_loss);
    micDejunList.add(broccoli_omelet);
    cantitati.clear();


    //gustare1

    Mancare fructe = new Mancare(
        21 ,
        false ,
        false ,
        AppLocalizations.of(context).translate("fructe_alegere") ,
        AppLocalizations.of(context).translate("fructe_poate_fi") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/fructe.png" ,
        2 ,
        62 ,
        1 ,
        11 ,
        2 ,
        0 ,
        energy);
    gustareUnuList.add(fructe);

    Mancare ciocoNeagra = new Mancare(
        22 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("cioco_neagra") ,
        AppLocalizations.of(context).translate("cioco_neagra_cacao_cantitate") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/dark_choco.png" ,
        2 ,
        600 ,
        9 ,
        31 ,
        2 ,
        43 ,
        weight_gain);
    gustareUnuList.add(ciocoNeagra);

    Mancare semintedovleac = new Mancare(
        23 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("seminte_dovleac") ,
        AppLocalizations.of(context).translate("seminte_dovleac_descriere") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/semintedovleac.png" ,
        2 ,
        540 ,
        27 ,
        10 ,
        3 ,
        45 ,
        vegan + mass_gain + fat_loss);
    gustareUnuList.add(semintedovleac);

    cantitati.putIfAbsent(AppLocalizations.of(context).translate(
        "lapte_sau_lapte_cocos") , () => 50);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("banana_") , () => 40);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("unt_arahide") , () => 10);
    Mancare shakeabananaunt = new Mancare(
        24 ,
        true ,
        false ,
        AppLocalizations.of(context).translate(
            "banana_and_peanut_butter_shake") ,
        AppLocalizations.of(context).translate("banana_shake_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/peanut_butter_banana_shake.png" ,
        2 ,
        160 ,
        7 ,
        18 ,
        1 ,
        7 ,
        mass_gain);
    gustareUnuList.add(shakeabananaunt);
    cantitati.clear();


    Mancare pepeneverde = new Mancare(
        25 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("pepene_verde") ,
        AppLocalizations.of(context).translate("pepene_verde_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/pepene_verde.png" ,
        2 ,
        30 ,
        1 ,
        6 ,
        1 ,
        2 ,
        fat_loss);
    gustareUnuList.add(pepeneverde);


    cantitati.clear();
    Mancare banana = new Mancare(
        26 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("banana_") ,
        AppLocalizations.of(context).translate("banana_txt") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/bnana.png" ,
        2 ,
        95 ,
        1 ,
        20 ,
        3 ,
        0 ,
        energy);
    gustareUnuList.add(banana);

    // pranz

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("linte") , () => 35);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("lapte_sau_lapte_cocos") ,
            () => 30);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("ceapa") , () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("usturoi") , () => 5);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_cartofi") , () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_smantana") , () => 10);
    Mancare supacrema_linte = new Mancare(
        31 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("supa_crema_linte") ,
        AppLocalizations.of(context).translate("supa_cremalinte_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/supacrema_linte.png" ,
        3 ,
        160 ,
        8 ,
        10 ,
        3 ,
        8 ,
        vegan + mass_gain + fat_loss);
    pranzList.add(supacrema_linte);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_cartofi") , () => 45);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_friptura") , () => 40);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("salata_") , () => 15);
    Mancare cartofiCeafa = new Mancare(
        32 ,
        false ,
        false ,
        AppLocalizations.of(context).translate("cartofi_fiert_pork_descriere") ,
        " " ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/cartofi_ceafa.png" ,
        3 ,
        180 ,
        10 ,
        18 ,
        2 ,
        5 ,
        energy + mass_gain);
    pranzList.add(cartofiCeafa);
    cantitati.clear();

    Mancare pizza = new Mancare(
        33 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("pizza") ,
        AppLocalizations.of(context).translate("pizza_txt") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/pizza.png" ,
        3 ,
        280 ,
        10 ,
        31 ,
        2 ,
        9 ,
        mass_gain + weight_gain);
    pranzList.add(pizza);
    cantitati.clear();


    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("paste_penne") , () => 25);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("piept_pui") , () => 50);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("sos_rosii") , () => 25);
    Mancare pastecupuipranz = new Mancare(
        34 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("paste_piept_pui") ,
        " " ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/patsecupui.png" ,
        3 ,
        230 ,
        9 ,
        19 ,
        3 ,
        3 ,
        weight_gain + mass_gain);
    pranzList.add(pastecupuipranz);
    cantitati.clear();


    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("carne_pui") , () => 50);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("orez_") , () => 15);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("ciuperci") , () => 15);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("salata_") , () => 20);
    Mancare puiOrezCiuperci = new Mancare(
        35 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("carne_pui_orez_ciuperci") ,
        " " ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/puicuorezsiciuperci.png" ,
        3 ,
        180 ,
        12 ,
        26 ,
        4 ,
        5 ,
        mass_gain + energy);
    pranzList.add(puiOrezCiuperci);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("drybeans") , () => 64);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("ceapa") , () => 30);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("usturoi") , () => 5);
    Mancare fasole_batuta = new Mancare(
        36 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("mashed_beans") ,
        AppLocalizations.of(context).translate("fasole_batuta_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/fasole_batuta.png" ,
        3 ,
        160 ,
        9 ,
        20 ,
        5 ,
        5 ,
        vegan + mass_gain + energy + fat_loss);
    pranzList.add(fasole_batuta);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("carne_vita") , () => 50);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("ciuperci") , () => 15);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("avocado") , () => 15);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("green_beans") , () => 20);
    Mancare vitaCiuperciAvocado = new Mancare(
        37 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("vita_ciuperci_avocado") ,
        " " ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/vitaciuperciavocado.png" ,
        3 ,
        210 ,
        13 ,
        21 ,
        4 ,
        7 ,
        mass_gain + fat_loss);
    pranzList.add(vitaCiuperciAvocado);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("orez_") , () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("piept_pui") , () => 50);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("salata_") , () => 40);
    Mancare orezCuPiept = new Mancare(
        38 ,
        false ,
        false ,
        AppLocalizations.of(context).translate("piept_de_pui_orez_descriere") ,
        " " ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/orezcupui.png" ,
        3 ,
        190 ,
        14 ,
        18 ,
        5 ,
        3 ,
        mass_gain + energy + fat_loss);
    pranzList.add(orezCuPiept);
    cantitati.clear();


    // gusttare2
    Mancare nuci = new Mancare(
        41 ,
        false ,
        false ,
        AppLocalizations.of(context).translate("nuci_alune") ,
        AppLocalizations.of(context).translate("nuci_alune_description") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/nuci.png" ,
        4 ,
        640 ,
        20 ,
        4 ,
        3 ,
        60 ,
        fat_loss + mass_gain);
    gustareDoiList.add(nuci);

    Mancare lapte = new Mancare(
        42 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("lapte") ,
        AppLocalizations.of(context).translate("lapte_descriere") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/milk.png" ,
        4 ,
        48 ,
        3 ,
        5 ,
        0 ,
        2 ,
        mass_gain);
    gustareDoiList.add(lapte);

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("faina_malai") , () => 20);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("branza") , () => 80);
    Mancare mamaligabranza = new Mancare(
        43 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("mamaligaBranza") ,
        " " ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/polenta.png" ,
        4 ,
        150 ,
        13 ,
        3 ,
        6 ,
        10 ,
        mass_gain);
    gustareDoiList.add(mamaligabranza);
    cantitati.clear();

    Mancare iaurt = new Mancare(
        44 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("iaurt") ,
        AppLocalizations.of(context).translate("iaurt_fructe") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/yogurt.png" ,
        4 ,
        52 ,
        3 ,
        4 ,
        0 ,
        2 ,
        fat_loss);
    gustareDoiList.add(iaurt);

    Mancare dovleac = new Mancare(
        45 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("dovleac_copt") ,
        AppLocalizations.of(context).translate("dovleac_descrieree") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/dovleac.png" ,
        4 ,
        28 ,
        1 ,
        3 ,
        3 ,
        1 ,
        fat_loss);
    gustareDoiList.add(dovleac);

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("whole_wheat") , () => 65);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("unt_arahide") , () => 15);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("banana_") , () => 20);
    Mancare peanutbutter_sandwich = new Mancare(
        46 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("penut_butter_sandwich") ,
        AppLocalizations.of(context).translate(
            "sandwich_peanutb_banana_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/tartina_unt_banana.png" ,
        4 ,
        200 ,
        7 ,
        24 ,
        3 ,
        8 ,
        weight_gain + energy);
    gustareDoiList.add(peanutbutter_sandwich);
    cantitati.clear();


    // cina

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("chiken_eggs") , () => 60);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("orez_brun") , () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("salata_verdeturi") , () => 30);
    Mancare orezbrun_omleta_salataVerde = new Mancare(
        51 ,
        false ,
        false ,
        AppLocalizations.of(context).translate("eggs_brown_rice_and_salad") ,
        " " ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/orezbrun_cuousi_salataverde.png" ,
        5 ,
        170 ,
        12 ,
        16 ,
        2 ,
        4 ,
        fat_loss + mass_gain);
    cinaList.add(orezbrun_omleta_salataVerde);
    cantitati.clear();


    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("carne_pui") , () => 45);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_cartofi") , () => 25);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("green_beans") , () => 20);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("ciuperci") , () => 10);
    Mancare puicuciupercicartofi = new Mancare(
        52 ,
        false ,
        false ,
        AppLocalizations.of(context).translate("pui_ciuperci_fasoleverde") ,
        "" ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/pui_cartofi_ciuperci_fasole_verde.png" ,
        5 ,
        180 ,
        13 ,
        34 ,
        2 ,
        6 ,
        mass_gain + fat_loss);
    cinaList.add(puicuciupercicartofi);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("file_ton") , () => 40);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("branza_slaba") , () => 20);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("legume_alegerea") , () => 20);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate(
        "crutoane_paine_integrala") , () => 15);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("masline") , () => 5);
    Mancare salataTon = new Mancare(
        53 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("salata_ton") ,
        "" ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/salata_ton.png" ,
        5 ,
        180 ,
        14 ,
        10 ,
        1 ,
        5 ,
        fat_loss + mass_gain);
    cinaList.add(salataTon);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("carne_peste") , () => 45);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("legume_alegerea") , () => 40);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("whole_wheat") , () => 15);
    Mancare pesteculegume = new Mancare(
        54 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("peste_legume") ,
        " " ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/peste_legume.png" ,
        5 ,
        150 ,
        10 ,
        10 ,
        2 ,
        3 ,
        fat_loss + mass_gain);
    cinaList.add(pesteculegume);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("spanac_proaspat") , () => 35);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate(
        "lapte_sau_lapte_cocos") , () => 30);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("ceapa") , () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("usturoi") , () => 5);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_cartofi") , () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_smantana") , () => 10);
    Mancare supacrema_spanac = new Mancare(
        55 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("supa_crema_spanac") ,
        AppLocalizations.of(context).translate("supa_crema_spanac_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/supacrema_spanac_laptecocos.png" ,
        5 ,
        160 ,
        8 ,
        10 ,
        3 ,
        8 ,
        vegan + mass_gain + fat_loss);
    cinaList.add(supacrema_spanac);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_friptura") , () => 45);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_cartofi") , () => 30);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("salata_verdeturi") , () => 25);
    Mancare porkPotatoes = new Mancare(
        56 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("friptura_cartofi_salata") ,
        "" ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/pork_potatoes_salad.png" ,
        5 ,
        170 ,
        12 ,
        13 ,
        3 ,
        6 ,
        mass_gain + energy);
    cinaList.add(porkPotatoes);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("whole_wheat") , () => 50);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("vinete") , () => 50);
    Mancare vinete = new Mancare(
        57 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("paine_vinete") ,
        "" ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/vinete.png" ,
        5 ,
        190 ,
        7 ,
        38 ,
        6 ,
        3 ,
        fat_loss + energy);
    cinaList.add(vinete);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("carne_pui") , () => 40);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("legume_alegerea") , () => 35);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate(
        "crutoane_paine_integrala") , () => 20);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("masline") , () => 5);
    Mancare puiCuSalata = new Mancare(
        58 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("legume_carne_pui_masline") ,
        " " ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/puicusalata.png" ,
        5 ,
        180 ,
        12 ,
        13 ,
        2 ,
        6 ,
        fat_loss + mass_gain);
    cinaList.add(puiCuSalata);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("somon") , () => 45);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_cartofi") , () => 35);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("asparagus") , () => 20);
    Mancare somon_asparagus = new Mancare(
        59 ,
        true ,
        false ,
        AppLocalizations.of(context).translate("somon_cu_sparanghel") ,
        AppLocalizations.of(context).translate("somon_descr") ,
        _getStringsFromHashMap(cantitati) ,
        "assets/images/salmon_potatoes_asparagus.png" ,
        5 ,
        190 ,
        12 ,
        14 ,
        3 ,
        7 ,
        fat_loss + mass_gain);
    cinaList.add(somon_asparagus);
    cantitati.clear();
  }

  String _getStringsFromHashMap(Map<String , int> cantitati) {
    String quantities = "";

    int counter = 0;
    while (counter < cantitati.length) {
      String key = cantitati.keys.toList()[counter];
      String value = cantitati.values.toList()[counter].toString();
      quantities += key + "=" + value;
      if (cantitati.length > counter) {
        quantities += ",";
        counter++;
      }
    }
    return quantities;
  }

  _openFoodDetails(Mancare mfood) {
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (context) {
          return new FoodDetailsScreen(mfood);
        })
    );
  }

  int consumedFoodsPercentage() {
    int output = 0;

    for (int x in StaticValues.consumedFoodsToday) {
      String foodCat = x.toString().substring(0 , 1);
      if (foodCat == "1") output += StaticValues.percentageMicDejun;
      if (foodCat == "2") output += StaticValues.percentageG1;
      if (foodCat == "3") output += StaticValues.percentagePranz;
      if (foodCat == "4") output += StaticValues.percentageG2;
      if (foodCat == "5") output += StaticValues.percentageCina;
    }

    return output;
  }

  updateState() {
     _updateTotalCalo();
     setState(() {});
  }
}


  String getConsumedFoods() {
  int output = 0;

  for(int x in StaticValues.consumedFoodsToday){
    String foodCat = x.toString().substring(0,1);
    if(foodCat == "1") {
      output += StaticValues.micDejunCaloriesFromAllCalories;
    }
    if(foodCat == "2") {
      output += StaticValues.g1CaloriesFromAllCalories;
    }
    if(foodCat == "3") {
      output += StaticValues.pranzCaloriesFromAllCalories;
    }
    if(foodCat == "4") {
      output += StaticValues.g2CaloriesFromAllCalories;
    }
    if(foodCat == "5") {
      output += StaticValues.cinaCaloriesFromAllCalories;
    }
  }

  return output.toString();
}
