import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sih/helpers/qr.dart';
import 'package:sih/providers/studentProvider.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class Qr extends StatefulWidget {
  //const Qr({Key? key}) : super(key: key);
  static const routeName = '/qrpage';

    @override
  _QrState createState() => _QrState();
}

class _QrState extends State<Qr> {
  ScanResult? scanResult;
  List<QrCode> savedQrCodes = [];
  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');
  String userId ='';
  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {savedQrCodes = Provider.of<StudentProvider>(context,listen: false).savedQrCodes;
    userId=Provider.of<StudentProvider>(context,listen: false).loggedInStudent.admNo;
    super.initState();

    Future.delayed(Duration.zero, () async {
      _numberOfCameras = await BarcodeScanner.numberOfCameras;
      setState(() {});
    });
  }
  String? url ;
  Future<void>? _launched;
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }
  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }
  @override
  Widget build(BuildContext context) {
    savedQrCodes = Provider.of<StudentProvider>(context).savedQrCodes;
    final scanResult = this.scanResult;
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR code Scanner',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        /*actions: [
          IconButton(
            icon: const Icon(Icons.camera,color: Colors.black,),
            tooltip: 'Scan',
            onPressed: _scan,
          )
        ],*/
      ),
        floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.camera_alt),
          label: Text("Tap to Scan"),
          onPressed: _scan,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body:scanResult==null?Column(
        children: [
          ListView.builder(shrinkWrap: true,itemBuilder: (context, index) {
            return Container(width: MediaQuery.of(context).size.width*0.7,
              child: Column(
                children: [
                  ListTile(onTap: (){
                    setState(() {
                      _launched = _launchInBrowser(Uri.parse(savedQrCodes[index].qrUrl));
                    });
                  },title: Text(savedQrCodes[index].qrUrl),subtitle: Text(savedQrCodes[index].qrId),
                    trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: (){
                      Provider.of<StudentProvider>(context,listen: false).removeQr(savedQrCodes[index].qrId);
                    },),),
                  Divider(height: 2,),
                ],
              ));
          },itemCount: savedQrCodes.length,),
        ],
      ):
          !scanResult.rawContent.toString().contains('http')?Center(child: Text('error occured'),):
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(scanResult.rawContent.toString()),
          ElevatedButton(onPressed: (){
            showDialog<String>(
              context: context,
              builder: (BuildContext context) =>
                  AlertDialog(
                    title: const Text('Save this QR code?'),
                    content: Text(DateTime.now().toString()),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _launched = _launchInBrowser(Uri.parse(scanResult.rawContent.toString()));
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('No'),

                      ),
                      TextButton(
                        onPressed: () {
                          Provider.of<StudentProvider>(context,listen: false).addQr(QrCode(createdAt: DateTime.now(),qrId: DateTime.now().toString(),qrUrl: scanResult.rawContent.toString(),userId: userId ));
                          setState(() {
                            _launched = _launchInBrowser(Uri.parse(scanResult.rawContent.toString()));
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),

                      ),
                    ],
                  ),
            );
          }, child: Text('Open in browser')),

          FutureBuilder<void>(future: _launched, builder: _launchStatus),

          ListView.builder(shrinkWrap: true,itemBuilder: (context, index) {
              return Container(width: MediaQuery.of(context).size.width*0.7,
              child: Column(
                children: [
                  ListTile(onTap: (){
                    setState(() {
                      _launched = _launchInBrowser(Uri.parse(savedQrCodes[index].qrUrl));
                    });
                  },title: Text(savedQrCodes[index].qrUrl),subtitle: Text(savedQrCodes[index].qrId),
                    trailing: IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: (){
                      Provider.of<StudentProvider>(context,listen: false).removeQr(savedQrCodes[index].qrId);
                    },),),
                  Divider(height: 2,),
                ],
              ),);
          },itemCount: savedQrCodes.length,),
        ],
      ),
    );
  }
  Future<void> _scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
      });
    }
  }
}
