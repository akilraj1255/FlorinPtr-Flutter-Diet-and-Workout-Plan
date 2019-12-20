import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroceryListsActivity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _GroceryListsState();
  }
}

  class _GroceryListsState extends State<GroceryListsActivity> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(),
        bottomSheet: Container(),
        body: ListView(
          children: <Widget>[

          ],
        ),
      );
    }
  }
