import 'dart:convert';

import 'package:sih/modal/Playlist.dart';

class Student{
  late final String admNo;
  late String name;
  late String kakshaId;
  late String phoneNumber;
  late String emailId;
  late String fatherName;
  late String schoolId;
  late List<Playlist>? myqrplaylist;
  Student({this.myqrplaylist=null,required this.admNo,required this.name,required this.schoolId,required this.fatherName,required this.kakshaId,this.emailId='',this.phoneNumber=''});
  Student.fromJson(Map<String, dynamic> json) {
    admNo = json['admNo'];
    name = json['name'];
    kakshaId = json['kakshaId'];
    phoneNumber = json['phoneNumber'];
    emailId = json['emailId'];
    fatherName = json['fatherName'];
    schoolId = json['schoolId'];
    myqrplaylist = json['myqrplaylist'];
  }
}
Student Studentjson(String str) =>
    Student.fromJson(json.decode(str));

//TODO tojson???required by teacher..