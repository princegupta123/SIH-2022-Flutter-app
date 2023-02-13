import 'dart:convert';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sih/modal/Admin.dart';
import 'package:sih/modal/AppManager.dart';
import 'package:sih/modal/Teacher.dart';
import 'package:sih/modal/request.dart';
import 'package:sih/modal/response.dart';
import 'package:sih/providers/AdminProvider.dart';
import 'package:sih/providers/AppManagerProvider.dart';
import 'package:sih/providers/TeacherProvider.dart';
import 'package:sih/providers/studentProvider.dart';

import '../config.dart';
import '../modal/Student.dart';

class ApiService {
  static var client = http.Client();
  static Future<void> login(BuildContext context,LoginRequest model) async{
    try{
      Map<String,String> requestHeader = {'Content-Type': 'application/json'};
      //var url = Uri.http(Config.apiUrl);
      print(Config.apiUrl);
      var response = await client.post(Uri.parse(Config.loginApi),
          headers: requestHeader, body: jsonEncode(model.toJson()));


      if (response.statusCode == 200) {
         String jwtToken = loginResponseJson(response.body).access;

        switch(model.userRole){
          case 1:
            Map<String,dynamic> decodedToken = JwtDecoder.decode(jwtToken);

            //AppManager model=AppManager(schoolName: decodedToken["schoolName"], schoolId: decodedToken["schoolId"],schoolImage: decodedToken["schoolImage"]);

           //Provider.of<AppManagerProvider>(context,listen: false).initialiseloggedInAppManager(model);
            break;
          case 2:
            Map<String,dynamic> decodedToken = JwtDecoder.decode(jwtToken);
            //Admin model = Admin(adminId: decodedToken["hodId"], schoolId: decodedToken["schoolId"], emailId: decodedToken["email"], phoneNumber: decodedToken["phone"], adminName: decodedToken["hodName"]);
            //Provider.of<AdminProvider>(context,listen: false).initialiseloggedAdmin(model);
            break;
          case 3:
            Map<String,dynamic> decodedToken = JwtDecoder.decode(jwtToken);
            //Teacher model = Teacher(empNo: decodedToken["empNo"], name: decodedToken["empName"], fatherName: decodedToken["fatherName"], schoolId: decodedToken["schoolId"], department: decodedToken["department"]);
            //Provider.of<TeacherProvider>(context,listen: false).initialiseloggedInTeacher(model);
            break;
          case 4:
            Map<String,dynamic> decodedToken = JwtDecoder.decode(jwtToken);
            //Student model = Student(admNo: decodedToken["admNo"], name: decodedToken["name"], schoolId: decodedToken["schoolId"], fatherName: decodedToken["fatherName"], kakshaId: decodedToken["kakshaId"]);
            //Provider.of<StudentProvider>(context,listen: false).initialiseloggedInStudent(model);
            break;


        }

        // return true;
      } else {
        //return false;
      }
    }catch (error) {
      rethrow;
    }
  }
  static Future<void> fetchHomework (BuildContext,String userId,DateTime homeworkDate)async {
    try{
      Map<String,String> requestHeader = {'Content-Type': 'application/json'};
      var url = Uri.http(Config.apiUrl, Config.fetchHomework);
      var response = await client.post(url,
          headers: requestHeader, body: json.encode({
            "userId":userId,
            "Date":homeworkDate
          }));
      if(response.statusCode==200){
        //list 2d??
      }
      else{

      }
    }catch (error) {
      rethrow;
    }
  }

  static Future<bool> uploadHomeworkApi ( BuildContext context , UploadHomeWork model) async{
    try{
      Map<String,String> requestHeader = {'Content-Type': 'application/json'};
      var url = Uri.http(Config.apiUrl, Config.uploadHomework);
      var response = await client.post(url,headers:  requestHeader,body: jsonEncode(model.toJson()));
      if(response.statusCode==200){
        return true;
      }
      return false;
    }catch (error) {
      rethrow;
    }
  }


  /*static Future<bool> viewKakshaOfSchool (BuildContext context,String schoolId) async{
    try{
      Map<String,String> requestHeader = {'Content-Type': 'application/json'};
      var url = Uri.http(Config.apiUrl, Config.kakshaOfSchool);
      var response = await client.get(url,)


      if(response==200){
        //decode json response and return -1,0,1

      }
      else{

      }

    }catch (error) {
      rethrow;
    }

  }*/

  /*static Future<int> todayAttendance(BuildContext context,String userId,DateTime todayDate,String schoolId)async {
    try{
      Map<String,String> requestHeader = {'Content-Type': 'application/json'};
      var url = Uri.http(Config.apiUrl, Config.todayAttendance);
      var response = await client.post(url,
          headers: requestHeader, body: json.encode({
            "userId":userId,
            "Date":todayDate,
            "schoolId":schoolId
          }));
      if(response.statusCode==200){
        //decode json response and return -1,0,1
      }
      else{

      }
    }catch (error) {
      rethrow;
    }
  }*/
  //download circular
  //material
}