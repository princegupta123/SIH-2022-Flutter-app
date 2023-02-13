import 'dart:convert';

class Teacher{
  late final String empNo;
  late String name;
  late String schoolId;
  late String phoneNumber;
  late String emailId;
  late String fatherName;
  late String department;
  Teacher({required this.empNo,required this.name,required this.fatherName,required this.schoolId,required this.department,this.emailId='',this.phoneNumber=''});
  Teacher.fromJson(Map<String, dynamic> json) {
    empNo = json['empNo'];
    name = json['name'];
    schoolId = json['schoolId'];
    phoneNumber = json['phoneNumber'];
    emailId = json['emailId'];
    fatherName = json['fatherName'];
    department = json['department'];
  }
}
Teacher Teacherjson(String str) =>
    Teacher.fromJson(json.decode(str));
