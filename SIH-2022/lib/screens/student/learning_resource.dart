
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:sih/download_provider.dart';
import 'package:provider/provider.dart';

import '../../modal/Playlist.dart';
import '../../modal/Student.dart';
import '../../providers/studentProvider.dart';
class StudentLearningResources extends StatefulWidget {
  //const StudentHomework({Key? key}) : super(key: key);
  static const routeName = '/studentLearningResources';

  @override
  State<StudentLearningResources> createState() => _StudentLearningResourcesState();
}

class _StudentLearningResourcesState extends State<StudentLearningResources> {
  //List of files or urls//sort by date
  TextEditingController friendId = TextEditingController();
  var isSavedd=false;
  List<Playlist> myallPlaylist = [];
  List<String> fileurls=['https://www.sih.gov.in/pdf/Student_FAQs.pdf'];
  List<String> filenames=[];
  String dir='/sdcard/download/';
  List<bool> exist=[];
  var isloading =true;
  var isSelected = false;
  var mycolor=Colors.white;
  void toggleSelection(int index) {
    setState(() {
      if (isSelected) {
        mycolor=Colors.white;
        isSelected = false;
        selectedforplaylist[index]=1;
      } else {
        mycolor=Colors.grey;
        isSelected = true;
      }
    });
  }
  List<Student> allStudents = [
  Student(admNo: 's234',fatherName: 'Father Name',kakshaId: 'VII-A',name: 'Alice',schoolId: '20395',emailId: 'abc@gmail.com',phoneNumber: '129393'),
  Student(admNo: 's123',fatherName: 'Father Name',kakshaId: 'VIII-B',name: 'Charlie',schoolId: '20395',emailId: 'abc@gmail.com',phoneNumber: '129393')
  ];

  var isallplaylistEmpty;
  @override
  void initState() {
    fileurls = Provider.of<StudentProvider>(context,listen: false).studyMaterialFiles;
    fileurls.forEach((element) {
      filenames.add(element.substring(element.lastIndexOf('/')+1));
    });
    myallPlaylist = Provider.of<StudentProvider>(context,listen: false).getSavedQrPlaylist;
    opendownload().then((value) {
      setState(() {
        isloading =false;
      });
    });
    for(int i=0;i<fileurls.length;i++){
      selectedforplaylist.add(0);
    }
    if(myallPlaylist.isEmpty){
      isallplaylistEmpty = true;
    }
    else{
      isallplaylistEmpty = false;
    }

    //Provider.of<StudentProvider>(context,listen: false).loggedInStudent.myqrplaylist![0]= Playlist(playlistId: '123457', playlistName: "PlayList 1", savedQrinPlaylist: urlsforplaylist, schoolId: "SCH4297", kakshaId:"K1132" );
    super.initState();

  }
//or map of filename and url
  Future<void> opendownload() async {
    String savePath =dir;
    filenames.forEach((element)async {
      savePath=savePath+ element;
      if (await File(savePath).exists()) {
        exist.add(true);
      }
      else{
        exist.add(false);
      }
    });

    return ;

  }
  void _openFile( filepath) {
    OpenFile.open(filepath);
  }
  List<int> selectedforplaylist = [];
  List<String> urlsforplaylist=[];

  @override
  Widget build(BuildContext context) {
    final loggedInStudent = Provider.of<StudentProvider>(context).loggedInStudent;
    fileurls = Provider.of<StudentProvider>(context).studyMaterialFiles;
    myallPlaylist  = Provider.of<StudentProvider>(context).getSavedQrPlaylist;
    var fileDownloaderProvider =
    Provider.of<FileDownloaderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learing Resources',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
         child: isloading?Center(child: LinearProgressIndicator(),): Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, index)
                {
                  return Card(
                    color: mycolor,
                    child: ListTile(
                      onLongPress:(){ toggleSelection(index) ;},
                      enabled: true,
                        selected: isSelected,leading: Text(
                      '1.',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    title: Text(
                      filenames[index],
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold

                      ),
                    ),
                    trailing:TextButton(onPressed: ()   {
                      if(exist[index]){
                        _openFile(dir+filenames[index]);
                      }
                      else{
                        //start downloading show percentage
                        fileDownloaderProvider
                            .downloadFile(fileurls[index], filenames[index])
                            .then((onValue) {
                          setState(() {
                            exist[index]=true;
                          });
                        });
                      }
                    },child:exist[index]==true?Text('Open'):downloadProgress(),) ,),
                  );
                },
                itemCount: filenames.length,
              ),
              SizedBox(height: 5,),
              ElevatedButton(onPressed: (){
                //print("hi");
                for(int i=0;i<selectedforplaylist.length;i++){
                  if(selectedforplaylist[i]==1){
                    urlsforplaylist.add(fileurls[i]);
                  }
                }

                Provider.of<StudentProvider>(context,listen: false).addToPlaylist(Playlist(playlistId: '123457', playlistName: "PlayList 1", savedQrinPlaylist: urlsforplaylist, schoolId: loggedInStudent.schoolId, kakshaId:loggedInStudent.schoolId ));
                setState(() {
                  isSavedd=true;
                });
                }, child: Text(isSavedd?'Saved':'Create new Playlist')),
                SizedBox(height: 10,),
              !isallplaylistEmpty? Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                    Text('My Saved Playlist',style: TextStyle(fontWeight: FontWeight.bold),)
                  ],),
                  SizedBox(height: 5,),
                  ListView.builder(itemBuilder: (context, index) {
                    return ListTile(
                      leading: Text('${index+1}'),
                      title: Text(myallPlaylist[index].playlistName),
                      trailing: IconButton(
                        icon: Icon(Icons.share),
                        onPressed: (){
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                AlertDialog(
                                  title: const Text('Enter UserId'),
                                  content:TextField(controller: friendId,),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        //Provider.of<StudentProvider>(context,listen: false).viewAllStudents.firstWhere((element) => element.admNo==friendId.text).myqrplaylist!.add(myallPlaylist[index]);

                                        Navigator.pop(
                                            context, friendId.text);

                                      },

                                      child: const Text('Share'),
                                    ),
                                  ],
                                ),
                          );
                        },
                      ),
                    );
                  },
                    shrinkWrap: true,
                    itemCount: myallPlaylist.length,
                  ),
                ],
              )
                  :Text(''),



             
            ],
          ),
        ),
      ) ,
    );
  }
  Widget downloadProgress() {
    var fileDownloaderProvider =
    Provider.of<FileDownloaderProvider>(context, listen: true);

    return new Text(
      downloadStatus(fileDownloaderProvider),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  downloadStatus(FileDownloaderProvider fileDownloaderProvider) {
    var retStatus = "";

    switch (fileDownloaderProvider.downloadStatus) {
      case DownloadStatus.Downloading:
        {
          retStatus =
              fileDownloaderProvider.downloadPercentage.toString() +
                  "%";
        }
        break;
      case DownloadStatus.Completed:
        {
          retStatus = "done";
        }
        break;
      case DownloadStatus.NotStarted:
        {
          retStatus = "Download";
        }
        break;
      case DownloadStatus.Started:
        {
          retStatus = "0%";
        }
        break;
    }

    return retStatus;
  }
}
