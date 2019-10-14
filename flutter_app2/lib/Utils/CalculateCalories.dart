
import 'package:flutter_app/Utils/Person.dart';

class CalculateCalories  {

   int NrCalorii;
  Person person;

    CalculateCalories(Person person) {

    this.person = person;

  }

   int Calculate(){
    if (person.getGender() == 1) {

      int bmr = ((person.getHeight() * 6.25) + (person.getCurrentWeight() * 9.99)
          - (person.getAge() * 4.92) - 161).round();

      if (person.getActivityIntensity()==1) {
        NrCalorii = ((bmr * 1.2) +
            (person.getTrainPerWeek() * 50)).round();
      }
      if (person.getActivityIntensity()==2) {
        NrCalorii =  (bmr * 1.4 +
            (person.getTrainPerWeek() * 50)).round();
      }
     if (person.getActivityIntensity()==3) {
        NrCalorii = (bmr * 1.7 +
            (person.getTrainPerWeek() * 50)).round();
      }
      if (person.getActivityIntensity()==4) {
        NrCalorii = (bmr * 1.9 +
            (person.getTrainPerWeek() * 50)).round();
      }


    }

    if (person.getGender() == 2) {

    int bmr =  ((person.getHeight() * 6.25) + (person.getCurrentWeight() * 9.99)
    - (person.getAge() * 4.92) + 5).round();

    if (person.getActivityIntensity()==1) {
    NrCalorii = ((bmr * 1.2) +
    (person.getTrainPerWeek() * 50)).round();
    }
    if (person.getActivityIntensity()==2) {
    NrCalorii = (bmr * 1.4 +
    (person.getTrainPerWeek() * 50) ).round();
    }
    if (person.getActivityIntensity()==3) {
    NrCalorii = (bmr * 1.7 +
    (person.getTrainPerWeek() * 50)).round();
    }
    if (person.getActivityIntensity()==4) {
      NrCalorii = (bmr * 1.9 +
          (person.getTrainPerWeek() * 50)).round();
    }
    }

    if (person.getProcessSpeed() == 2){
    if (person.getCurrentWeight()>person.getGoalWeight()) {
    NrCalorii = (NrCalorii - (NrCalorii / 5)).round();
    }
    if (person.getCurrentWeight()<person.getGoalWeight()){
    NrCalorii = (NrCalorii + (NrCalorii / 5)).round();
    }
    }

    if (person.getProcessSpeed() == 1){
    if (person.getCurrentWeight()>person.getGoalWeight()) {
    NrCalorii = (NrCalorii - (NrCalorii / 8)).round();
    }
    if (person.getCurrentWeight()<person.getGoalWeight()){
    NrCalorii = (NrCalorii + (NrCalorii / 8)).round();
    }
    }

    return NrCalorii;
  }
  int CalculateBMR(){
    int bmr = 0;
    if (person.getGender() == 1) {

      bmr = ((person.getHeight() * 6.25) + (person.getCurrentWeight() * 9.99)
          - (person.getAge() * 4.92) - 161).round();
    }

    if (person.getGender() == 2) {

      bmr =  ((person.getHeight() * 6.25) + (person.getCurrentWeight() * 9.99)
          - (person.getAge() * 4.92) + 5).round();
    }

    return bmr;
  }
}
