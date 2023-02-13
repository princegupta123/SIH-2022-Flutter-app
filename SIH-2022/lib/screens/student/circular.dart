
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:open_file/open_file.dart';
import 'package:sih/download_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/studentProvider.dart';
class Circular extends StatefulWidget {
  //const StudentHomework({Key? key}) : super(key: key);
  static const routeName = '/studentCircular';

  @override
  State<Circular> createState() => _CircularState();
}

class _CircularState extends State<Circular> {
  List<String> fileurls=['https://www.sih.gov.in/pdf/Student_FAQs.pdf'];
  List<String> filenames=[];
  String dir='/sdcard/download/';
  List<bool> exist=[];
  var isloading =true;
  @override
  void initState() {
    //TODO api call to initialise circulars
    fileurls=Provider.of<StudentProvider>(context,listen: false).circularFiles;
    fileurls.forEach((element) {
      filenames.add(element.substring(element.lastIndexOf('/')+1));
    });
    opendownload().then((value) {
      setState(() {
        isloading =false;
      });
    });

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

  @override
  Widget build(BuildContext context) {
    fileurls = Provider.of<StudentProvider>(context).circularFiles;

    var fileDownloaderProvider =
    Provider.of<FileDownloaderProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciculars',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: isloading?Center(child: LinearProgressIndicator(),): Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02,vertical: MediaQuery.of(context).size.height*0.02),
                child: ListView.builder(
                  itemBuilder: (ctx, index) {return
                    Column(mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.05,

                              child: Text(
                                '1.',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              alignment: Alignment.center,
                              child: Text(
                                filenames[index],
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold

                                ),
                              ),
                            ),


                            TextButton(onPressed: ()   {
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
                            },child:exist[index]==true?Text('Open'):downloadProgress(),),
                          ],
                        ),
                        Divider(height: 3,color: Colors.blue,),
                        SizedBox(height: 5,)
                      ],);
                  },
                  itemCount: filenames.length,
                ),
              ),

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
