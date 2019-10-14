
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class MyWelcome extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0) ,
          child: ListView(
            scrollDirection: Axis.vertical ,
            children: <Widget>[
              SizedBox(height: 45) ,
              Text(
                AppLocalizations.of(context).translate('bine_ati_venit') ,
                style: TextStyle(fontSize: 22 , color: Colors.black) ,
                textAlign: TextAlign.center ,
              ) ,
              SizedBox(height: 25) ,
              Text(
                AppLocalizations.of(context).translate('messageText') ,
                style: TextStyle(fontSize: 16 , color: Colors.black) ,
                textAlign: TextAlign.center ,
              ) ,
              SizedBox(height: 30) ,
              RaisedButton(
                elevation: 15.0,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
                color: Colors.green ,
                onPressed: () {
                  Navigator.of(context).push(
                      new MaterialPageRoute(builder: (context) {
                        return new LoginPage();
                      })
                  );
                },

                child: Text(
                    "Start" ,
                    style: TextStyle(fontSize: 20 , color: Colors.white)) ,
                padding: EdgeInsets.symmetric(vertical: 8) ,

                //  child: Icon(Icons.add_circle, size: 65, color: Colors.green,) ,
              ) ,
              SizedBox(height: 40 ,)
            ] ,
          ) ,
        ) ,
      ) ,
    );
  }
}