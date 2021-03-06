import 'package:flutter/material.dart';
import 'package:kritegat/%E0%B8%B4bodys/finish_job.dart';
import 'package:kritegat/%E0%B8%B4bodys/non_finish_job.dart';
import 'package:kritegat/models/user_model.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/utility/my_dialog.dart';
import 'package:kritegat/widget/show_icon_button.dart';
import 'package:kritegat/widget/show_progress.dart';
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

  var widgets = <Widget>[];

  var bottonNavigator = <BottomNavigationBarItem>[];
  int indexBodys = 0;

  @override
  void initState() {
    super.initState();

    createNaviBar();
    provessFindUserLogin();
  }

  Future<void> provessFindUserLogin() async {
    //instant = object // await = ให้มันทำงานจนเสร็จก่อน
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var dataLogins = preferences.getStringList(
        'data'); // ทำไมคีย์ต้องเป็น data? เพราะตอนเรียกเราเรียก data
    print('dataLogin ==> $dataLogins');
    widgets.add(NonFinishJob(dataUserLogins: dataLogins!));
    widgets.add(FinishJob(idofficer: dataLogins[3]));
    setState(() {});
  }

//createNaivicationBar
  void createNaviBar() {
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
      body: widgets.isEmpty
          ? const ShowProgress()
          : widgets[
              indexBodys], //ถ้า widgets ว่างจะให้โชว์ Showprogress ถ้าไม่ว่างจะโชว์ widget...

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
