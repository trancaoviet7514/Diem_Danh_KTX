import 'package:diem_danh_ktx/Activity/LoginScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp( new MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "ahii",
      home: new LoginScreen()
    );
  }

}