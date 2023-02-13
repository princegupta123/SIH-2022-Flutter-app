import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih/helpers/Homework.dart';
import 'package:sih/modal/Playlist.dart';

import '../helpers/qr.dart';
import '../modal/Student.dart';

class StudentProvider with ChangeNotifier{
  late Student loggedInStudent =Student(admNo: 's234',fatherName: 'Father Name',kakshaId: 'VII-A',name: 'Alice',schoolId: '20395',emailId: 'abc@gmail.com',phoneNumber: '129393');
  late List<Homework> homeworks=[Homework(kakshaId: "k1132",teacherName: 'Einstein', subjectName: 'Physics', homeworkContent: 'Learn Chapter 2', homeworkDate: DateTime.now())];
  late List<String> studyMaterial=['https://www.sih.gov.in/pdf/Student_FAQs.pdf'],circular=['https://www.sih.gov.in/pdf/Student_FAQs.pdf'];
  late int todaysAttendance =1;
  late List<QrCode> savedQr = [];
  late List<Playlist> savedPlaylist= [];
  late List<Student> allstudents= [
    Student(admNo: '234',fatherName: 'Father Name',kakshaId: 'VII-A',name: 'Alice',schoolId: '20395',emailId: 'abc@gmail.com',phoneNumber: '129393'),
    Student(admNo: '123',fatherName: 'Father Name',kakshaId: 'VII-A',name: 'Charlie',schoolId: '20395',emailId: 'abc@gmail.com',phoneNumber: '129393')
  ];
  void initialiseloggedInStudent(Student user){
    this.loggedInStudent = user;
    notifyListeners();
  }
  void addToPlaylist (Playlist newPlaylist){
    savedPlaylist.add(newPlaylist);
    notifyListeners();
  }
  void removeFromPlaylist(Playlist oldPlaylist){
    savedPlaylist.removeAt(savedPlaylist.indexWhere((element) => element.playlistId==oldPlaylist.playlistId));
    notifyListeners();
  }
  void initialisehomeworks(){

  }
  void initialisestudyMaterial(){

  }
  void initialiseCircular(){

  }
  void setTodaysAttendance(){

  }
  void addPlaylist(Playlist newplayist){

  }
  void saveQr(QrCode newQr){
    savedQr.add(newQr);
    notifyListeners();
  }
  void addQr(QrCode newQrCode){
    savedQrCodes.add(newQrCode);
    notifyListeners();
  }
  void removeQr(String qrCodeId){
    savedQrCodes.removeWhere((element) => element.qrId==qrCodeId);
    notifyListeners();
  }
  List<Playlist> get getSavedQrPlaylist => savedPlaylist;
  List<QrCode> get savedQrCodes => savedQr;
  Student get loggedInStudentUser =>loggedInStudent;
  List<Homework> get homeworksofUser=>homeworks;
  List<String> get studyMaterialFiles=>studyMaterial;
  List<String> get circularFiles=>circular;
  List<Student> get viewAllStudents=> allstudents;
  int get todaysAttendane=>todaysAttendance;
}