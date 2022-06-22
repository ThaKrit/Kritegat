import 'package:flutter/material.dart';
import 'package:kritegat/%E0%B8%B4bodys/finish_job.dart';
import 'package:kritegat/%E0%B8%B4bodys/non_finish_job.dart';
import 'package:kritegat/models/user_model.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/utility/my_dialog.dart';
import 'package:kritegat/widget/show_icon_button.dart';
import 'package:kritegat/widget/show_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myservice extends StatefulWidget {
  const Myservice({Key? key}) : super(key: key);

  @override
  State<Myservice> createState() => _MyserviceState();
}

class _MyserviceState extends State<Myservice> {
  var titles = <String>[
    //ประกาศตัวแปรแบบ Array
    'Non Finish',
    'Finish',
  ];

  var iconDatas = <IconData>[
    Icons.close,
    Icons.done,
  ];

  var widgets = <Widget>[
    const NonFinishJob(),
    const FinishJob(),
  ];

  var bottonNavigator = <BottomNavigationBarItem>[];
  int indexBodys = 0;

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < titles.length; i++) {
      bottonNavigator.add(
        BottomNavigationBarItem(
          label: titles[i],
          icon: Icon(
            iconDatas[i],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: newAppBar(context),
      body: widgets[indexBodys],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexBodys,
        items: bottonNavigator,
        onTap: (value) {
          setState(() {
            indexBodys = value;
          });
        },
      ),
    );
  }

// Method appbar
  AppBar newAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: ShowText(
        text: titles[indexBodys],
        textStyle: MyConstant().h2Style(),
      ),
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
    );
  }
}
