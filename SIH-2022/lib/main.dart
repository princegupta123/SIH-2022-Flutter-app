import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih/modal/Admin.dart';
import 'package:sih/providers/AdminProvider.dart';
import 'package:sih/providers/AppManagerProvider.dart';
import 'package:sih/providers/TeacherProvider.dart';
import 'package:sih/providers/studentProvider.dart';
import 'package:sih/screens/admin/dashboard.dart';
import 'package:sih/screens/admin/manage_classes.dart';
import 'package:sih/screens/admin/manage_subjects.dart';
import 'package:sih/screens/app_manager/dashboard.dart';
import 'package:sih/screens/app_manager/edit_details.dart';
//import 'package:sih/screens/app_manager/edit_details.dart';
import 'package:sih/screens/employee/Tabs.dart';
import 'package:sih/screens/employee/attendence.dart';
import 'package:sih/screens/employee/circular.dart';
import 'package:sih/screens/employee/dashboard.dart';
import 'package:sih/screens/employee/homework.dart';
import 'package:sih/screens/employee/learning_resource.dart';
import 'package:sih/screens/employee/manage_students.dart';
import 'download_provider.dart';
import 'package:sih/screens/forgot_password.dart';
import 'package:sih/screens/login.dart';
import 'package:sih/screens/student/Tabs.dart';
import 'package:sih/screens/student/attendence.dart';
import 'package:sih/screens/student/circular.dart';
import 'package:sih/screens/student/dashboard.dart';
import 'package:sih/screens/student/homework.dart';
import 'package:sih/screens/student/learning_resource.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FileDownloaderProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => AppManagerProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => StudentProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => TeacherProvider(),

        ),
        ChangeNotifierProvider(
          create: (context) => AdminProvider(),

        ),
      ],
      child: MaterialApp(
        title: 'Sih',
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        initialRoute: Login.routeName,
        routes: {
          Login.routeName: (context) => Login(),
          ForgotPassword.routeName: (context)=> ForgotPassword(),
          StudentDashboard.routeName: (context)=> StudentDashboard(),
          StudentHomework.routeName: (context)=> StudentHomework(),
          Circular.routeName: (context)=> Circular(),
          StudentAttendence.routeName: (context )=> StudentAttendence(),
          StudentLearningResources.routeName: (context)=> StudentLearningResources(),
          Tabs.routeName : (context)=> Tabs(),
          TeacherTabs.routeName : (context)=> TeacherTabs(),
          TeacherDashboard.routeName: (context)=> TeacherDashboard(),
          UploadHomework.routeName: (context)=> UploadHomework(),
          UploadCircular.routeName: (context)=> UploadCircular(),
          MarkAttendence.routeName: (context )=> MarkAttendence(),
          UploadLearningResources.routeName: (context)=> UploadLearningResources(),
          AppManagerDashboard.routeName : (context) => AppManagerDashboard(),
          AdminDashboard.routeName : (context) => AdminDashboard(),
          ManageStudents.routeName: (context) => ManageStudents(),
          AppManagerTabs.routeName : (context) => AppManagerTabs(),
          AppManagerEditDetails.routeName : (context) => AppManagerEditDetails(),
          AdminTabs.routeName : (context) => AdminTabs(),
          ManageClasses.routeName : (context) => ManageClasses(),
          ManageSubjects.routeName : (context) => ManageSubjects(),
        },
      ),
    );
  }
}

/*
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'dart:io' show Platform;
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MyApp(),
));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() {
    return new MyAppState();
  }
}



class MyAppState extends State<MyApp> {
  ScanResult? scanResult;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;
  var _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  @override
  void initState() {
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
    final scanResult = this.scanResult;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Barcode Scanner Example'),
          actions: [
            IconButton(
              icon: const Icon(Icons.camera),
              tooltip: 'Scan',
              onPressed: _scan,
            )
          ],
        ),
        body:scanResult==null?Center(child: Text(''),):
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
            ],
    ),
          /*ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: <Widget>[
            if (scanResult != null)
              Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Result Type'),
                      subtitle: Text(scanResult.type.toString()),
                    ),
                    ListTile(
                      title: const Text('Raw Content'),
                      subtitle: Text(scanResult.rawContent),
                    ),
                    ListTile(
                      title: const Text('Format'),
                      subtitle: Text(scanResult.format.toString()),
                    ),
                    ListTile(
                      title: const Text('Format note'),
                      subtitle: Text(scanResult.formatNote),
                    ),
                  ],
                ),
              ),
            const ListTile(
              title: Text('Camera selection'),
              dense: true,
              enabled: false,
            ),
            RadioListTile(
              onChanged: (v) => setState(() => _selectedCamera = -1),
              value: -1,
              title: const Text('Default camera'),
              groupValue: _selectedCamera,
            ),
            ...List.generate(
              _numberOfCameras,
                  (i) => RadioListTile(
                onChanged: (v) => setState(() => _selectedCamera = i),
                value: i,
                title: Text('Camera ${i + 1}'),
                groupValue: _selectedCamera,
              ),
            ),
            const ListTile(
              title: Text('Button Texts'),
              dense: true,
              enabled: false,
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Flash On',
                ),
                controller: _flashOnController,
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Flash Off',
                ),
                controller: _flashOffController,
              ),
            ),
            ListTile(
              title: TextField(
                decoration: const InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Cancel',
                ),
                controller: _cancelController,
              ),
            ),
            if (Platform.isAndroid) ...[
              const ListTile(
                title: Text('Android specific options'),
                dense: true,
                enabled: false,
              ),
              ListTile(
                title: Text(
                  'Aspect tolerance (${_aspectTolerance.toStringAsFixed(2)})',
                ),
                subtitle: Slider(
                  min: -1,
                  max: 1,
                  value: _aspectTolerance,
                  onChanged: (value) {
                    setState(() {
                      _aspectTolerance = value;
                    });
                  },
                ),
              ),
              CheckboxListTile(
                title: const Text('Use autofocus'),
                value: _useAutoFocus,
                onChanged: (checked) {
                  setState(() {
                    _useAutoFocus = checked!;
                  });
                },
              ),
            ],
            const ListTile(
              title: Text('Other options'),
              dense: true,
              enabled: false,
            ),
            CheckboxListTile(
              title: const Text('Start with flash'),
              value: _autoEnableFlash,
              onChanged: (checked) {
                setState(() {
                  _autoEnableFlash = checked!;
                });
              },
            ),
            const ListTile(
              title: Text('Barcode formats'),
              dense: true,
              enabled: false,
            ),
            ListTile(
              trailing: Checkbox(
                tristate: true,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                value: selectedFormats.length == _possibleFormats.length
                    ? true
                    : selectedFormats.isEmpty
                    ? false
                    : null,
                onChanged: (checked) {
                  setState(() {
                    selectedFormats = [
                      if (checked ?? false) ..._possibleFormats,
                    ];
                  });
                },
              ),
              dense: true,
              enabled: false,
              title: const Text('Detect barcode formats'),
              subtitle: const Text(
                'If all are unselected, all possible '
                    'platform formats will be used',
              ),
            ),
            ..._possibleFormats.map(
                  (format) => CheckboxListTile(
                value: selectedFormats.contains(format),
                onChanged: (i) {
                  setState(() => selectedFormats.contains(format)
                      ? selectedFormats.remove(format)
                      : selectedFormats.add(format));
                },
                title: Text(format.toString()),
              ),
            ),
          ],
        ),
      ),*/)
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

/*class MyAppState extends State<MyApp> {
  String result = "Hey there !";

  Future _scanQR() async {
    try {

      ScanResult codeSanner = await BarcodeScanner.scan();    //barcode scanner
      setState(() {
        result = codeSanner.toString();
      });


    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.cameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(
          result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}*/

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw 'Could not launch $url';
  }
}
final Uri toLaunch =
Uri.parse('');
ElevatedButton(
onPressed: () => setState(() {
_launched = _launchInBrowser(toLaunch);
}),
child: const Text('Launch in browser'),
),
*/

