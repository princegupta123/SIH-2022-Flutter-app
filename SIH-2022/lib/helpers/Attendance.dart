import 'dart:convert';

class Attendance{
  late String studentId;
  late String kakshaId;
  late DateTime attendanceDate;
  late String schoolId;
  Attendance({required this.studentId,required this.kakshaId,required this.schoolId,required this.attendanceDate});
  Attendance.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    kakshaId = json['kakshaId'];
    attendanceDate = json['attendanceDate'];
    schoolId = json['schoolId'];

  }
}

Attendance Attendancejson(String str) =>
    Attendance.fromJson(json.decode(str));

