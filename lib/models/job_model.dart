// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

class JobModel {
  final String id;
  final String idofficer;
  final String job;
  final String detail;
  final String lat;
  final String lng;
  final String pathimage;
  final String status;
  JobModel({
    required this.id,
    required this.idofficer,
    required this.job,
    required this.detail,
    required this.lat,
    required this.lng,
    required this.pathimage,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idofficer': idofficer,
      'job': job,
      'detail': detail,
      'lat': lat,
      'lng': lng,
      'pathimage': pathimage,
      'status': status,
    };
  }

  factory JobModel.fromMap(Map<String, dynamic> map) {
    return JobModel(
      id: map['id'] as String,
      idofficer: map['idofficer'] as String,
      job: map['job'] as String,
      detail: map['detail'] as String,
      lat: map['lat'] as String,
      lng: map['lng'] as String,
      pathimage: map['pathimage'] as String,
      status: map['status'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobModel.fromJson(String source) => JobModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
