class LoginRequest {
  LoginRequest({
    required this.username,
    required this.password,
    required this.userRole,
  });
  late final String username;
  late final String password;
  late final int userRole;
  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['userId'];
    password = json['password'];
    userRole = json['userRole'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['userId'] = username;
    _data['password'] = password;
    _data['userRole'] = userRole;
    return _data;
  }
}
class UploadHomeWork{

  //Teacherid,text,subjectname,classid,schoolid,date
  late final String teacherId;
  late final String content;
  late final String subjectName;
  late final String kakshaId;
  late final DateTime dateOfHomework;
  UploadHomeWork({required this.teacherId,required this.subjectName,required this.kakshaId,required this.content,required this.dateOfHomework});
  UploadHomeWork.fromJson(Map<String, dynamic> json) {
    teacherId = json['teacherId'];
    content = json['content'];
    subjectName = json['subjectName'];
    kakshaId = json['kakshaId'];
    dateOfHomework = json['dateOfHomework'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['teacherId'] = teacherId;
    _data['content'] = content;
    _data['subjectName'] = subjectName;
    _data['kakshaId'] = kakshaId;
    _data['dateOfHomework'] = dateOfHomework;
    return _data;
  }
}

class FetchKakshaofSchool{

  //schoolid
}

class FetchSubjectofKaksha{

  //kakshaid,schoolid
}

class StudentofKaksha{

  //kakshaid,schoolid
}

