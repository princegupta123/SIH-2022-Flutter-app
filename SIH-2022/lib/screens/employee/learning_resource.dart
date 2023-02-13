import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/Kaksha.dart';
import '../../providers/AdminProvider.dart';
import '../../providers/TeacherProvider.dart';

class UploadLearningResources extends StatefulWidget {
  const UploadLearningResources({Key? key}) : super(key: key);
  static const routeName = '/UploadLearningResources';
  @override
  _UploadLearningResourcesState createState() => _UploadLearningResourcesState();
}

class _UploadLearningResourcesState extends State<UploadLearningResources> {
  Kaksha? selectedKaksha;
  String selectedkakshaName = '';
  List<String> kakshaNames=[];
  List<Kaksha> kaksha = [];  //kaksha id... or name
  DateTime uploadDate = DateTime.now();
  File? file;
  var ispicked=false;
  var isuploaded=false;
  List<Kaksha> allkakshaOfSchool=[];
  setkakshaName(){
    allkakshaOfSchool.forEach((element) {
      kakshaNames.add(element.kakshaName);
    });
    setState(() {
      selectedKaksha=allkakshaOfSchool[0];
      selectedkakshaName =kakshaNames[0];
    });

  }
  _pickFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
       file = File(result.files.single.path!);
       setState(() {
         ispicked=true;
       });
    } else {
      // User canceled the picker
      print('cannot pick file');
    }
  }

  @override
  void initState() {
    final loggedInTeacher = Provider.of<TeacherProvider>(context,listen:false).getLoggedInTeacher;
    // TODO: api call to fetch list of kaksha of this schoolid
    //assign it to kaksha
    //assign selectedKaksha to kaksha[0].kakshaName
    allkakshaOfSchool = Provider.of<AdminProvider>(context,listen: false).viewKaksha;
    selectedKaksha= allkakshaOfSchool[0];
    setkakshaName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload Study_Material',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Select Class : '),
                  DropdownButton(items:
                  kakshaNames.map((e) {
                    return DropdownMenuItem(child: Text(e),value: e,);
                  }).toList(), onChanged: (newvalue){
                    setState(() {

                      selectedkakshaName = newvalue.toString();
                    });
                  },value: selectedkakshaName),




                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed:(){
                      _pickFile();
                      if(file!=null){
                        setState(() {
                          ispicked=true;
                        });
                      }
                    } ,
                    child: Text(
                      'Chooose File',
                      style: TextStyle(fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.white,
                      primary: Colors.black,
                      minimumSize: Size(150, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(30)),
                    ),
                  ),
                  IconButton(onPressed: (){
                    //all gone ok
                    setState(() {
                      ispicked=false;
                      isuploaded=true;
                    });
                  }, icon: Icon(Icons.file_upload,color: Colors.black45,)),

                ],
              ),
              //show chosen file name
              SizedBox(height: 10,),
              ispicked?Text(file!.path):
                  isuploaded?Text('uploaded successfully'):Text('No file chosen ')
            ],
          ),
        ),
      ),
    );
  }
}
