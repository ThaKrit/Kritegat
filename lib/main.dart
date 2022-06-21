import 'package:flutter/material.dart';
import 'package:kritegat/states/authen.dart';

void main() {
  runApp(MyApp());
}

//สร้าง stateless MaterialApp
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Authen(),
    );
  }
}
