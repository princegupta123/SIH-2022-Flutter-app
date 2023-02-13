import 'dart:core';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih/helpers/Kaksha.dart';
import 'package:sih/providers/AdminProvider.dart';

import '../../modal/Teacher.dart';

class ManageSubjects extends StatefulWidget {
  const ManageSubjects({Key? key}) : super(key: key);
  static const routeName = '/ManageSubjects';
  @override
  _ManageSubjectsState createState() => _ManageSubjectsState();
}

class _ManageSubjectsState extends State<ManageSubjects> {
  TextEditingController subjectNameController = TextEditingController();
  TextEditingController teacherIdController = TextEditingController();
  List<String> subjects = [];
  List<String> teachersId = [];
  List<Kaksha> kakshaList = [];
  List<String> teacherNames = [];
  List<String> tempSubjects=[];
  List<String> tempTeacherIds=[];
   setSubjectsandTeacherId(String kakshaId) {
    setState(() {
      subjects = kakshaList[
              kakshaList.indexWhere((element) => element.kakshaId == kakshaId)]
          .subjects!;
      teachersId = kakshaList[
              kakshaList.indexWhere((element) => element.kakshaId == kakshaId)]
          .teachersId!;
    });
  }

  setTeachersName() {
    List<Teacher> teachers = Provider.of<AdminProvider>(context).teacherList;
    teachersId.forEach((element) {
      teacherNames.add(teachers.firstWhere((e) => element == e.empNo).name);
    });
  }

  removeupdate(int index) {
    setState(() {
      subjects.removeAt(index);
      teacherNames.removeAt(index);
    });
  }

  add() {}
  saveChanges() {}
  //a1: n^2 and a2:
  @override
  void initState() {
    kakshaList = Provider.of<AdminProvider>(context, listen: false).kakshaList;

    super.initState();
  }

  var isproceded = false;
  var addingnew = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    kakshaList = Provider.of<AdminProvider>(context).kakshaList;

    Kaksha? selectedKaksha = kakshaList.isNotEmpty ? kakshaList[0] : null;
    return Scaffold(body: Center(child: Text('Manage Subjects'),),);
    /*return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.school,
          color: Colors.black,
        ),
        title: Text(
          'Manage Subjects',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.1,
            ),
            Text('Add / remove or update Subjects of Class'),
            SizedBox(
              height: height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Select Class : '),
                DropdownButton(
                  value: selectedKaksha,
                  items: kakshaList.map((k) {
                    return DropdownMenuItem(
                      child: Text(k.kakshaName),
                      value: k,
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedKaksha = newValue as Kaksha?;
                    });
                  },
                ),
                ElevatedButton(onPressed: () {
                  setState(() {
                    isproceded=true;
                  });
                }, child: Text('Proceed')),
              ],
            ),
            SizedBox(
              height: height * 0.1,
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isproceded= false;
                        addingnew = true;
                      });
                    },
                    child: Text('Add More Fields')),
              ],
            ),
            isproceded
                ? subjects.isEmpty
                    ? Text('Start Adding Subjects by Pressing above Button')
                    : Column(
                        children: [
                          ListView.builder(
                            itemBuilder: (context, index) {
                              return Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(subjects[index]),
                                    Text(teacherNames[index]),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: removeupdate(index),
                                    ),
                                  ],
                                ),
                              );
                            },
                            shrinkWrap: true,
                            itemCount: subjects.length,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          addingnew
                              ? Column(
                                children: [
                                  Container(
                                      child: Form(
                                        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Subject Name',

                                              border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(16),
                                                  borderSide: BorderSide()),
                                            ),
                                            keyboardType: TextInputType.phone,
                                            controller: subjectNameController,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Please enter Subject Name';
                                              }
                                            },

                                          ),
                                          SizedBox(
                                            height: height * 0.01,
                                          ),
                                        ],),
                                      )
                                    ),


                        ],
                      )
                : Text('Select a Class to add Subjects')


      ],
      ),
    );*/
  }
}
