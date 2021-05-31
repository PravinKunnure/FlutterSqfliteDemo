import 'package:flutter/material.dart';
import 'package:flutter_27may2021/28MayDemos/flutter_dropdown.dart';
import 'package:flutter_27may2021/28MayDemos/flutter_http_demo.dart';
import 'package:flutter_27may2021/28MayDemos/flutter_http_demo_postmethod.dart';
import 'package:flutter_27may2021/sqflite_demo/presenter/presenter_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: RESTAPICalls(),
      home: Presenter(),
    );
  }
}
