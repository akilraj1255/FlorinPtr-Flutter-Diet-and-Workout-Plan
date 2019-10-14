import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Utils/CalculateCalories.dart';
import 'package:flutter_app/Utils/Person.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter_app/Utils/widgets/custom_alert_dialog.dart';
import 'package:flutter_app/Utils/widgets/custom_flat_button.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_app/activityes/mainScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';



class SetUserData extends StatefulWidget {
  Person person = new Person();

  SetUserData(Person user) {
    this.person = user;
    person.useImperial = false; // to modifi later
  }

  @override
  _SetUserDataState createState() {
    return new _SetUserDataState();
  }

}

class _SetUserDataState extends State<SetUserData> {
  TextEditingController _nameTextControl = new TextEditingController();
  TextEditingController _ageController = new TextEditingController();
  TextEditingController _heightController = new TextEditingController();
  TextEditingController _currentWeightController = new TextEditingController();
  TextEditingController _goalWeightController = new TextEditingController();
  VoidCallback onBackPress;
  bool _blackVisible = false;
  bool manpressAttention = false;
  bool womanpressAttention = false;
  bool isImperial = false;
  bool notReallyActive = false;
  bool prettyActive = false;
  bool veryActive = false;
  bool extremeActive = false;
  bool zeroTrainings = false;
  bool twoTrainings = false;
  bool threeTrainings = false;
  bool fourTrainings = false;
  bool fiveTrainings = false;
  String _userGoal = " ";
  int selectedRadioBtn = 0;
  String radio1Text = " ";
  String radio2Text = " ";
  String _goalSelectionText = " ";
  String _noteText = " ";

  bool isWeightLossGoal = false;
  bool isGainGoal = false;
  bool isMantainWeightGoal = false;

  int _currentIndex = 0;
  int lastKnownIndex = 0;

  _SetUserDataState();

  @override
  void initState() {
    super.initState();
    _nameTextControl.text = widget.person.getName();
    onBackPress = () {
      Navigator.of(context).pop();
    };
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Info") ,
        centerTitle: true ,
        elevation: 15.0
      ) ,
      body: new Swiper.children(
        autoplay: false ,
        index: _currentIndex ,

        loop: true ,
        //    physics: NeverScrollableScrollPhysics() ,
        autoplayDisableOnInteraction: true ,
        onIndexChanged: (index) {
          _checkForCompletition(index);
        } ,
        pagination: new SwiperPagination(
          alignment: Alignment.topCenter ,
          margin: new EdgeInsets.all(10.0) ,
          builder: new DotSwiperPaginationBuilder(
              color: Colors.grey ,
              activeColor: Colors.green ,
              size: 8.0 ,
              activeSize: 12.0) ,
        ) ,
        control:
        SwiperControl(
            padding: EdgeInsets.only(top: 10.0) ,
            iconPrevious: Icons.arrow_back_ios,
            iconNext: Icons.arrow_forward_ios,
        ) ,
        children: _getPages(context) ,
      )
    );
  }

  List<Widget> _getPages(BuildContext context) {
    List<Widget> widgets = [];

    widgets.add(
      Container(
        padding: EdgeInsets.all(30) ,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center ,
              children: <Widget>[
                SizedBox(
                  height: 30 ,
                ) ,
//                Text("In order to set your custom meal plan we need some info ",
//                    textAlign: TextAlign.center,
//                    style: TextStyle(color: Colors.black, fontSize: 18.0)),
                SizedBox(
                  height: 30.0 ,
                ) ,
                Card(
                  elevation: 0.0 ,
                  color: Colors.white ,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.green , width: 2.0) ,
                    borderRadius: BorderRadius.circular(20.0) ,
                  ) ,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0) ,
                    child: Stack(
                      children: <Widget>[
                        Icon(Icons.person , size: 40.0) ,
                        TextField(
                          decoration: InputDecoration(
                            //Add th Hint text here.
                            hintText: AppLocalizations.of(context)
                                .translate("numele") ,
                          ) ,
                          controller: _nameTextControl ,
                          textAlign: TextAlign.center ,
                        ) ,
                      ] ,
                    ) ,
                  ) ,
                ) ,
                SizedBox(
                  height: 30.0 ,
                ) ,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0) ,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                    children: <Widget>[
                      Container(
                        child: RaisedButton(
                          elevation: 15.0 ,
                          color:
                          manpressAttention ? Colors.green : Colors.white ,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)) ,
                          onPressed: () =>
                              setState(() {
                                manpressAttention = true;
                                womanpressAttention = false;
                              }) ,
                          child: Column(
                            children: <Widget>[
                              Icon(MdiIcons.genderMale ,
                                  size: 35.0 ,
                                  color: manpressAttention
                                      ? Colors.white
                                      : Colors.black) ,
                              Text(
                                  AppLocalizations.of(context)
                                      .translate("barbat") ,
                                  style: TextStyle(
                                      fontSize: 20 ,
                                      color: manpressAttention
                                          ? Colors.white
                                          : Colors.black)) ,
                            ] ,
                          ) ,
                          padding: EdgeInsets.symmetric(
                            vertical: 10.0 ,
                          ) ,
                          //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                        ) ,
                      ) ,
                      SizedBox(
                        width: 30.0 ,
                      ) ,
                      Container(
                        child: RaisedButton(
                          elevation: 15.0 ,
                          color:
                          womanpressAttention ? Colors.green : Colors.white ,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)) ,
                          onPressed: () =>
                              setState(() {
                                womanpressAttention = true;
                                manpressAttention = false;
                              }) ,
                          child: Column(
                            children: <Widget>[
                              Icon(
                                MdiIcons.genderFemale ,
                                size: 35.0 ,
                                color: womanpressAttention
                                    ? Colors.white
                                    : Colors.black ,
                              ) ,
                              Text(
                                  AppLocalizations.of(context)
                                      .translate("femeie") ,
                                  style: TextStyle(
                                      fontSize: 20 ,
                                      color: womanpressAttention
                                          ? Colors.white
                                          : Colors.black)) ,
                            ] ,
                          ) ,
                          padding: EdgeInsets.symmetric(vertical: 10.0) ,

                          //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                        ) ,
                      ) ,
                    ] ,
                  ) ,
                ) ,
                SizedBox(
                  height: 40.0 ,
                ) ,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center ,
                  children: <Widget>[
                    Text(AppLocalizations.of(context).translate("am") ,
                        style: TextStyle(
                            color: Colors.black , fontSize: 18.0)) ,
                    SizedBox(
                      width: 60.0 ,
                      child: Card(
                        elevation: 0.0 ,
                        color: Colors.white ,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.green , width: 2.0) ,
                          borderRadius: BorderRadius.circular(15.0) ,
                        ) ,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0) ,
                          child: TextField(
                            decoration: InputDecoration() ,
                            keyboardType: TextInputType.number ,
                            inputFormatters: [
                              WhitelistingTextInputFormatter.digitsOnly
                            ] ,
                            controller: _ageController ,
                            textAlign: TextAlign.center ,
                          ) ,
                        ) ,
                      ) ,
                    ) ,
                    Text(AppLocalizations.of(context).translate("ani") ,
                        style: TextStyle(
                            color: Colors.black , fontSize: 18.0)) ,
                  ] ,
                ) ,
//

                SizedBox(
                  height: 50.0 ,
                ) ,
              ] ,
            ) ,
          ] ,
        ) ,
      ) ,);

    widgets.add(
      Container(
        padding: EdgeInsets.all(50) ,
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 25.0 ,
            ) ,
            Column(
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).translate("inaltime") ,
                  style: TextStyle(fontSize: 16.0) ,
                ) ,

                Container(
                  width: 110 ,
                  child: Card(
                    color: Colors.white ,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green , width: 2.0) ,
                      borderRadius: BorderRadius.circular(20.0) ,
                    ) ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: <Widget>[
                        Icon(MdiIcons.humanMaleHeight , size: 30.0 ,
                            color: Colors.black) ,
                        SizedBox(
                          width: 55 ,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0) ,
                            child: TextField(
                              keyboardType: TextInputType.number ,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ] ,
                              decoration: InputDecoration(hintText: "cm" ,
                              ) ,
                              controller: _heightController ,
                              textAlign: TextAlign.center ,
                            ) ,
                          ) ,
                        ) ,

                      ] ,
                    ) ,


                  ) ,
                ) ,

                SizedBox(
                  height: 20.0 ,
                ) ,
                Divider(
                  height: 2.0 ,
                  thickness: 2.0 ,
                  color: Colors.green ,
                ) ,
                SizedBox(
                  height: 20.0 ,
                ) ,
                Text(
                  AppLocalizations.of(context)
                      .translate("greutatea_actuala") ,
                  style: TextStyle(fontSize: 16.0) ,
                ) , Container(
                  width: 110 ,
                  child: Card(
                    color: Colors.white ,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green , width: 2.0) ,
                      borderRadius: BorderRadius.circular(20.0) ,
                    ) ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: <Widget>[
                        Icon(MdiIcons.scaleBathroom , size: 30.0 ,
                            color: Colors.black) ,
                        SizedBox(
                          width: 55 ,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0) ,
                            child: TextField(
                              keyboardType: TextInputType.number ,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ] ,
                              decoration: InputDecoration(hintText: "kg" ,
                              ) ,
                              controller: _currentWeightController ,
                              textAlign: TextAlign.center ,
                            ) ,
                          ) ,
                        ) ,

                      ] ,
                    ) ,


                  ) ,
                ) ,

                SizedBox(
                  height: 20.0 ,
                ) ,
                Divider(
                  height: 2.0 ,
                  thickness: 2.0 ,
                  color: Colors.green ,
                ) ,
                SizedBox(
                  height: 20.0 ,
                ) ,

                Text(
                  AppLocalizations.of(context)
                      .translate("greutatea_pe_care_o_vreau") ,
                  style: TextStyle(fontSize: 16.0) ,
                ) , Container(
                  width: 110 ,
                  child: Card(
                    color: Colors.white ,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.green , width: 2.0) ,
                      borderRadius: BorderRadius.circular(20.0) ,
                    ) ,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center ,
                      children: <Widget>[
                        Icon(MdiIcons.scaleBathroom , size: 30.0 ,
                            color: Colors.black) ,
                        SizedBox(
                          width: 55 ,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0) ,
                            child: TextField(
                              keyboardType: TextInputType.number ,
                              inputFormatters: [
                                WhitelistingTextInputFormatter.digitsOnly
                              ] ,
                              decoration: InputDecoration(hintText: "kg" ,
                              ) ,
                              controller: _goalWeightController ,
                              textAlign: TextAlign.center ,
                            ) ,
                          ) ,
                        ) ,

                      ] ,
                    ) ,
                  ) ,
                ) ,

                SizedBox(
                  height: 20.0 ,
                ) ,
                Divider(
                  height: 2.0 ,
                  thickness: 2.0 ,
                  color: Colors.green ,
                ) ,
                SizedBox(height: 10.0) ,
              ] ,
            ) ,
          ] ,
        ) ,
      ) ,);

    widgets.add(Container(
      padding: EdgeInsets.all(20.0) ,
      child: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: <Widget>[
              SizedBox(
                height: 50 ,
              ) ,
              Text(
                  AppLocalizations.of(context)
                      .translate("cat_de_activa_este_viata_dvs") ,
                  textAlign: TextAlign.center ,
                  style: TextStyle(fontSize: 18.0)) ,
              SizedBox(
                height: 20 ,
              ) ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: <Widget>[
                    SizedBox(
                      width: 150.0 ,
                      child: RaisedButton(
                        elevation: 15.0 ,
                        color: notReallyActive ? Colors.green : Colors.white ,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)) ,
                        onPressed: () =>
                            setState(() {
                              notReallyActive = true;
                              prettyActive = false;
                              veryActive = false;
                              extremeActive = false;
                              widget.person.setActivityIntensity(1);
                            }) ,
                        child: Text(
                            AppLocalizations.of(context)
                                .translate("nu_prea_activa") ,
                            style: TextStyle(
                                fontSize: 16 ,
                                color: notReallyActive
                                    ? Colors.white
                                    : Colors.black)) ,
                        padding: EdgeInsets.symmetric(vertical: 8) ,
                        //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                      ) ,
                    ) ,
                    SizedBox(
                      width: 5.0 ,
                    ) ,
                    SizedBox(
                        width: 150.0 ,
                        child: RaisedButton(
                          elevation: 15.0 ,
                          color: prettyActive ? Colors.green : Colors.white ,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)) ,
                          onPressed: () =>
                              setState(() {
                                notReallyActive = false;
                                prettyActive = true;
                                veryActive = false;
                                extremeActive = false;
                                widget.person.setActivityIntensity(2);

                              }) ,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("destul_de_activa") ,
                              style: TextStyle(
                                  fontSize: 16 ,
                                  color: prettyActive
                                      ? Colors.white
                                      : Colors.black)) ,
                          padding: EdgeInsets.symmetric(vertical: 8) ,

                          //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                        ))
                  ] ,
                ) ,
              ) ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: <Widget>[
                    SizedBox(
                      width: 150.0 ,
                      child: RaisedButton(
                        elevation: 15.0 ,
                        color: veryActive ? Colors.green : Colors.white ,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)) ,
                        onPressed: () =>
                            setState(() {
                              notReallyActive = false;
                              prettyActive = false;
                              veryActive = true;
                              extremeActive = false;
                              widget.person.setActivityIntensity(3);

                            }) ,
                        child: Text(
                            AppLocalizations.of(context)
                                .translate("foarte_activa") ,
                            style: TextStyle(
                                fontSize: 16 ,
                                color:
                                veryActive ? Colors.white : Colors.black)) ,
                        padding: EdgeInsets.symmetric(vertical: 8) ,
                        //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                      ) ,
                    ) ,
                    SizedBox(
                      width: 5.0 ,
                    ) ,
                    SizedBox(
                        width: 150.0 ,
                        child: RaisedButton(
                          elevation: 15.0 ,
                          color: extremeActive ? Colors.green : Colors.white ,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)) ,
                          onPressed: () =>
                              setState(() {
                                notReallyActive = false;
                                prettyActive = false;
                                veryActive = false;
                                extremeActive = true;
                                widget.person.setActivityIntensity(4);
                              }) ,
                          child: Text(
                              AppLocalizations.of(context)
                                  .translate("extrem_de_activa") ,
                              style: TextStyle(
                                  fontSize: 16 ,
                                  color: extremeActive
                                      ? Colors.white
                                      : Colors.black)) ,
                          padding: EdgeInsets.symmetric(vertical: 8) ,

                          //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                        ))
                  ] ,
                ) ,
              ) ,
              SizedBox(
                height: 70.0 ,
              ) ,
              Text(
                  AppLocalizations.of(context)
                      .translate("antrenamente_saptamanale") ,
                  textAlign: TextAlign.center ,
                  style: TextStyle(fontSize: 18.0)) ,
              SizedBox(height: 30.0) ,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.0) ,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween ,
                  children: <Widget>[
                    SizedBox(
                      width: 50.0 ,
                      child: RaisedButton(
                        elevation: 15.0 ,
                        color: zeroTrainings ? Colors.green : Colors.white ,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)) ,
                        onPressed: () =>
                            setState(() {
                              zeroTrainings = true;
                              twoTrainings = false;
                              threeTrainings = false;
                              fourTrainings = false;
                              fiveTrainings = false;
                              widget.person.setTrainPerWeek(0);
                            }) ,
                        child: Text("0" ,
                            style: TextStyle(
                                fontSize: 16 ,
                                color: zeroTrainings
                                    ? Colors.white
                                    : Colors.black)) ,
                        padding: EdgeInsets.symmetric(vertical: 8) ,
                        //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                      ) ,
                    ) ,
                    SizedBox(
                      width: 5.0 ,
                    ) ,
                    SizedBox(
                        width: 50.0 ,
                        child: RaisedButton(
                          elevation: 15.0 ,
                          color: twoTrainings ? Colors.green : Colors.white ,
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0)) ,
                          onPressed: () =>
                              setState(() {
                                zeroTrainings = false;
                                twoTrainings = true;
                                threeTrainings = false;
                                fourTrainings = false;
                                fiveTrainings = false;
                                widget.person.setTrainPerWeek(2);
                              }) ,
                          child: Text("2" ,
                              style: TextStyle(
                                  fontSize: 16 ,
                                  color: twoTrainings
                                      ? Colors.white
                                      : Colors.black)) ,
                          padding: EdgeInsets.symmetric(vertical: 8) ,

                          //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                        )) ,
                    SizedBox(
                      width: 5.0 ,
                    ) ,
                    SizedBox(
                      width: 50.0 ,
                      child: RaisedButton(
                        elevation: 15.0 ,
                        color: threeTrainings ? Colors.green : Colors.white ,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)) ,
                        onPressed: () =>
                            setState(() {
                              zeroTrainings = false;
                              twoTrainings = false;
                              threeTrainings = true;
                              fourTrainings = false;
                              fiveTrainings = false;
                              widget.person.setTrainPerWeek(3);
                            }) ,
                        child: Text("3" ,
                            style: TextStyle(
                                fontSize: 16 ,
                                color: threeTrainings
                                    ? Colors.white
                                    : Colors.black)) ,
                        padding: EdgeInsets.symmetric(vertical: 8) ,
                        //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                      ) ,
                    ) ,
                    SizedBox(
                      width: 5.0 ,
                    ) ,
                    SizedBox(
                      width: 50.0 ,
                      child: RaisedButton(
                        elevation: 15.0 ,
                        color: fourTrainings ? Colors.green : Colors.white ,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)) ,
                        onPressed: () =>
                            setState(() {
                              zeroTrainings = false;
                              twoTrainings = false;
                              threeTrainings = false;
                              fourTrainings = true;
                              fiveTrainings = false;
                              widget.person.setTrainPerWeek(4);

                            }) ,
                        child: Text("4" ,
                            style: TextStyle(
                                fontSize: 16 ,
                                color: fourTrainings
                                    ? Colors.white
                                    : Colors.black)) ,
                        padding: EdgeInsets.symmetric(vertical: 8) ,
                        //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                      ) ,
                    ) ,
                    SizedBox(
                      width: 5.0 ,
                    ) ,
                    SizedBox(
                      width: 50.0 ,
                      child: RaisedButton(
                        elevation: 15.0 ,
                        color: fiveTrainings ? Colors.green : Colors.white ,
                        shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0)) ,
                        onPressed: () =>
                            setState(() {
                              zeroTrainings = false;
                              twoTrainings = false;
                              threeTrainings = false;
                              fourTrainings = false;
                              fiveTrainings = true;
                              widget.person.setTrainPerWeek(5);
                            }) ,
                        child: Text("5" ,
                            style: TextStyle(
                                fontSize: 16 ,
                                color: fiveTrainings
                                    ? Colors.white
                                    : Colors.black)) ,
                        padding: EdgeInsets.symmetric(vertical: 8) ,
                        //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
                      ) ,
                    ) ,
                  ] ,
                ) ,
              ) ,
              SizedBox(
                height: 50.0 ,
              )
            ] ,
          ) ,
        ] ,
      ) ,
    ));

    widgets.add(
      Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0 ,
                ) ,
                Padding(
                  padding: const EdgeInsets.all(20.0) ,
                  child: Text(
                    _userGoal ,
                    style: TextStyle(fontSize: 18.0) ,
                    textAlign: TextAlign.center ,
                  ) ,
                ) ,
                SizedBox(
                  height: 20 ,
                ) ,
                Container(
                  height: isMantainWeightGoal ? 0.0 : null ,
                  child: Column(
                    children: <Widget>[
                      Divider(
                        height: 5.0 ,
                        thickness: 3.0 ,
                        color: Colors.green ,
                      ) ,
                      RadioListTile(
                        value: 1 ,
                        title: isWeightLossGoal
                            ? Text(AppLocalizations.of(context)
                            .translate("lose_0_5_kg_per_week"))
                            : Text(AppLocalizations.of(context)
                            .translate("gain_0_25_kg_per_week")) ,
                        groupValue: selectedRadioBtn ,
                        activeColor: Colors.green ,
                        onChanged: (val) {
                          _setSelectedRadioBtn(val);
                        } ,
                      ) ,
                      Divider(
                        height: 5.0 ,
                        thickness: 2.0 ,
                        color: Colors.green ,
                      ) ,
                      RadioListTile(
                        value: 2 ,
                        title: isGainGoal
                            ? Text(AppLocalizations.of(context)
                            .translate("gain_0_25_kg_per_week"))
                            : Text(AppLocalizations.of(context)
                            .translate("gain_0_5_kg_per_week")) ,
                        groupValue: selectedRadioBtn ,
                        activeColor: Colors.green ,
                        onChanged: (val) {
                          _setSelectedRadioBtn(val);
                        } ,
                      ) ,
                      Divider(
                        height: 5.0 ,
                        thickness: 2.0 ,
                        color: Colors.green ,
                      ) ,
                      SizedBox(
                        height: 40.0 ,
                      ) ,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0) ,
                        child: Text(
                          _goalSelectionText ,
                          style:
                          TextStyle(fontSize: 18 , color: Colors.blueAccent) ,
                        ) ,
                      ) ,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0) ,
                        child: Text(
                          _noteText ,
                          style: TextStyle(
                              fontSize: 16 , color: Colors.orange) ,
                        ) ,
                      ) ,
                    ] ,
                  ) ,
                ) ,
                SizedBox(
                  height: 50.0 ,
                ) ,
                RaisedButton(
                  padding:
                  EdgeInsets.symmetric(vertical: 10.0 , horizontal: 30.0) ,
                  child: Text(
                      AppLocalizations.of(context).translate("set_goal") ,
                      style: TextStyle(fontSize: 18.0)) ,
                  onPressed: () {
                    _setGoalAndSave();
                  } ,
                  color: Colors.green ,
                  elevation: 15.0 ,
                  textColor: Colors.white ,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)) ,
                ) ,
                SizedBox(
                  height: 60.0 ,
                )
              ] ,
            ) ,
          ] ,
        ) ,
      ) ,);

    return widgets;
  }

  void _setSelectedRadioBtn(val) {
    setState(() {
      selectedRadioBtn = val;
      if (val == 1) {
        _goalSelectionText =
            AppLocalizations.of(context).translate("good_start");
        _noteText =
            "\n" + "*" + AppLocalizations.of(context).translate("note_update");
      } else if (val == 2) {
        _goalSelectionText =
            AppLocalizations.of(context).translate("ambitious_target");
        _noteText =
            "\n" + "*" + AppLocalizations.of(context).translate("note_update");
      }
    });
    widget.person.setProcessSpeed(val);
  }

  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
  }
  bool  checkagain = false;

  void _checkForCompletition(int index) {

      if(index==lastKnownIndex -1) {
        _currentIndex = lastKnownIndex -1;
      }

      if (index == 1 && _currentIndex == 0) {
        if (_nameTextControl.text
            .toString()
            .length < 2) {
          _showAlert(
            title: AppLocalizations.of(context).translate(
                "introduceti_numele") ,
            content: "" ,
            onPressed: _changeBlackVisible ,
          );
          _currentIndex = index -1;
          return;

        }
        else if (!manpressAttention && !womanpressAttention) {
          _showAlert(
            title: AppLocalizations.of(context).translate("alege_genul") ,
            content: "" ,
            onPressed: _changeBlackVisible ,
          );
          _currentIndex = index -1;
          return;
        }
        else if (_ageController.text
            .toString()
            .length < 2) {
          _showAlert(
            title: AppLocalizations.of(context).translate(
                "introduceti_varsta") ,
            content: "" ,
            onPressed: _changeBlackVisible ,
          );
          _currentIndex = index -1;
          return;

        }
        else {
          String numeIntrodus = _nameTextControl.text.toString().trim();
          String primaLiteraMare = numeIntrodus.substring(0 , 1).toUpperCase();
          String restulNumelui = numeIntrodus.substring(1);
          widget.person.setName(primaLiteraMare + restulNumelui);
          widget.person.setGender(womanpressAttention ? 1 : 2);
          widget.person.setAge(int.parse(_ageController.text));
          _currentIndex = lastKnownIndex = index;
          return;

        }
      }
      if (index == 2 && _currentIndex == 1) {
        if (_heightController.text
            .toString()
            .length < 2
            || _heightController.text
                .toString()
                .length > 3
            || _currentWeightController.text.length < 2
            || _goalWeightController.text.length < 2) {
          _showAlert(
            title: AppLocalizations.of(context).translate(
                "introduceti_greutatea_inaltimea") ,
            content: "" ,
            onPressed: _changeBlackVisible ,
          );

          _currentIndex = index - 1;
          return;

        }

        else {
          FocusScope.of(context).unfocus();
          widget.person.setHeight(int.parse(_heightController.text));
          widget.person.setCurrentWeight(
              int.parse(_currentWeightController.text));
          widget.person.setGoalWeight(int.parse(_goalWeightController.text));
          _currentIndex = lastKnownIndex = index;
          return;

        }
      }
      if (index == 3 && _currentIndex == 2) {

        if (widget.person.getActivityIntensity() == null ||
            widget.person.getTrainPerWeek() == null) {

          _currentIndex = index - 1;

          _showAlert(
            title: AppLocalizations.of(context).translate(
                "please_select_activity") ,
            content: "" ,
            onPressed: _changeBlackVisible ,
          );
        }

        else {
          _ChooseProcessSpeed();
          _currentIndex = lastKnownIndex = index;
        }
      }
  }


  void _setGoalAndSave() {
    if (widget.person.processSpeed != null) {

      widget.person.setCaloriesNeeded(new CalculateCalories(widget.person).Calculate());
      widget.person.setBmr(new CalculateCalories(widget.person).CalculateBMR());
      _saveData();
      _displayMessage();

    } else {
      _showAlert(
        title: AppLocalizations.of(context).translate(
            "chose_speed") ,
        content: "" ,
        onPressed: _changeBlackVisible ,
      );

    }
  }

  void _showAlert(
      {String title , String content , VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false ,
      context: context ,
      builder: (context) {
        return CustomAlertDialog(
          content: content ,
          title: title ,
          onPressed: onPressed ,
        );
      } ,
    );
  }

  void _ChooseProcessSpeed() {

    if (widget.person.currentWeight > widget.person.goalWeight) {
      _userGoal = AppLocalizations.of(context).translate("weight_loss_healthy");
      isWeightLossGoal = true;
      isGainGoal = false;
      setState(() {
      });
    } else if (widget.person.currentWeight < widget.person.goalWeight) {
      _userGoal = AppLocalizations.of(context).translate("gain_muscle_text");
      isGainGoal = true;
      isWeightLossGoal = false;
      setState(() {
      });
    } else {
      _userGoal =
          AppLocalizations.of(context).translate("maintain_weight_goal");
      isMantainWeightGoal = true;
      setState(() {
      });
    }

  }

  Future _saveData() async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();

    DateTime dateTime = DateTime.now();
    widget.person.setCreatedDate(dateTime.toString().substring(0, 10));

    prefs.setString("nume", widget.person.getName() + ":");
    prefs.setInt("calneed", widget.person.getCaloriesNeeded());
    prefs.setInt("varsta", widget.person.getAge());
    prefs.setInt("inaltimea", widget.person.getHeight());
    prefs.setInt("greutatea", widget.person.getCurrentWeight());
    prefs.setInt("greutateadorita", widget.person.getGoalWeight());
    prefs.setInt("activitate", widget.person.getActivityIntensity());
    prefs.setInt("antrenamente", widget.person.getTrainPerWeek());
    prefs.setInt("gender", widget.person.getGender());
    prefs.setInt("processSpeed", widget.person.getProcessSpeed());
    prefs.setBool("useImperial", widget.person.isUseImperial());
    prefs.setString("personId", widget.person.getId());
    prefs.setString("poza", widget.person.getPoza());
    prefs.setString("password", widget.person.getPassword());
    prefs.setString("email", widget.person.getEmail());
    prefs.setInt("bmr", widget.person.getBmr());
    prefs.setString("date", widget.person.getCreatedDate());

    prefs.commit();

    String table_name="users";
    FirebaseAuth.instance.currentUser().then((u){
      if(u!=null){

//      String push = FirebaseDatabase.instance.reference().
//      child(table_name).child(u.uid).key;
        FirebaseDatabase.instance.reference().child(table_name).child(u.uid)
            .set( (widget.person.toJson())).then((r){
          print("order set called");

        }).catchError((onError){
          print("order error called "+onError.toString());
        });

  }
  });
  }


  void _displayMessage() {
      String message;

      if(isWeightLossGoal){
        message = widget.person.getName() + AppLocalizations.of(context).translate("ai_nevoiede_mai_putin")
            + " " + widget.person.getCaloriesNeeded().toString()
            + " " + AppLocalizations.of(context).translate("_calorii_zilnic");
      }
      if(isGainGoal){
        message = widget.person.getName() + AppLocalizations.of(context).translate("ai_nevoiede_peste")
            + " " + widget.person.getCaloriesNeeded().toString()
            + " " + AppLocalizations.of(context).translate("_calorii_zilnic");
      }
      if(isMantainWeightGoal){
        message = widget.person.getName() + AppLocalizations.of(context).translate("ai_nevoiepentrua_mentine")
            + " " + widget.person.getCaloriesNeeded().toString()
            + " " + AppLocalizations.of(context).translate("pentrua_mentine_greutatea");
      }

      Navigator.of(context).push(
          new MaterialPageRoute(builder: (context) {
            return new _mycustomAlertDialog(

              title: AppLocalizations.of(context).translate("app_name")
               + " Calculator",
                content: message);
          })
      );
  }

  }

class _mycustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;

  _mycustomAlertDialog({this.title, this.content});

  @override
  Widget build(BuildContext context) {

    Route<Object> newRoute = new MaterialPageRoute(builder: (context) {
      return new  MainScreen();
    });

    return
      AlertDialog(
        contentPadding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        title: Text(
          title ,
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
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                content,
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
                child: CustomFlatButton(
                  title: "OK",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                          (Route<dynamic> route) => false,);
                    },
                  color: Colors.green,
                  splashColor: Colors.black12,
                  borderColor: Colors.black12,
                  borderWidth: 2,
                ),
              ),
            ],
          ),
        ),
      );
  }
}



