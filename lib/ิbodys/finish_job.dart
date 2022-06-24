// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:kritegat/models/job_model.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/utility/my_dialog.dart';
import 'package:kritegat/widget/show_progress.dart';
import 'package:kritegat/widget/show_text.dart';

class FinishJob extends StatefulWidget {
  final String idofficer;
  const FinishJob({
    Key? key,
    required this.idofficer,
  }) : super(key: key);

  @override
  State<FinishJob> createState() => _FinishJobState();
}

class _FinishJobState extends State<FinishJob> {
  var jobModels = <JobModel>[];
  bool load = true;
  bool? haveData;

  @override
  void initState() {
    super.initState();
    readData();
  }

//  ดึงค่าจาก Database มาใช้
  Future<void> readData() async {
    String path =
        'https://www.androidthai.in.th/egat/getUserWhereIdOfficerSuccessKrit.php?isAdd=true&idofficer=${widget.idofficer}';
    await Dio().get(path).then((value) {
      print('value readData ==> $value');

      if (value.toString() == 'null') {
        haveData = false;
      } else {
        haveData = true;
        for (var element in json.decode(value.data)) {
          JobModel jobModel = JobModel.fromMap(element);
          jobModels.add(jobModel);
        }
      }
      load = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? const ShowProgress()
        : haveData!
            //สร้างการแสดงแบบ Gridview
            ? GridView.builder(
                itemCount: jobModels.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) => Card(
                      child: Column(
                        children: [
                          SizedBox(
                              width: 100,
                              height: 100,
                              child: Image.network(
                                jobModels[index].pathimage,
                                fit: BoxFit.cover,
                              )),
                          ShowText(
                            text: jobModels[index].job,
                            textStyle: MyConstant().h3Style(),
                          ),
                        ],
                      ),
                    ))
            : const Center(child: ShowText(text: 'No Data'));
  }
}
