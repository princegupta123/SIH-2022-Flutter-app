import 'dart:convert';

class Kaksha{
  late String kakshaName;
  late String kakshaId;
  late List<String>? subjects;
  late List<String>? teachersId;
  late String schoolId;
  Kaksha(  {required this.kakshaName,required this.kakshaId,required this.schoolId,this.subjects=null,this.teachersId=null});
  Kaksha.fromJson(Map<String, dynamic> json) {
    kakshaName = json['kakshaName'];
    kakshaId = json['kakshaId'];
    schoolId = json['schoolId'];
    subjects = json['subjects'];
    teachersId = json['teachersId'];

  }
}

Kaksha Kakshajson(String str) =>
    Kaksha.fromJson(json.decode(str));