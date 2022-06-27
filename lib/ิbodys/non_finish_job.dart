// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kritegat/models/job_model.dart';
import 'package:kritegat/states/detail.dart';
import 'package:kritegat/utility/my_calculate.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/widget/show_button.dart';
import 'package:kritegat/widget/show_progress.dart';

import 'package:kritegat/widget/show_text.dart';

class NonFinishJob extends StatefulWidget {
  //ประกาศตัวแปลที่เป็น Array = List ในภาษา Dart
  final List<String> dataUserLogins;

  const NonFinishJob({
    Key? key,
    required this.dataUserLogins,
  }) : super(key: key);

  @override
  State<NonFinishJob> createState() => _NonFinishJobState();
}

class _NonFinishJobState extends State<NonFinishJob> {
  var dataUserLogin = <String>[];
  var jobModels = <JobModel>[];

  @override
  void initState() {
    super.initState();
    dataUserLogin = widget.dataUserLogins;
    readDataJob();
  }

  Future<void> readDataJob() async {
    if (jobModels.isNotEmpty) {
      jobModels.clear();
    }

    final idofficer = dataUserLogin[3];
    print('idofficer=$idofficer');
    String path =
        'https://www.androidthai.in.th/egat/getUserWhereIdOfficerKrit.php?isAdd=true&idofficer=$idofficer';

    await Dio().get(path).then((value) {
      print('value ==> $value');

      var result = json.decode(value.data);
      for (var element in result) {
        JobModel jobModel = JobModel.fromMap(element);
        print('Job ==> ${jobModel.job}');

        if (jobModel.status == 'start') {
          jobModels.add(jobModel);
        }
      }
      setState(() {});
    }); // ดึง api เข้ามาในเครื่อง
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          showTitle(head: 'ชื่อพนักงาน:', value: dataUserLogin[1]),
          showTitle(head: 'ตำแหน่ง:', value: dataUserLogin[2]),
          jobModels.isEmpty
              ? const Text(
                  'No Job',
                  style: TextStyle(fontSize: 40),
                ) //ShowProgress()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: jobModels.length,
                  // itemCount เรียงข้อมูลของตัวแปล
                  // .length นับขนาดของโมเดล
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                Detail(jobModel: jobModels[index]),
                          )).then((value) {
                        readDataJob();
                      });
                    },
                    child: showTitle(
                      head: 'ชื่องาน',
                      value: jobModels[index].job,
                      detail: MyCalculate().cutWord(
                        word: jobModels[index].detail,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

// โค๊ดเรียกชื่อพนักงานกับ value ของพนักงาน
  Card showTitle(
      {required String head, required String value, String? detail}) {
    //กำหนดตัวแปลแล้วเอาไปโชว์ในตัวเรียน method ด้านบน
    return Card(
      //ทำให้มีเส้นใต้
      child: Padding(
        padding: const EdgeInsets.all(8.0), //ล้อมกรอบด้าย padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: ShowText(
                    text: head,
                    textStyle: MyConstant().h3Style(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: ShowText(
                    text: value, //ดึงข้องมูล database มาโดยใช้ fill ที่ 1
                    textStyle: MyConstant().h3Style(),
                  ),
                ),
              ],
            ),
            detail == null
                ? const SizedBox()
                : Container(
                    margin: const EdgeInsets.only(top: 9, bottom: 9),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: ShowText(
                      text: detail,
                      textStyle: MyConstant().h4Style(),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
