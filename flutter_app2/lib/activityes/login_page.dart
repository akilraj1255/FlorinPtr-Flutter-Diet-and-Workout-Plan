import 'dart:io';
import 'dart:ui' as prefix0;
import 'package:flutter_app/Themes/myColors.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' show get;
import 'package:path/path.dart' as Path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Utils/Person.dart';
import 'package:flutter_app/Utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Utils/auth.dart';
import 'package:flutter_app/Utils/validator.dart';
import 'package:flutter_app/Utils/widgets/custom_alert_dialog.dart';
import 'package:flutter_app/Utils/widgets/custom_text_field.dart';
import 'package:flutter_app/activityes/set_user_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';


class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _LoginPageState();
  }
}

class _LoginPageState extends State {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  CustomTextField _emailField;
  CustomTextField _passwordField;
  bool _blackVisible = false;
  VoidCallback onBackPress;

  Person person = new Person();

  bool isSiignedIn = false;


  @override
  void initState() {
    super.initState();

    onBackPress = () {
      Navigator.of(context).pop();
    };

    _emailField = new CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _email,
      myhint: "E-mail Adress",
      inputType: TextInputType.emailAddress,
      validator: Validator.validateEmail,
    );
    _passwordField = CustomTextField(
      baseColor: Colors.grey,
      borderColor: Colors.grey[400],
      errorColor: Colors.red,
      controller: _password,
      obscureText: true,
      myhint: "Password",
      validator: Validator.validatePassword,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Login"), centerTitle: true, elevation: 10.0,),
      body: new ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(height: 0.0),
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/loginbacckground.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50.0),
                Text(
                  AppLocalizations.of(context)
                      .translate('please_choose_login_method'),
                  style: TextStyle(
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      backgroundColor: Color.fromARGB(085, 0, 0, 0)),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50.0),
                Center(
                  child: Container(
                    padding: EdgeInsets.all(5.0),
                    color: Colors.lightBlue,
                    child: Image(
                        image: AssetImage(
                            "assets/images/facebook_user_image.png")),
                  ),
                ),
                SizedBox(height: 20,),
                RaisedButton(
                  child: Text("Continue with Facebook",
                      style: TextStyle(fontSize: 18.0)),
                  onPressed: () {
                    _loginWithFb(context);
                  },
                  color: Colors.blueAccent,
                  elevation: 15.0,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
                SizedBox(height: 25.0),
                Text(AppLocalizations.of(context).translate("_sau"), textAlign: TextAlign.center),
                SizedBox(
                  height: 25.0,
                ),
                Text(
                  "Continue with Email&Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 25.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: _emailField
                ),
                SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: _passwordField
                ),
                FlatButton(
                 onPressed: (){_forgotPass(_email.text);},
                 child: Text(AppLocalizations.of(context).translate("forgot_your_password"),
                     style: TextStyle(color: Colors.blue, fontSize: 15.0, fontStyle: prefix0.FontStyle.italic)
                )
                ),
                SizedBox(height: 30.0),
                RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  child: Text("Login/Register", style: TextStyle(fontSize: 18.0)),
                  onPressed: () {
                    _signUpWithEmailAndPss(
                        email: _email.text,
                        password: _password.text,
                        context: context
                    );
                  },
                    color: MyTheme.themeColor,
                  elevation: 15.0,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                ),
                SizedBox(
                  height: 60.0,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _changeBlackVisible() {
    setState(() {
      _blackVisible = !_blackVisible;
    });
  }

  void _loginWithFb(BuildContext context) async{

    try {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
      _changeBlackVisible();
      FacebookLogin facebookLogin = new FacebookLogin();
      FacebookLoginResult result = await facebookLogin.logIn(['email', 'public_profile']);
      switch (result.status) {
        case FacebookLoginStatus.loggedIn:
          AuthCredential credential= FacebookAuthProvider.getCredential(
              accessToken: result.accessToken.token);

          FirebaseUser firebaseUser = (
              await FirebaseAuth.instance.signInWithCredential(credential)
          ).user;
          _setUserProfilePicture(result.accessToken.userId);
              person.setName(firebaseUser.displayName);
              person.setId(firebaseUser.uid);
              person.setEmail(firebaseUser.email ?? '');
              Navigator.of(context).push(
                  new MaterialPageRoute(builder: (context) {
                    return new SetUserData(person);
                  })
              );
          break;
          case FacebookLoginStatus.cancelledByUser:
          case FacebookLoginStatus.error:
          _changeBlackVisible();
      }
    } catch (e) {
      print("Error in facebook sign in: $e");
      String exception = Auth.getExceptionText(e);
      _showErrorAlert(
        title: "Login failed",
        content: exception,
        onPressed: _changeBlackVisible,
      );
    }

  }

  void _showErrorAlert({String title, String content, VoidCallback onPressed}) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }

  void _signinWithEmailandPass({String password, String email, BuildContext context}) async {

    if (Validator.validateEmail(email) &&
        Validator.validatePassword(password)) {
      try {

        Person user = new Person();
        user.setEmail(email);
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _changeBlackVisible();
        await Auth.signIn(email, password)
            .then((uid) => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => SetUserData(user)),
              (Route<dynamic> route) => false,)
        );
      } catch (e) {
        print("Error in email sign in: $e");
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Login failed",
          content: exception,
          onPressed: _changeBlackVisible,
        );
      }
    }
  }

  void _signUpWithEmailAndPss({
    String fullname,
        String number,
    String email,
    String password,
    BuildContext context}) async {

    if (Validator.validateEmail(email) &&
        Validator.validatePassword(password)) {
      try {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        _changeBlackVisible();
        await Auth.signUp(email , password).then((uID) {

          person.setId(uID);
          person.setEmail(email);
          isSiignedIn = true;

          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) {
                return new SetUserData(person);
              })
          );
        });
      } catch (e) {
        print("Error in sign up: $e");

        if (!isSiignedIn) {
          _signinWithEmailandPass(
              password: password , email: email , context: context);
        }
      }
    }
  }

 void  _forgotPass(String email) async {

    if(Validator.validateEmail(email)){
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showErrorAlert(
          title: "Check your email for new password" ,
          content: "" ,
          onPressed: _changeBlackVisible
      );
      _password.text = "";
    }
    else {
      _showErrorAlert(
          title: "Enter correct email address..." ,
          content: "" ,
          onPressed: _changeBlackVisible
      );
    }
  }

  void _setUserProfilePicture(String uid) async {
    String pictureLink = "https://graph.facebook.com/" + uid + "/picture?width=9999";
    person.setPoza(pictureLink);

    var response = await get(pictureLink);
     var documentDirectory = await getApplicationDocumentsDirectory();

    File file = new File(
        Path.join(documentDirectory.path, 'userimage.png')
    );

    file.writeAsBytesSync(response.bodyBytes);

  }
}
