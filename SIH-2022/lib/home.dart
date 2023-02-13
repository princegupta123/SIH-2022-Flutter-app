import 'package:flutter/material.dart';
import 'package:sih/download_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    var fileDownloaderProvider =
    Provider.of<FileDownloaderProvider>(context, listen: false);
    return new Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.black, title: Text("File Downloading")),
        body: Container(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    dowloadButton(fileDownloaderProvider),
                    downloadProgress()
                  ]),
            )));
  }

  Widget dowloadButton(FileDownloaderProvider filedownloaderProvider) {
    return new FlatButton(
      onPressed: () {
        filedownloaderProvider
            .downloadFile("https://www.sih.gov.in/letters/Guidelines-College-SPOC.pdf", "sihde.pdf")
            .then((onValue) {});
      },
      textColor: Colors.black,
      color: Colors.redAccent,
      padding: const EdgeInsets.all(8.0),
      child: new Text(
        "Download File",
      ),
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