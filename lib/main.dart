import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kritegat/states/authen.dart';
import 'package:kritegat/states/my_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (context) => const Authen(),
  '/myService': (context) => const Myservice(),
};

String? firstState;

Future<void> main() async {
  HttpOverrides.global = MyHttpOverride(); // ตัวขออนุญาต Server
  // ค้นหาการเข้ารหัส login ไว้ตั้งแต่ครั้งก่อนหรือไม่
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var result = preferences.getStringList('data');
  print('result = $result');

  if (result == null) {
    firstState = '/authen';
    runApp(MyApp());
  } else {
    firstState = '/myService';
    runApp(MyApp());
  }
}

//สร้าง stateless MaterialApp รันหน้าแอพโดยดึงหน้ามาจากไฟล์ Aythen.dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: map,
      initialRoute: firstState,
    );
  }
}

//ตัว connect server
class MyHttpOverride extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
