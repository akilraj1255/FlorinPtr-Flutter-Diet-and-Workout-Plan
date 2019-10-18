import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/Mancare.dart';
import 'package:flutter_app/Utils/Person.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter_app/Utils/static_values.dart';
import 'package:flutter_app/Utils/widgets/custom_food_card.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MealPlanScreen extends StatefulWidget {
  @override
  MealPlanScreenState createState() {
    return MealPlanScreenState();
  }
}

class MealPlanScreenState extends State<MealPlanScreen> {
  Person person;
  int necesarcaloric = 0;
  int micDejunGrame = 1,
      gustareUnuGrame = 1,
      pranzGrame = 1,
      gustareDoiGrame = 1,
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
  double micDejunCalo, gustareUnuCalo, pranzCalo, gustareDoiCalo, cinaCalo;
  double micDejunProt, gustareUnuProt, pranzProt, gustareDoiProt, cinaProt;
  double micDejunCarbo, gustareUnuCarbo, pranzCarbo, gustareDoiCarbo, cinaCarbo;
  double micDejunFats, gustareUnuFats, pranzFats, gustareDoiFats, cinaFats;

  var _breakfastcurrentIndex = 0;
  var _dinnerCurrentIndex = 0;
  var _secondTastingCurrentIndex = 0;
  var _lunchCurrentIndex = 0;
  var _firstTastingCurrentIndex = 0;


  bool isInitializated = false;

  List<Widget> _getPagesBreakfast = [];
  List<Widget> _getPagesFirstTasting = [];
  List<Widget> _getPagesLunch = [];
  List<Widget> _getPagesSecondTasting = [];
  List<Widget> _getPagesDinner = [];



  void _loadPages() {

      for (int i = 0; i < micDejunList.length; i++) {
        Mancare food = micDejunList[i];
        _getPagesBreakfast.add(new CustomFoodCard(
          position: (i + 1).toString() + "/" +
              micDejunList.length.toString() ,
          foodName: food.getNume() ,
          isFavorite: food.isFavorite ,
          isAddGroceryOpen: true ,
          assetPath: food.getPoza() ,
          grams: _calculateMeals(
              food , StaticValues.micDejunCaloriesFromAllCalories)
              .toString() ,
        ));}
      for (int i = 0; i < gustareUnuList.length; i++) {
        Mancare food = gustareUnuList[i];
        _getPagesFirstTasting.add(new CustomFoodCard(
          position: (i + 1).toString() + "/" +
              gustareUnuList.length.toString() ,
          foodName: food.getNume() ,
          isFavorite: food.isFavorite ,
          isAddGroceryOpen: true ,
          assetPath: food.getPoza() ,
          grams: _calculateMeals(
              food , StaticValues.g1CaloriesFromAllCalories)
              .toString() ,
        ));}
      for (int i = 0; i < pranzList.length; i++) {
        Mancare food = pranzList[i];
        _getPagesLunch.add(new CustomFoodCard(
          position: (i + 1).toString() + "/" +
              pranzList.length.toString() ,
          foodName: food.getNume() ,
          isFavorite: food.isFavorite ,
          isAddGroceryOpen: true ,
          assetPath: food.getPoza() ,
          grams: _calculateMeals(
              food , StaticValues.pranzCaloriesFromAllCalories)
              .toString() ,
        ));}
      for (int i = 0; i < gustareDoiList.length; i++) {
        Mancare food = gustareDoiList[i];
        _getPagesSecondTasting.add(new CustomFoodCard(
          position: (i + 1).toString() + "/" +
              gustareDoiList.length.toString() ,
          foodName: food.getNume() ,
          isFavorite: food.isFavorite ,
          isAddGroceryOpen: true ,
          assetPath: food.getPoza() ,
          grams: _calculateMeals(
              food , StaticValues.g2CaloriesFromAllCalories)
              .toString() ,
        ));}
      for (int i = 0; i < cinaList.length; i++) {
        Mancare food = cinaList[i];
        _getPagesDinner.add(new CustomFoodCard(
          position: (i + 1).toString() + "/" +
              cinaList.length.toString() ,
          foodName: food.getNume() ,
          isFavorite: food.isFavorite ,
          isAddGroceryOpen: true ,
          assetPath: food.getPoza() ,
          grams: _calculateMeals(
              food , StaticValues.cinaCaloriesFromAllCalories)
              .toString() ,
        ));}

      setState(() {
        isInitializated = true;
      });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getPersonInfo();
    _loadFoods();
    _loadPages();

    if (isInitializated) {
      return Scaffold(
        backgroundColor: Color(0xFFC8E6C9),
        body: ListView(
          children: <Widget>[
            SizedBox(height: 20.0,),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(child: Text(AppLocalizations.of(context).translate("mic_dejun"),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 17.0, color: Colors.black54,
                            fontWeight: FontWeight.w700)),),),
                Container(
                  height: 160.0,
                //  color: Colors.red,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      minHeight: 25.0),
                  child: Swiper.children(
                    viewportFraction: 0.9,
                    scale: 1,
                    autoplay: false,
                    index: _breakfastcurrentIndex,
                    loop: false,
                    autoplayDisableOnInteraction: true,
                    onIndexChanged: (index) {},
                    pagination: null,
                    children: _getPagesBreakfast,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(child: Text(AppLocalizations.of(context).translate("prima_gustare"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17.0, color: Colors.black54,
                          fontWeight: FontWeight.w700)),),),
                Container(
                  height: 160.0,
                //  color: Colors.yellow,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      minHeight: 25.0),
                  child: Swiper.children(
                    viewportFraction: 0.9,
                    scale: 1,
                    autoplay: false,
                    index: _firstTastingCurrentIndex,
                    loop: false,
                    autoplayDisableOnInteraction: true,
                    onIndexChanged: (index) {},
                    pagination: null,
                    children: _getPagesFirstTasting,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(child: Text(AppLocalizations.of(context).translate("pranz"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17.0, color: Colors.black54,
                          fontWeight: FontWeight.w700)),),),
                Container(
                  height: 160.0,
                //  color: Colors.blue,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      minHeight: 25.0),
                  child: Swiper.children(
                    viewportFraction: 0.9,
                    scale: 1,
                    autoplay: false,
                    index: _lunchCurrentIndex,
                    loop: false,
                    autoplayDisableOnInteraction: true,
                    onIndexChanged: (index) {},
                    pagination: null,
                    children: _getPagesLunch,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(child: Text(AppLocalizations.of(context).translate("a_doua_gustare"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17.0, color: Colors.black54,
                          fontWeight: FontWeight.w700)),),),
                Container(
                  height: 160.0,
                //  color: Colors.green,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      minHeight: 25.0),
                  child: Swiper.children(
                    viewportFraction: 0.9,
                    scale: 1,
                    autoplay: false,
                    index: _secondTastingCurrentIndex,
                    loop: false,
                    autoplayDisableOnInteraction: true,
                    onIndexChanged: (index) {},
                    pagination: null,
                    children: _getPagesSecondTasting,
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(child: Text(AppLocalizations.of(context).translate("cina"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17.0, color: Colors.black54,
                          fontWeight: FontWeight.w700)),),),
                Container(
                  height: 160.0,
                //  color: Colors.orange,
                  constraints: BoxConstraints(
                      minWidth: MediaQuery.of(context).size.width * 0.9,
                      minHeight: 25.0),
                  child: Swiper.children(
                    viewportFraction: 0.9,
                    scale: 1,
                    autoplay: false,
                    index: _dinnerCurrentIndex,
                    loop: false,
                    autoplayDisableOnInteraction: true,
                    onIndexChanged: (index) {},
                    pagination: null,
                    children: _getPagesDinner,
                  ),
                ),
              ],
            ),
          ],
        ),
      );

    } else {
      return Scaffold(
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

  int _calculateMeals(Mancare food, int ratie) {
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

    var cantitati = new Map<String, int>();

    // mic dejun

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("iaurt_2"), () => 60);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("fulgi_ovaz"), () => 20);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("seminte"), () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("fructe_alegere"), () => 10);
    Mancare ovazIaurt = new Mancare(
        11,
        false,
        false,
        AppLocalizations.of(context).translate("iaurt_ovaz_seminte"),
        AppLocalizations.of(context).translate("ovaz_iaurt_descr"),
        GetStringsFromHashMap(cantitati),
        "assets/images/iaurt_ovaz.png", 1, 200, 8, 14, 4, 5,
        fat_loss + mass_gain + energy);
    micDejunList.add(ovazIaurt);
    cantitati.clear();

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("chiken_eggs"), () => 50);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("whole_wheat"), () => 30);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("salata_verdeturi"), () => 20);
    Mancare omleta = new Mancare(12, true, false,
        AppLocalizations.of(context).translate("omleta_verdeturi"), "",
        GetStringsFromHashMap(cantitati),
        "assets/images/omleta.png", 1, 180, 12, 11, 3, 5,
        fat_loss + mass_gain);
    micDejunList.add(omleta);
    cantitati.clear();

    cantitati.putIfAbsent( AppLocalizations.of(context).translate("chiken_eggs"), ()=> 40);
    cantitati.putIfAbsent( AppLocalizations.of(context).translate("whole_wheat"),()=> 30);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("avocado"),()=> 30);
    Mancare ouaAvocado = new Mancare(13,true,false,
        AppLocalizations.of(context).translate("oua_avocado_oaine"),
        "",
        GetStringsFromHashMap(cantitati),"assets/images/eggs_avocado_whole_wheat.png",
        1,220, 12, 7, 7,7, mass_gain+fat_loss);
    micDejunList.add(ouaAvocado);
    cantitati.clear();


    Mancare laptecereale = new Mancare(14,true,false,
        AppLocalizations.of(context).translate("lapte_cereale"),
        AppLocalizations.of(context).translate("lapte_cereale_descriere"),
        GetStringsFromHashMap(cantitati),
        "assets/images/laptecereale.png", 1,190, 8, 15, 3,4, mass_gain);
    micDejunList.add(laptecereale);
    cantitati.clear();

    cantitati.putIfAbsent( AppLocalizations.of(context).translate("fulgi_ovaz"), ()=>20);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("chia_"),()=> 15);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("fructe_alegere"), ()=>65);
    Mancare terci = new Mancare(15,true,false,
        AppLocalizations.of(context).translate("porridge_text"),
        AppLocalizations.of(context).translate("terci_descr"),
        GetStringsFromHashMap(cantitati),"assets/images/porridge.png",
        1,125, 5, 8, 6, 2, mass_gain);
    micDejunList.add(terci);
    cantitati.clear();

    Mancare clatite = new Mancare(16,true,false
        ,AppLocalizations.of(context).translate("clatite"),
        AppLocalizations.of(context).translate("clatite_descr"),
        GetStringsFromHashMap(cantitati),"assets/images/pancakes.png", 1,260, 4, 35, 5,6, weight_gain);
    micDejunList.add(clatite);
    cantitati.clear();

    cantitati.putIfAbsent( AppLocalizations.of(context).translate("lapte_migdale"),()=> 60);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("chia_"),()=> 30);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("fructe_alegere"),()=> 10);
    Mancare budincachia = new Mancare(17,true,false,
        AppLocalizations.of(context).translate("budinca_chia"),
        AppLocalizations.of(context).translate("budica_chia_descr"),
        GetStringsFromHashMap(cantitati),"assets/images/budinca_chia.png",
        1,120, 5, 8, 6, 4, vegan + fat_loss);
    micDejunList.add(budincachia);
    cantitati.clear();


    cantitati.putIfAbsent( AppLocalizations.of(context).translate("chiken_eggs"),()=> 50);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("broccoli_"),()=> 35);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("sos_rosii"),()=> 15);
    Mancare broccoli_omelet = new Mancare(18,true,false,
        AppLocalizations.of(context).translate("oleta_broccoli_nume"), "",
        GetStringsFromHashMap(cantitati), "assets/images/omleta_brocoli.png",
        1,120, 10, 10, 2, 3, fat_loss);
    micDejunList.add(broccoli_omelet);
    cantitati.clear();


    //gustare1

    Mancare fructe = new Mancare(
        21,
        false,
        false,
        AppLocalizations.of(context).translate("fructe_alegere"),
        AppLocalizations.of(context).translate("fructe_poate_fi"),
        GetStringsFromHashMap(cantitati),
        "assets/images/fructe.png", 2, 62, 1, 11, 2, 0,
        energy);
    gustareUnuList.add(fructe);

    Mancare ciocoNeagra = new Mancare(22,true,false,
        AppLocalizations.of(context).translate("cioco_neagra"),
        AppLocalizations.of(context).translate("cioco_neagra_cacao_cantitate"),
        GetStringsFromHashMap(cantitati), "assets/images/dark_choco.png", 2,600, 9, 31, 2, 43, weight_gain);
    gustareUnuList.add(ciocoNeagra);

    Mancare semintedovleac = new Mancare(23,true,false,
        AppLocalizations.of(context).translate("seminte_dovleac"),
        AppLocalizations.of(context).translate("seminte_dovleac_descriere"),
        GetStringsFromHashMap(cantitati), "assets/images/semintedovleac.png", 2,540, 27, 10, 3, 45,
        vegan + mass_gain+ fat_loss);
    gustareUnuList.add(semintedovleac);

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("lapte_sau_lapte_cocos"),()=> 50);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("banana_"),()=> 40);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("unt_arahide"),()=> 10);
    Mancare shakeabananaunt = new Mancare(24, true,false,
        AppLocalizations.of(context).translate("banana_and_peanut_butter_shake"),
        AppLocalizations.of(context).translate("banana_shake_descr"),
        GetStringsFromHashMap(cantitati), "assets/images/peanut_butter_banana_shake.png", 2,160, 7, 18, 1,  7, mass_gain);
    gustareUnuList.add(shakeabananaunt);
    cantitati.clear();


    Mancare pepeneverde = new Mancare(25, true,false,
        AppLocalizations.of(context).translate("pepene_verde"),
        AppLocalizations.of(context).translate("pepene_verde_descr"),
        GetStringsFromHashMap(cantitati), "assets/images/pepene_verde.png", 2,30, 1, 6, 1,  2, fat_loss);
    gustareUnuList.add(pepeneverde);


    cantitati.clear();
    Mancare banana = new Mancare(26,true,false,
        AppLocalizations.of(context).translate("banana_"),
        AppLocalizations.of(context).translate("banana_txt"),
        GetStringsFromHashMap(cantitati), "assets/images/bnana.png", 2,95, 1, 20, 3, 0, energy);
    gustareUnuList.add(banana);

    // pranz

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("linte"), () => 35);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("lapte_sau_lapte_cocos"),
        () => 30);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("ceapa"), () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("usturoi"), () => 5);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_cartofi"), () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("_smantana"), () => 10);
    Mancare supacrema_linte = new Mancare(31, true, false,
        AppLocalizations.of(context).translate("supa_crema_linte"),
        AppLocalizations.of(context).translate("supa_cremalinte_descr"),
        GetStringsFromHashMap(cantitati),
        "assets/images/supacrema_linte.png", 3, 160, 8, 10, 3, 8,
        vegan + mass_gain + fat_loss);
    pranzList.add(supacrema_linte);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("_cartofi"),()=> 45);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("_friptura"),()=> 40);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("salata_"),()=> 15);
    Mancare cartofiCeafa = new Mancare(32, false,false,AppLocalizations.of(context).translate("cartofi_fiert_pork_descriere"), " ",
        GetStringsFromHashMap(cantitati), "assets/images/cartofi_ceafa.png" , 3,180, 10, 18, 2, 5,
        energy+mass_gain);
    pranzList.add(cartofiCeafa);
    cantitati.clear();

    Mancare pizza = new Mancare(33, true,false, AppLocalizations.of(context).translate("pizza"),
        AppLocalizations.of(context).translate("pizza_txt"),
        GetStringsFromHashMap(cantitati),"assets/images/pizza.png" , 3,280, 10, 31, 2, 9,
        mass_gain+weight_gain);
    pranzList.add(pizza);
    cantitati.clear();



    cantitati.putIfAbsent(AppLocalizations.of(context).translate("paste_penne"),()=> 25);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("piept_pui"),()=> 50);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("sos_rosii"),()=> 25);
    Mancare pastecupuipranz = new Mancare(34, true,false,AppLocalizations.of(context).translate("paste_piept_pui"),
        " ",
        GetStringsFromHashMap(cantitati),"assets/images/patsecupui.png" , 3,230, 9, 19, 3, 3,
        weight_gain + mass_gain);
    pranzList.add(pastecupuipranz);
    cantitati.clear();


    cantitati.putIfAbsent(AppLocalizations.of(context).translate("carne_pui"),()=> 50);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("orez_"),()=> 15);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("ciuperci"),()=> 15);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("salata_"),()=> 20);
    Mancare puiOrezCiuperci = new Mancare(35, true,false,AppLocalizations.of(context).translate("carne_pui_orez_ciuperci"), " ",
        GetStringsFromHashMap(cantitati), "assets/images/puicuorezsiciuperci.png" , 3,180, 12, 26, 4, 5,
        mass_gain + energy);
    pranzList.add(puiOrezCiuperci);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("drybeans"), ()=>64);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("ceapa"),()=> 30);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("usturoi"),()=> 5);
    Mancare fasole_batuta = new Mancare(36, true,false, AppLocalizations.of(context).translate("mashed_beans"),
        AppLocalizations.of(context).translate("fasole_batuta_descr"),
        GetStringsFromHashMap(cantitati), "assets/images/fasole_batuta.png", 3,160, 9, 20, 5, 5,
        vegan + mass_gain + energy + fat_loss);
    pranzList.add(fasole_batuta);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("carne_vita"),()=> 50);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("ciuperci"),()=> 15);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("avocado"),()=> 15);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("green_beans"),()=> 20);
    Mancare vitaCiuperciAvocado = new Mancare(37,true,false,AppLocalizations.of(context).translate("vita_ciuperci_avocado"), " ",
        GetStringsFromHashMap(cantitati), "assets/images/vitaciuperciavocado.png" , 3,210, 13, 21, 4,  7,
        mass_gain+fat_loss);
    pranzList.add(vitaCiuperciAvocado);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("orez_"),()=> 10);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("piept_pui"),()=> 50);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("salata_"),()=> 40);
    Mancare orezCuPiept = new Mancare(38,false,false,AppLocalizations.of(context).translate("piept_de_pui_orez_descriere"), " ",
        GetStringsFromHashMap(cantitati), "assets/images/orezcupui.png" , 3,190, 14, 18, 5,  3,
        mass_gain + energy+fat_loss );
    pranzList.add(orezCuPiept);
    cantitati.clear();


    // gusttare2
    Mancare nuci = new Mancare(
        41,
        false,
        false,
        AppLocalizations.of(context).translate("nuci_alune"),
        AppLocalizations.of(context).translate("nuci_alune_description"),
        GetStringsFromHashMap(cantitati),
        "assets/images/nuci.png", 4, 640, 20, 4, 3, 60,
        fat_loss + mass_gain);
    gustareDoiList.add(nuci);

    Mancare lapte = new Mancare(42,true, false,AppLocalizations.of(context).translate("lapte"),
        AppLocalizations.of(context).translate("lapte_descriere"),
        GetStringsFromHashMap(cantitati), "assets/images/milk.png", 4,48, 3, 5, 0,2,
        mass_gain);
    gustareDoiList.add(lapte);

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("faina_malai"),()=> 20);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("branza"),()=> 80);
    Mancare mamaligabranza = new Mancare(43,true, false,AppLocalizations.of(context).translate("mamaligaBranza"),
        " ",
        GetStringsFromHashMap(cantitati), "assets/images/polenta.png", 4,150, 13, 3, 6, 10,
        mass_gain);
    gustareDoiList.add(mamaligabranza);
    cantitati.clear();

    Mancare iaurt = new Mancare(44, true,false,AppLocalizations.of(context).translate("iaurt"),
        AppLocalizations.of(context).translate("iaurt_fructe"),
        GetStringsFromHashMap(cantitati), "assets/images/yogurt.png", 4,52, 3, 4, 0, 2,
        fat_loss); gustareDoiList.add(iaurt);

    Mancare dovleac = new Mancare(45, true, false,AppLocalizations.of(context).translate("dovleac_copt"),
        AppLocalizations.of(context).translate("dovleac_descrieree"),
        GetStringsFromHashMap(cantitati), "assets/images/dovleac.png", 4, 28, 1, 3, 3, 1,
        fat_loss); gustareDoiList.add(dovleac);

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("whole_wheat"),()=> 65);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("unt_arahide"),()=> 15);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("banana_"),()=> 20);
    Mancare peanutbutter_sandwich = new Mancare(46, true, false,AppLocalizations.of(context).translate("penut_butter_sandwich"),
        AppLocalizations.of(context).translate("sandwich_peanutb_banana_descr"),
        GetStringsFromHashMap(cantitati), "assets/images/tartina_unt_banana.png", 4,200, 7, 24, 3, 8,
        weight_gain + energy);
    gustareDoiList.add(peanutbutter_sandwich);cantitati.clear();


    // cina

    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("chiken_eggs"), () => 60);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("orez_brun"), () => 10);
    cantitati.putIfAbsent(
        AppLocalizations.of(context).translate("salata_verdeturi"), () => 30);
    Mancare orezbrun_omleta_salataVerde = new Mancare(
        51,
        false,
        false,
        AppLocalizations.of(context).translate("eggs_brown_rice_and_salad"),
        " ",
        GetStringsFromHashMap(cantitati),
        "assets/images/orezbrun_cuousi_salataverde.png", 5, 170, 12, 16, 2, 4,
        fat_loss + mass_gain);
    cinaList.add(orezbrun_omleta_salataVerde);
    cantitati.clear();


    cantitati.putIfAbsent(AppLocalizations.of(context).translate("carne_pui"),()=> 45);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("_cartofi"),()=> 25);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("green_beans"),()=> 20);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("ciuperci"),()=> 10);
    Mancare puicuciupercicartofi = new Mancare(52, false,false,AppLocalizations.of(context).translate("pui_ciuperci_fasoleverde"),
        "",
        GetStringsFromHashMap(cantitati),"assets/images/pui_cartofi_ciuperci_fasole_verde.png" ,
        5,180, 13, 34, 2, 6 , mass_gain+ fat_loss);
    cinaList.add(puicuciupercicartofi);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("file_ton"),()=> 40);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("branza_slaba"),()=> 20);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("legume_alegerea"),()=> 20);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("crutoane_paine_integrala"),()=> 15);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("masline"),()=> 5);
    Mancare salataTon = new Mancare(53,true,false,AppLocalizations.of(context).translate("salata_ton"),
        "", GetStringsFromHashMap(cantitati),"assets/images/salata_ton.png" , 5,180, 14, 10, 1, 5,
        fat_loss+mass_gain);
    cinaList.add(salataTon);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("carne_peste"),()=> 45);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("legume_alegerea"),()=> 40);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("whole_wheat"),()=> 15);
    Mancare pesteculegume = new Mancare(54, true,false, AppLocalizations.of(context).translate("peste_legume"), " ",
        GetStringsFromHashMap(cantitati),"assets/images/peste_legume.png" , 5,150, 10, 10, 2, 3,
        fat_loss+ mass_gain);
    cinaList.add(pesteculegume);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("spanac_proaspat"),()=> 35);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("lapte_sau_lapte_cocos"),()=> 30);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("ceapa"),()=> 10);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("usturoi"),()=> 5);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("_cartofi"), ()=>10);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("_smantana"),()=> 10);
    Mancare supacrema_spanac = new Mancare(55,true,false,AppLocalizations.of(context).translate("supa_crema_spanac"),
        AppLocalizations.of(context).translate("supa_crema_spanac_descr"),
        GetStringsFromHashMap(cantitati),"assets/images/supacrema_spanac_laptecocos.png" , 5,160, 8, 10, 3, 8,
        vegan + mass_gain + fat_loss);
    cinaList.add(supacrema_spanac);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("_friptura"),()=> 45);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("_cartofi"),()=> 30);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("salata_verdeturi"),()=> 25);
    Mancare porkPotatoes = new Mancare(56,true,false,AppLocalizations.of(context).translate("friptura_cartofi_salata"), "",
        GetStringsFromHashMap(cantitati),"assets/images/pork_potatoes_salad.png" , 5,170, 12, 13, 3, 6,
        mass_gain+energy);
    cinaList.add(porkPotatoes);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("whole_wheat"),()=> 50);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("vinete"),()=> 50);
    Mancare vinete = new Mancare(57,true,false,AppLocalizations.of(context).translate("paine_vinete"),
        "",
        GetStringsFromHashMap(cantitati),"assets/images/vinete.png" , 5,190, 7, 38, 6, 3,
        fat_loss+energy);
    cinaList.add(vinete);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("carne_pui"),()=> 40);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("legume_alegerea"),()=> 35);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("crutoane_paine_integrala"),()=> 20);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("masline"),()=> 5);
    Mancare puiCuSalata = new Mancare(58,true,false, AppLocalizations.of(context).translate("legume_carne_pui_masline"), " ",
        GetStringsFromHashMap(cantitati),"assets/images/puicusalata.png" , 5,180, 12, 13, 2, 6,
        fat_loss+mass_gain);
    cinaList.add(puiCuSalata);
    cantitati.clear();

    cantitati.putIfAbsent(AppLocalizations.of(context).translate("somon"),()=> 45);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("_cartofi"),()=> 35);
    cantitati.putIfAbsent(AppLocalizations.of(context).translate("asparagus"),()=> 20);
    Mancare somon_asparagus = new Mancare(59,true,false, AppLocalizations.of(context).translate("somon_cu_sparanghel"),
        AppLocalizations.of(context).translate("somon_descr"),
        GetStringsFromHashMap(cantitati),"assets/images/salmon_potatoes_asparagus.png" ,
        5,190, 12, 14, 3, 7,
        fat_loss+mass_gain);
    cinaList.add(somon_asparagus);
    cantitati.clear();
  }

  String GetStringsFromHashMap(Map<String, int> cantitati) {
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
}
