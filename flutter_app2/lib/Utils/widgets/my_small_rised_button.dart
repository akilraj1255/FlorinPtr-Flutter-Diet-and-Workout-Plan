import 'package:flutter/material.dart';

class MySmallRaisedButton extends StatelessWidget {
  final String mytext;
  bool isEnabled = true;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color color;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;
  final Icon myIcon;
  final Gradient myGradient;
  final VoidCallback myOnPressed;

  MySmallRaisedButton(
      {this.mytext,
      this.textColor,
      this.fontSize,
      this.fontWeight,
      this.onPressed,
      this.color,
      this.splashColor,
      this.borderColor,
      this.borderWidth,
      this.myIcon,
      this.myGradient,
      this.myOnPressed});

  @override
  Widget build(BuildContext context) {
        return
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        RaisedButton(
        onPressed: myOnPressed,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
//        side: BorderSide(
//      //    color: borderColor,
//        //  width: borderWidth,
//        ),
          ),
        padding: const EdgeInsets.all(0.0),
        child: Container(
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
        gradient: myGradient,
        ),
        padding: const EdgeInsets.symmetric(horizontal:10.0, vertical: 5),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical:5.0, horizontal: 10.0),
              child: Text(
              mytext,
              style: TextStyle(fontSize: 15.0, color: Colors.black)
              ),
            ),
            myIcon,
          ],
        ),
        ),
        ),
      ],
    );
  }
}
