import 'package:flutter/material.dart';

class MyRaisedButton extends StatelessWidget {
  final String mytext;
  final Color textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final VoidCallback onPressed;
  final Color color;
  final Color splashColor;
  final Color borderColor;
  final double borderWidth;
  final IconData myIcon;
  final Gradient myGradient;
  final VoidCallback myOnPressed;
  final bool isInvisible;

  MyRaisedButton(
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
      this.myOnPressed,
      this.isInvisible});

  @override
  Widget build(BuildContext context) {

    if(isInvisible){
      return Container();
    }else {
      return Container(
        height: 45.0 ,
        decoration: BoxDecoration(
          gradient: myGradient ,
          borderRadius: BorderRadius.circular(20.0) ,
        ) ,
        child: RaisedButton(
          onPressed: myOnPressed ,
          color: Colors.transparent ,
          elevation: 0.0 ,
          //  elevation: 35.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center ,
            children: <Widget>[
              Text(
                  mytext ,
                  style: TextStyle(fontSize: 17.0)) ,
              Padding(
                padding: const EdgeInsets.only(left: 12.0) ,
                child: Icon(
                  myIcon ,
                  size: 35.0 ,
                  color: Colors.yellow ,
                ) ,
              )
            ] ,
          ) ,
        ) ,

      );
    }
  }
}
