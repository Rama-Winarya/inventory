import 'package:flutter/material.dart';
import 'package:inventory/LoginPage.dart';
// import 'package:inventory/screens/MenuUser.dart';
// import 'package:inventory/screens/MenuUser.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: LoginPage(),
  ));
}
