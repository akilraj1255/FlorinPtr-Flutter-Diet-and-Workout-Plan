import 'package:flutter_app/Utils/Person.dart';

import 'Mancare.dart';

class StaticValues{

  static Person person;
  static bool isPremiumVersion = false;
   static bool isGroceryListOpen = false;
   static List <Mancare> FoodsInBasket = new List();
   static int micDejunCaloriesFromAllCalories;
   static int g1CaloriesFromAllCalories;
   static int pranzCaloriesFromAllCalories;
   static int g2CaloriesFromAllCalories;
   static int cinaCaloriesFromAllCalories;
   static int percentageMicDejun = 25;
   static int percentageG1 = 8;
   static int percentagePranz = 35;
   static int percentageG2 = 8;
   static int percentageCina = 24;
   static int breakfastcurrentIndex = 0;
   static int dinnerCurrentIndex = 0;
   static int secondTastingCurrentIndex = 0;
   static int lunchCurrentIndex = 0;
   static int firstTastingCurrentIndex = 0;

  static bool isBasketCleared;
  static bool uploadPhoto = false;

  static int exerciseSpinnerIndex = 0;

  static int exerciseSwiperIndex1 = 0;
  static int exerciseSwiperIndex2 = 0;
  static int exerciseSwiperIndex3 = 0;
  static int exerciseSwiperIndex4 = 0;
  static int exerciseSwiperIndex5 = 0;

  static bool isAddGroceryOpen = true;

  static List<int> consumedFoodsToday = new List();

}

