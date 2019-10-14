
import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';


 class Person {

   String id;
   String name;
   String email;
   String password;
   bool useImperial;
   int gender;
   int age;
   int currentWeight;
   int goalWeight;
   int height;
   int trainPerWeek;
   int activityDuration;
   int processSpeed;
   int activityIntensity;
   String createdDate;
   int bmr;
   int caloriesNeeded;
   String poza;


 //  Person(){}


   Person({this.id,this.name, this.email, this.password, this.useImperial,
      this.poza, this.gender, this.age, this.currentWeight, this.goalWeight, this.height,
       this.trainPerWeek, this.activityDuration, this.processSpeed, this.activityIntensity,
      this.createdDate, this.bmr, this.caloriesNeeded});

   String getId() {
    return id;
  }

   void setId(String id) {
    this.id = id;
  }

   String getName() {
    return name;
  }

   void setName(String name) {
    this.name = name;
  }

   String getEmail() {
    return email;
  }

   void setEmail(String email) {
    this.email = email;
  }

   String getPassword() {
    return password;
  }

   void setPassword(String password) {
    this.password = password;
  }

   bool isUseImperial() {
    return useImperial;
  }

   void setUseImperial(bool useImperial) {
    this.useImperial = useImperial;
  }

   String getPoza() {
    return poza;
  }

   void setPoza(String poza) {
    this.poza = poza;
  }

   int getGender() {
    return gender;
  }

   void setGender(int gender) {
    this.gender = gender;
  }

   int getAge() {
    return age;
  }

   void setAge(int age) {
    this.age = age;
  }

   int getCurrentWeight() {
    return currentWeight;
  }

   void setCurrentWeight(int currentWeight) {
    this.currentWeight = currentWeight;
  }

   int getGoalWeight() {
    return goalWeight;
  }

   void setGoalWeight(int goalWeight) {
    this.goalWeight = goalWeight;
  }

   int getHeight() {
    return height;
  }

   void setHeight(int height) {
    this.height = height;
  }

   int getTrainPerWeek() {
    return trainPerWeek;
  }

   void setTrainPerWeek(int trainPerWeek) {
    this.trainPerWeek = trainPerWeek;
  }

   int getActivityDurationl() {
    return activityDuration;
  }

   void setActivityDurationl(int activityDurationl) {
    this.activityDuration = activityDurationl;
  }

   int getProcessSpeed() {
    return processSpeed;
  }

   void setProcessSpeed(int processSpeed) {
    this.processSpeed = processSpeed;
  }

   int getActivityIntensity() {
    return activityIntensity;
  }

   void setActivityIntensity(int activityIntensity) {
    this.activityIntensity = activityIntensity;
  }

   String getCreatedDate() {
    return createdDate;
  }

   void setCreatedDate(String createdDate) {
    this.createdDate = createdDate;
  }

   int getBmr() {
    return bmr;
  }

   void setBmr(int bmr) {
    this.bmr = bmr;
  }

   int getCaloriesNeeded() {
    return caloriesNeeded;
  }

   void setCaloriesNeeded(int caloriesNeeded) {
    this.caloriesNeeded = caloriesNeeded;
  }



  Map<String, Object> toJson() {
   return {
    'userID': id,
    'firstName': name,
    'email': email == null ? '' : email,
    'gender': gender,
    'age': age,
    'currentWeight':currentWeight,
    'goalWeight':goalWeight,
    'height':height,
    'trainPerWeek':trainPerWeek,
    'activityDuration':activityDuration,
    'processSpeed':processSpeed,
    'activityIntensity':activityIntensity,
    'bmr':bmr,
    'caloriesNeeded':caloriesNeeded,

    'profilePictureURL': poza == null ? ' ': poza,
    'appIdentifier': 'flutter_Diet_and_Workout_Plan'
   };
  }

  factory Person.fromJson(Map<String, Object> doc) {
   Person user = new Person(
    id: doc['userID'],
    name: doc['firstName'],
    email: doc['email'],
    poza: doc['profilePictureURL'],
   );
   return user;
  }

   factory Person.fromDocument(DocumentSnapshot doc) {
     return Person.fromJson(doc.data);
   }

}
