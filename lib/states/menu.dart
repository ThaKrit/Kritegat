// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:kritegat/models/job_model.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/widget/show_text.dart';

class MyMenu extends StatefulWidget {
  final List<String> dataUserLogins;
  const MyMenu({
    Key? key,
    required this.dataUserLogins,
  }) : super(key: key);

  @override
  State<MyMenu> createState() => _MyMenuState();
}

class _MyMenuState extends State<MyMenu> {
  var dataUserLogin = <String>[];
  var jobModels = <JobModel>[];
  @override
  void initState() {
    super.initState();
    dataUserLogin = widget.dataUserLogins;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: ShowText(
          text: 'Welcome',
          textStyle: MyConstant().h1Style(),
        ),
      ),
    );
  }
}
