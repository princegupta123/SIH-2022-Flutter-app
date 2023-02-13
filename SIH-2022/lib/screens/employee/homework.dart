import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih/helpers/Kaksha.dart';
import 'package:sih/providers/AdminProvider.dart';

import '../../providers/TeacherProvider.dart';
import '../../services/apiService.dart';

class UploadHomework extends StatefulWidget {
  const UploadHomework({Key? key}) : super(key: key);
  static const routeName = '/UploadHomework';
  @override
  _UploadHomeworkState createState() => _UploadHomeworkState();
}

class _UploadHomeworkState extends State<UploadHomework> {
  List<Kaksha> allKakshaOfSchool = [];
  final GlobalKey<FormState> _formKey = GlobalKey();
  final hwcontroller = TextEditingController();
  Future<void> save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

  }
  DateTime selectedDate = DateTime.now();
  String schoolId='';
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }
  String selectedkakshaName = '';
  //Map<String,List<String>> kaksha = {'I':['English','Hindi'], 'II':['English','Hindi','Maths'], 'III':['English','Hindi','Maths','Evs']}; //kaksha id... or name
  List<String> kakshaNames=[];
  List<String> subjects=[];
  String selectdSubject = '';
  Kaksha? selectedKaksha ;
  setsubjects( k){

    selectedKaksha= allKakshaOfSchool[allKakshaOfSchool.indexWhere((element) => element.kakshaName==k)];
    setState(() {
      subjects = allKakshaOfSchool[allKakshaOfSchool.indexWhere((element) => element.kakshaName==k)].subjects!;
      selectdSubject=subjects[0];
    });

  }
  setkakshaName(){
    allKakshaOfSchool.forEach((element) {
      kakshaNames.add(element.kakshaName);
    });
   setState(() {
     selectedKaksha=allKakshaOfSchool[0];
     selectedkakshaName=kakshaNames[0];
   });
  }
  var isadding = false;
  var isSaved = false;
  @override
  void initState() {
    //TODO api call to FetchKakshaofSchool
    //set List<Kaksha> and then kakshaName
    schoolId = Provider.of<TeacherProvider>(context,listen: false).loggedInTeacher.schoolId;
    //ApiService.viewKakshaOfSchool(context, schoolId);
    allKakshaOfSchool = Provider.of<AdminProvider>(context,listen: false).viewKaksha;
    setkakshaName();
    //print(kakshaNames);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final loggedInTeacher = Provider.of<TeacherProvider>(context).getLoggedInTeacher;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Homework',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DropdownButton(items:
                      kakshaNames.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(), onChanged: (newvalue){
                      print(newvalue);
                      setsubjects( newvalue );
                      setState(() {
                        selectedkakshaName = newvalue.toString() ;
                        if(!isadding){
                          isadding=true;
                        }
                      });

                  },
                  onTap: (){
                    //TODO api call to fetch subjects of this class id
                    //set to subjectname and selectedsubject to [0]

                  }
                  ,value: selectedkakshaName),
                  DropdownButton(items: subjects.map((e){
                    return DropdownMenuItem(child: Text(e),value: e,);
                  }).toList(), onChanged: (newvalue){
                    setState(() {
                      selectdSubject=newvalue.toString();
                    });
                  },value: selectdSubject,)
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Select Date : '),
                  ElevatedButton(
                      onPressed: (){
                        _selectDate(context);

                      },
                      child: Text(selectedDate.toString())),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              isadding
                  ? Card(
                      margin: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.01,
                          horizontal: MediaQuery.of(context).size.width * 0.02),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02,
                            vertical:
                                MediaQuery.of(context).size.height * 0.02),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(),
                          color: Colors.blue,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${loggedInTeacher.name} - ',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  selectdSubject,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),

                              ],
                            ),
                            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                              Text(
                                '($selectedDate)',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],),
                            Divider(
                              color: Colors.white,
                              thickness: 2,
                              endIndent:
                                  MediaQuery.of(context).size.width * 0.02,
                              indent: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Form(
                              key: _formKey,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 4,vertical: 5),
                                height: MediaQuery.of(context).size.height*0.3,
                                color: Colors.white,
                                child: TextFormField(
                                  expands: true,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    labelText: 'Write here...',

                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: BorderSide()),
                                  ),
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please write something';
                                    }
                                  },
                                  controller: hwcontroller,
                                ),
                              ),


                            ),
                            SizedBox(height: 5,),
                            ElevatedButton(onPressed: (){
                              save();
                              setState(() {
                                isSaved=true;
                                isadding=false;
                              });
                            }, child: Text('Save'))
                          ],
                        ),
                      ),
                    )
                  : isSaved
                      ? Text('Saved successfully')
                      : Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
