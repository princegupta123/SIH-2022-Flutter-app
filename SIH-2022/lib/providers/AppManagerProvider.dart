import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih/modal/Admin.dart';

import '../modal/AppManager.dart';


class AppManagerProvider with ChangeNotifier{
  late AppManager loggedInAppManager=AppManager(schoolName: 'RPS CET', schoolId: 'SCH4297');
  List<Admin> adminList = [Admin(adminId: 'adm123', schoolId: 'SCH4297', emailId: 'admin@gmail.com', phoneNumber: '123-456', adminName: 'Jack Sparrow')];
  void initialiseloggedInAppManager(AppManager user){
    this.loggedInAppManager = user;
    notifyListeners();
  }

  void updateSchoolDetails(AppManager newdetails){
    loggedInAppManager = newdetails;
    notifyListeners();
  }
  //vier
  void addAdmin(Admin newAdmin){
    adminList.add(newAdmin);
    notifyListeners();
  }
  void removeAdmin(String adminId){
    adminList.removeAt(adminList.indexWhere((element) => element.adminId==adminId));
    notifyListeners();
  }
  List<Admin> get viewAdmin => adminList;

}