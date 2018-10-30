import 'package:diem_danh_ktx/Utils/DataIO.dart';
import 'package:diem_danh_ktx/Activity/MainScreen.dart';
import 'package:diem_danh_ktx/Model/User.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    DataIO.getAllUser();
    return new LoginState();
  }
}

class LoginState extends State<LoginScreen> {

  static const MARGIN_PARENT = 30.0;
  BuildContext mContext;
  TextEditingController mUserNameController = TextEditingController();
  TextEditingController mPasswordController = TextEditingController();

  Widget buildEditText (String hint, bool obscure, TextEditingController controller) {
    return new Container(
      decoration: new BoxDecoration(
        color: new Color.fromARGB(255, 240, 240, 240),
        border: new Border.all(width: 1.2, color: Colors.black12),
        borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
      ),
      margin: new EdgeInsets.only(left: MARGIN_PARENT, right: MARGIN_PARENT, bottom: 10.0),
      child: new TextField(
        decoration: new InputDecoration(
          hintText: hint,
          contentPadding: new EdgeInsets.all(10.0),
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.text,
        autocorrect: false,
        obscureText: obscure,
        controller: controller,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset('images/logo_phuot.jpeg',
          scale: 2.0,
          ),
          new Container(
            margin: EdgeInsets.all(10.0),
          ),
          buildEditText('User name',false, mUserNameController),
          buildEditText('Password', true, mPasswordController),
          buildButtonLogin(context)
        ],
      ),
    );
  }

  Widget buildButtonLogin(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(left: MARGIN_PARENT, right: MARGIN_PARENT),
      decoration: new BoxDecoration(
          borderRadius: const BorderRadius.all(const Radius.circular(10.0))
      ),
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: new RaisedButton(
                color: Colors.blue,
                textColor: Colors.white,
                child: new Text('Login'),
                onPressed: () {
                  if (DataIO.VerifyAccount(mUserNameController.text, mPasswordController.text)) {
                    Navigator.push(
                      mContext,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  } else {

                  }
                },
              )
          )
        ],
      ),
    );
  }
}