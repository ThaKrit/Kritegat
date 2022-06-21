import 'package:flutter/material.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/widget/show_button.dart';
import 'package:kritegat/widget/show_image.dart';
import 'package:kritegat/widget/show_text.dart';
import 'package:kritegat/widget/show_form.dart';

//Stateless ถ้าจะดึง theme ต้องใช้ Scaffold();
class Authen extends StatelessWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // LayoutBuilder สำหรับใช้กำหนดขนาดและตรวจสอบขนาดหน้าจอ
      // Constraints จะตรวจสอบสเกลหน้าจอว่าใช้ขนาดเท่าไหร่
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              newLogo(boxConstraints),
              newTitle(),
              formUser(boxConstraints),
              formPassword(boxConstraints),
              ShowButton(),
            ],
          ),
        );
      }),
    );
  }

  Container formPassword(BoxConstraints boxConstraints) {
    return Container(
              margin: const EdgeInsets.only(top: 5), //เว้นเฉพาะข้างบน
              width: boxConstraints.maxWidth * 0.85,
              height: 40,
              child: ShowForm(
                iconData: Icons.lock_outline,
                changeFung: (String string) {},
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
        changeFung: (String string) {},
        hint: 'Username',
      ),
    );
  }

  ShowText newTitle() => ShowText(text: 'Login');

  //นำรูปมาแสดงจากไฟล์ show_image.dart
  SizedBox newLogo(BoxConstraints boxConstraints) {
    return SizedBox(
      width: boxConstraints.maxWidth * 0.50, //กำรูปโดยคิดจากขนาดจอแล้วนะมาคูณ
      child: ShowImage(),
    );
  }
}
