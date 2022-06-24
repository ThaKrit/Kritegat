// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kritegat/models/job_model.dart';
import 'package:kritegat/utility/my_constant.dart';
import 'package:kritegat/utility/my_dialog.dart';
import 'package:kritegat/widget/show_button.dart';
import 'package:kritegat/widget/show_icon_button.dart';
import 'package:kritegat/widget/show_image.dart';
import 'package:kritegat/widget/show_text.dart';

class Detail extends StatefulWidget {
  final JobModel jobModel;
  const Detail({
    Key? key,
    required this.jobModel,
  }) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  JobModel? jobModel;
  File? file;

  @override
  void initState() {
    super.initState();
    jobModel = widget.jobModel;
  }

  Future<void> processTakePhoto({required ImageSource imageSource}) async {
    var result = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 800,
      maxHeight: 800,
    );

    if (result != null) {
      file = File(result.path);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: ShowText(
          text: jobModel!.job,
          textStyle: MyConstant().h3Style(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: MyConstant.dark,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints boxConstraints) {
        return ListView(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            newImage(boxConstraints),
            newDetail(boxConstraints),
            newMap(boxConstraints),
            btnUpload(),
            //   ],
            // ),
          ],
        );
      }),
    );
  }

  ShowButton btnUpload() {
    return ShowButton(
        label: 'Upload Image',
        pressFunc: () {
          if (file == null) {
            MyDialog(context: context).normalDialog(
                title: 'Error !! Non Image', subTitle: 'Please Take Photo');
          } else {
            processUploadImage();
          }
        });
  }

// เอา Google Map มาโชว์
  Row newMap(BoxConstraints boxConstraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          width: boxConstraints.maxWidth * 0.5,
          height: boxConstraints.maxHeight * 0.5,
          child: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                double.parse(jobModel!.lat),
                double.parse(jobModel!.lng),
                //double.parse คือการเปลี่ยนค่า string เป็น double เพราะ lat lng ต้องการค่าที่เป็นตัวเลขมีจุด
              ),
              zoom: 16,
            ),
            onMapCreated: (value) {},
          ),
        ),
      ],
    );
  }

//เอา Detail เข้ามาโชว์
  Row newDetail(BoxConstraints boxConstraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          width: boxConstraints.maxWidth * 0.8,
          child: ShowText(
            text: jobModel!.detail,
            textStyle: MyConstant().h3Style(),
          ),
        ),
      ],
    );
  }

// เอา image เข้ามาโชว์
  Row newImage(BoxConstraints boxConstraints) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 36, bottom: 16),
          width: boxConstraints.maxWidth * 0.6,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: file == null
                    ? const ShowImage(
                        path: 'images/image.png',
                      )
                    : Image.file(file!),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: ShowIconbtn(
                    iconData: Icons.add_a_photo,
                    pressFunc: () {
                      MyDialog(context: context).normalDialog(
                          label: 'Camara',
                          label2: 'Gallery',
                          pressFunc: () {
                            processTakePhoto(imageSource: ImageSource.camera);
                            Navigator.pop(context);
                          },
                          pressFunc2: () {
                            processTakePhoto(imageSource: ImageSource.gallery);
                            Navigator.pop(context);
                          },
                          title: 'Source Image!?',
                          subTitle: 'Please Tap Camera or Gallery');
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }

// Process Upload image
  Future<void> processUploadImage() async {
    String path = 'https://www.androidthai.in.th/egat/saveFilekrit.php';
    String nameFile = 'image${Random().nextInt(1000000)}.jpg';
    Map<String, dynamic> map = {};
    map['file'] = await MultipartFile.fromFile(file!.path, filename: nameFile);
    FormData data = FormData.fromMap(map);
    await Dio().post(path, data: data).then((value) async {
      String urlImage =
          'https://www.androidthai.in.th/egat/kritimage/$nameFile';

      print('Upload Success urlImage = $urlImage');

      String pathAPI =
          'https://www.androidthai.in.th/egat/editPathStatusWhereId.php?isAdd=true&id=${jobModel!.id}&pathimage=$urlImage';
      await Dio().get(pathAPI).then((value) {
        Navigator.pop(context);
      });
    });
  }
}
