import 'dart:convert';

import 'package:sih/helpers/Kaksha.dart';

LoginResponse loginResponseJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

class LoginResponse {
  LoginResponse({
    //required this.message,    
    required this.refresh,
    required this.access,
    // required this.expirydate,
  });
  //late final String message;
  late final String refresh;
  late final String access;
  //late final DateTime expirydate;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    //message = json['message'];
    refresh = json['token'];
    access = json['userId'];
    // expirydate = json['expirydate'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    //_data['message'] = message;

    _data['token'] = refresh;
    _data['userId'] = access;
    //_data['expirydate'] = expirydate;
    return _data;
  }
}



class HomeworkResponse{

  //teachername,subjectname,text,date
}
viewKakshaOfSchoolResponse viewKakshaOfSchoolResponseJson(String str) =>
    viewKakshaOfSchoolResponse.fromJson(json.decode(str));
class viewKakshaOfSchoolResponse{
  viewKakshaOfSchoolResponse({required this.kakshaList});
  late List<Kaksha> kakshaList ;

  viewKakshaOfSchoolResponse.fromJson(List<Map<String, dynamic>> json) {
    kakshaList = [];
    json.forEach((element) {
      kakshaList.add(Kaksha.fromJson(element));
    });

  }



}


class SubjectofKakshaResponse{

  //List of Subjects
}

class StudentofKakshaResponse{

  //list of custom model..id,name,att.status
}

class saveAttendance{

}