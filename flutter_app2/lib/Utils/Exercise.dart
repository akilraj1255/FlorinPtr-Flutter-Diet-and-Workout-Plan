
 class Exercise {

   String id;
   bool isLocked;
   String name;
   String category;
   String poza;
   String sets;
   String reps;
   String link;

   Exercise({String id, bool isLocked, String name, String category, String poza,
       String sets, String reps, String link}) {

    this.id = id;
    this.isLocked = isLocked;
    this.name = name;
    this.category = category;
    this.poza = poza;
    this.sets = sets;
    this.reps = reps;
    this.link = link;
  }


   String getId() {
    return id;
  }

   void setId(String id) {
    this.id = id;
  }

  bool isLockedExercise(){
    return isLocked;
  }

   void setLocked(bool isLocked) {
    isLocked = isLocked;
  }

   String getName() {
    return name;
  }

   void setName(String name) {
    this.name = name;
  }

   String getCategory() {
    return category;
  }

   void setCategory(String category) {
    this.category = category;
  }

   String getPoza() {
    return poza;
  }

   void setPoza(String poza) {
    this.poza = poza;
  }

   String getSets() {
    return sets;
  }

   void setSets(String sets) {
    this.sets = sets;
  }

   String getReps() {
    return reps;
  }

   void setReps(String reps) {
    this.reps = reps;
  }

   String getLink() {
     return link;
   }

   void setLink(String link) {
     this.link = link;
   }

}
