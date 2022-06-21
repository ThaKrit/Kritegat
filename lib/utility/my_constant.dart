import 'package:flutter/material.dart';

class MyConstant {
  // Field const = ค่าคงที่เกิดมากำหนดเลย final = เกิดมายังไม่คงที่ ต้องกำหนด
  static Color primary = const Color.fromARGB(255, 0, 169, 211);
  static Color dark = Color.fromARGB(255, 39, 39, 39);

  //Method
  TextStyle h1Style() {
    return TextStyle(fontSize: 36, color: dark, fontWeight: FontWeight.bold);
  }

  TextStyle h2Style() {
    return TextStyle(fontSize: 18, color: dark, fontWeight: FontWeight.bold);
  }

  TextStyle h3Style() {
    return TextStyle(fontSize: 14, color: dark, fontWeight: FontWeight.bold);
  }
}
