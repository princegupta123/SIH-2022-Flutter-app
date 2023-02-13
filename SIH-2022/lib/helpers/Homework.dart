import 'dart:convert';

class Homework{
  late String teacherName;
  late String subjectName;
  late DateTime homeworkDate;
  late String homeworkContent;
  late String kakshaId;
  Homework({required this.teacherName,required this.subjectName,required this.homeworkContent,required this.homeworkDate,required this.kakshaId});
  Homework.fromJson(Map<String, dynamic> json) {
    teacherName = json['teacherName'];
    subjectName = json['subjectName'];
    homeworkDate = json['homeworkDate'];
    homeworkContent = json['homeworkContent'];
    kakshaId = json['kakshaId'];
  }
}

Homework Homeworkjson(String str) =>
    Homework.fromJson(json.decode(str));