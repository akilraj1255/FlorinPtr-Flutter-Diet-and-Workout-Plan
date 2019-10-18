


 class Mancare {

   int id;
   bool isLocked;
   bool isFavorite;
   String nume;
   String descriere;
   String cantitati;
   String poza;
   int categoria;
   int calorii;
   int proteina;
   int carbo;
   int fibers;
   int grasimi;
   String tags;


   Mancare(int id, bool isLocked, bool isFavorite,
       String nume, String descriere, String cantitati, String poza, int categoria, int calorii, int proteina, int carbo, int fibers, int grasimi, String tags) {
    this.id = id;
    this.isLocked = isLocked;
    this.isFavorite = isFavorite;
    this.nume = nume;
    this.descriere = descriere;
    this.cantitati = cantitati;
    this.poza = poza;
    this.categoria = categoria;
    this.calorii = calorii;
    this.proteina = proteina;
    this.carbo = carbo;
    this.fibers = fibers;
    this.grasimi = grasimi;
    this.tags = tags;
  }


   int getId() {
    return id;
  }

   void setId(int id) {
    this.id = id;
  }

    bool isLockedFood() {
    return isLocked;
  }

   void setLocked(bool locked) {
    isLocked = locked;
  }

   bool isFavoriteFood() {
    return isFavorite;
  }

   void setFavorite(bool favorite) {
    isFavorite = favorite;
  }

   String getNume() {
    return nume;
  }

   void setNume(String nume) {
    this.nume = nume;
  }

   String getDescriere() {
    return descriere;
  }

   void setDescriere(String descriere) {
    this.descriere = descriere;
  }

   String getCantitati() {
    return cantitati;
  }

   void setCantitati(String cantitati) {
    this.cantitati = cantitati;
  }

   String getPoza() {
    return poza;
  }

   void setPoza(String poza) {
    this.poza = poza;
  }

   int getCategoria() {
    return categoria;
  }

   void setCategoria(int categoria) {
    this.categoria = categoria;
  }

   int getCalorii() {
    return calorii;
  }

   void setCalorii(int calorii) {
    this.calorii = calorii;
  }

   int getProteina() {
    return proteina;
  }

   void setProteina(int proteina) {
    this.proteina = proteina;
  }

   int getCarbo() {
    return carbo;
  }

   void setCarbo(int carbo) {
    this.carbo = carbo;
  }

   int getFibers() {
    return fibers;
  }

   void setFibers(int fibers) {
    this.fibers = fibers;
  }

   int getGrasimi() {
    return grasimi;
  }

   void setGrasimi(int grasimi) {
    this.grasimi = grasimi;
  }

   String getTags() {
    return tags;
  }

   void setTags(String tags) {
    this.tags = tags;
  }

}
