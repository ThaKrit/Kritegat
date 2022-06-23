import 'package:flutter/material.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/widget/show_text.dart';

class FinishJob extends StatelessWidget {
  const FinishJob({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShowText(
      text: 'This is Finish Job!?',
      textStyle: MyConstant().h3Style(),
    );
  }
}
