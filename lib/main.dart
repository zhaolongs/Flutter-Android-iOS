import 'dart:io';
import 'package:flutter/material.dart';
import 'home_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    String title ="";
    if (Platform.isIOS) {
      //ios相关代码
      title = "flutter 与 Ios 双向互调 ";
    } else if (Platform.isAndroid) {
      //android相关代码
      title = "flutter 与 Android 双向互调";
    }
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title),
    );
  }
}

