import 'dart:convert';

class Admin{
  late final String schoolId;
  //late String schoolName;
  //late String schoolImage;
  late String adminId;
  late String adminName;
  late String phoneNumber;
  late String emailId;


  Admin({required this.adminId,required this.schoolId,required this.emailId,required this.phoneNumber,required this.adminName});
  Admin.fromJson(Map<String, dynamic> json) {
    adminId = json['adminId'];
    adminName = json['adminName'];
    schoolId = json['schoolId'];
    phoneNumber = json['phoneNumber'];
    emailId = json['emailId'];
  }
}
Admin Adminjson(String str) =>
    Admin.fromJson(json.decode(str));
