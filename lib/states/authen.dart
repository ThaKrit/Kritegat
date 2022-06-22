// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kritegat/models/user_model.dart';
import 'package:kritegat/states/my_service.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/utility/my_dialog.dart';
import 'package:kritegat/widget/show_button.dart';
import 'package:kritegat/widget/show_image.dart';
import 'package:kritegat/widget/show_text.dart';
import 'package:kritegat/widget/show_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Stateless ถ้าจะดึง theme ต้องใช้ Scaffold();
class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool redEye = true;
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // LayoutBuilder สำหรับใช้กำหนดขนาดและตรวจสอบขนาดหน้าจอ
      // Constraints จะตรวจสอบสเกลหน้าจอว่าใช้ขนาดเท่าไหร่
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(
                FocusScopeNode()); //ให้เป็นสถานะของ Focus เป็น Enable
          },
          child: Container(
            decoration: MyConstant().bgBox(), //สีพื้นหลัง
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  newLogo(boxConstraints),
                  newTitle(boxConstraints),
                  formUser(boxConstraints),
                  formPassword(boxConstraints),
                  buttonLogin(boxConstraints),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Container buttonLogin(BoxConstraints boxConstraints) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: boxConstraints.maxWidth * 0.4,
      child: ShowButton(
        label: 'Login',
        pressFunc: () {
          print('user = $user , password = $password');
          if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
            print("Have Space");
            MyDialog(context: context).normalDialog(
                title: 'Have space!!', subTitle: 'Please Fill Blank');
          } else {
            print("NO Space");
            processCheckLogin();
          }
        },
      ),
    );
  }

  Container formPassword(BoxConstraints boxConstraints) {
    return Container(
      margin: const EdgeInsets.only(top: 5), //เว้นเฉพาะข้างบน
      width: boxConstraints.maxWidth * 0.85,
      height: 40,
      child: ShowForm(
        redEyeFunc: () {
          setState(() {
            redEye = !redEye;
          });
        },
        obSecu: redEye, //ทำให้ตัวอักษรในช่องเป็น ***
        iconData: Icons.lock_outline,
        changeFung: (String string) {
          password = string.trim();
        },
        hint: 'Password',
      ),
    );
  }

  Container formUser(BoxConstraints boxConstraints) {
    return Container(
      margin: const EdgeInsets.only(top: 5), //เว้นเฉพาะข้างบน
      width: boxConstraints.maxWidth * 0.85,
      height: 40,
      child: ShowForm(
        iconData: Icons.account_circle,
        changeFung: (String string) {
          user = string.trim();
        },
        hint: 'Username',
      ),
    );
  }

  SizedBox newTitle(BoxConstraints boxConstraints) {
    return SizedBox(
      width: boxConstraints.maxWidth * 0.7,
      child: Row(
        children: [
          ShowText(text: 'Login'),
        ],
      ),
    );
  }

  //นำรูปมาแสดงจากไฟล์ show_image.dart
  SizedBox newLogo(BoxConstraints boxConstraints) {
    return SizedBox(
      width: boxConstraints.maxWidth * 0.8,
      child: Row(
        children: [
          SizedBox(
            width: boxConstraints.maxWidth *
                0.50, //กำรูปโดยคิดจากขนาดจอแล้วนะมาคูณ
            child: ShowImage(),
          ),
        ],
      ),
    );
  }

  //ทำ CheckLogin เมื่อไหร่ก็ตามที่โยนขึ้น Server มันจะ respont กลับมา
  Future<void> processCheckLogin() async {
    String path =
        'https://www.androidthai.in.th/egat/getUserWhereUserkrit.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) {
      print('value ==> $value');

      if (value.toString() == 'null') {
        print("No $user in My Database");
        MyDialog(context: context).normalDialog(
            title: 'User False', subTitle: 'No $user in my database!!');
      } else {
        var result = json.decode(value.data);
        print('result = $result');
        for (var element in result) {
          UserModel userModel = UserModel.fromMap(element);
          if (password == userModel.password) {
            MyDialog(context: context).normalDialog(
                pressFunc: () async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();

                  var data = <String>[];
                  data.add(userModel.id);
                  data.add(userModel.name);
                  data.add(userModel.position);

                  preferences.setStringList('data', data).then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Myservice(),
                        ),
                        (route) => false);
                  });
                },
                label: "Go to Service",
                title: 'Welcome to App',
                subTitle: 'Login Success Welcome ${userModel.name}');
          } else {
            MyDialog(context: context).normalDialog(
                title: 'Password False',
                subTitle: "No $password in My Database");
          }
        }
      }
    });
  }
}
