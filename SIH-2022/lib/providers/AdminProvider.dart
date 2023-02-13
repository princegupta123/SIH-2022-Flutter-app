import 'package:flutter/material.dart';
import 'package:sih/helpers/Kaksha.dart';
import 'package:sih/modal/Admin.dart';
import 'package:sih/modal/Teacher.dart';
class AdminProvider with ChangeNotifier{
  late Admin loggedInAdmin=Admin(adminId: 'adm123', schoolId: 'SCH4297', emailId: 'admin@gmail.com', phoneNumber: '123-456', adminName: 'Jack Sparrow');
  List<Teacher> teacherList = [Teacher(empNo: '232', name: 'Einstein', fatherName: 'Father Name', schoolId: '28395', department: 'Teaching Staff')];
  List<Kaksha> kakshaList = [Kaksha(kakshaName: 'I-A', kakshaId: 'k1132', schoolId: 'SCH4297',subjects: ['english','hindi'],teachersId: ['12','34'])];
  void initialiseloggedAdmin(Admin user){
    this.loggedInAdmin = user;
    notifyListeners();
  }

  void addTeacher(Teacher newTeacher){
    teacherList.add(newTeacher);
    notifyListeners();
  }
  void addKaksha(Kaksha newKaksha){
    kakshaList.add(newKaksha);
    notifyListeners();
  }
  //basically we are updating Class information...
  //first select class and then add/update/remove subject and teacher list

  //same for remove and addSubject...
  void updateSubject(Kaksha newData){
    kakshaList[kakshaList.indexWhere((element) => element.kakshaId==newData.kakshaId)] = newData;
  }
  void removeTeacher(String removeTeacher){
    teacherList.removeAt(teacherList.indexWhere((element) => element.empNo==removeTeacher));
    notifyListeners();
  }
  void removeKaksha(String kakshaId){
    kakshaList.removeAt(kakshaList.indexWhere((element) => element.kakshaId==kakshaId));
    notifyListeners();
  }
  List<Teacher> get viewTeacher => teacherList;
  List<Kaksha> get viewKaksha => kakshaList;

}