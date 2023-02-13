import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modal/Student.dart';
import '../modal/Teacher.dart';

class TeacherProvider with ChangeNotifier {
  late Teacher loggedInTeacher = Teacher(
      empNo: '232',
      name: 'Einstein',
      fatherName: 'Father Name',
      schoolId: 'SCH4297',
      department: 'Teaching Staff');
  late List<Student> studentsList = [
    Student(
        admNo: '234',
        fatherName: 'Father Name',
        kakshaId: 'VII-A',
        name: 'Rohan',
        schoolId: 'SCH4297',
        emailId: 'abc@gmail.com',
        phoneNumber: '129393'),
    Student(
        admNo: '789',
        fatherName: 'Father Name',
        kakshaId: 'VII-A',
        name: 'Sohan',
        schoolId: 'SCH4297',
        emailId: 'def@gmail.com',
        phoneNumber: '129393')
  ];
  void initialiseloggedInTeacher(Teacher user) {
    this.loggedInTeacher = user;
    notifyListeners();
  }

  void addStudent(Student newStudent) {
    studentsList.add(newStudent);
    notifyListeners();
  }
//upload hw;atnd;learning;circular;
  void removeStudent(Student removeStudent) {
    studentsList.removeAt(studentsList
        .indexWhere((element) => element.admNo == removeStudent.admNo));
    notifyListeners();
  }

  List<Student> get getStudentsList => studentsList;
  Teacher get getLoggedInTeacher => loggedInTeacher;
}

