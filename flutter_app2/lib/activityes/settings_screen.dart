
 import 'package:flutter/material.dart';
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_app/Utils/widgets/my_small_rised_button.dart';

import 'addNewFoodScreen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _settingsScreenState();
  }

}

class _settingsScreenState extends State {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("..."), centerTitle: true,),
      body: ListView(
        children: <Widget>[Padding(
          padding: const EdgeInsets.all(8.0),
          child: MySmallRaisedButton(mytext: "", myIcon: Icon(Icons.add),
            myGradient: MyTheme.myLinearGradient,
            myOnPressed: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                return new AddNewFoodScreen();
              }));
            },),
        ),],
      ),
    );
  }
}
