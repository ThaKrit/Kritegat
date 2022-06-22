import 'package:flutter/material.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/utility/my_dialog.dart';
import 'package:kritegat/widget/show_icon_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myservice extends StatelessWidget {
  const Myservice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0, // เส้นของ Appbar
        foregroundColor: MyConstant.dark,
        backgroundColor: Colors.white,
        actions: [
          ShowIconbtn(
            iconData: Icons.exit_to_app,
            pressFunc: () {
              MyDialog(context: context).normalDialog(
                  pressFunc: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.clear().then((value) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/authen', (route) => false);
                    });
                  },
                  label: 'Sign Out',
                  title: 'Sign Out?',
                  subTitle: 'Please Confirm Sign Out');
            },
          ),
        ],
      ),
    );
  }
}
