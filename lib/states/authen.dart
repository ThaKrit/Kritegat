import 'package:flutter/material.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/widget/show_button.dart';
import 'package:kritegat/widget/show_image.dart';
import 'package:kritegat/widget/show_text.dart';
import 'package:kritegat/widget/show_textfeil.dart';

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
              const Center(
                  child: ShowText(
                text: '',
              )),
              Center(
                  child: const ShowText(
                text: 'Login',
              )),
              ShowTextfeil(),
              ShowButton(),
            ],
          ),
        );
      }),
    );
  }

  SizedBox newLogo(BoxConstraints boxConstraints) {
    return SizedBox(
      width: boxConstraints.maxWidth * 0.50,
      child: ShowImage(),
    );
  }
}
