import 'dart:convert';

class AppManager{
  late final String schoolId;
  late String schoolName;
  late String schoolImage;

  AppManager({required this.schoolName,required this.schoolId,this.schoolImage=''});
  AppManager.fromJson(Map<String, dynamic> json) {
    schoolName = json['schoolName'];
    schoolImage = json['schoolImage'];
    schoolId = json['schoolId'];

  }
}
AppManager AppManagerjson(String str) =>
    AppManager.fromJson(json.decode(str));
