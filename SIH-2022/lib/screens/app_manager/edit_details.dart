import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih/modal/AppManager.dart';
import 'package:sih/providers/AppManagerProvider.dart';
class AppManagerEditDetails extends StatefulWidget {
  const AppManagerEditDetails({Key? key}) : super(key: key);
  static const routeName = '/AppManagerEditPage';
  @override
  _AppManagerEditDetailsState createState() => _AppManagerEditDetailsState();
}

class _AppManagerEditDetailsState extends State<AppManagerEditDetails> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController schoolNamecontroller = TextEditingController();
  TextEditingController schoolIdcontroller = TextEditingController();
  @override
  void initState() {
    schoolIdcontroller.text= Provider.of<AppManagerProvider>(context,listen: false).loggedInAppManager.schoolId ;
    schoolNamecontroller.text= Provider.of<AppManagerProvider>(context,listen: false).loggedInAppManager.schoolName ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit School Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width*0.2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.02,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'SchoolId',

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide()),
                  ),
                  controller: schoolIdcontroller,
                  //initialValue: Provider.of<AppManagerProvider>(context,listen: false).loggedInAppManager.schoolId,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Can\'t be empty';
                    }
                  },
                  onSaved: (value) {

                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'School Name',

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide()),
                  ),
                  controller: schoolNamecontroller,
                  //initialValue:  Provider.of<AppManagerProvider>(context,listen: false).loggedInAppManager.schoolName,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Can\'t be empty';
                    }
                  },
                  onSaved: (value) {

                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),

                ElevatedButton(
                  onPressed: (){
                    //print(schoolNamecontroller.value.toString());
                    Provider.of<AppManagerProvider>(context,listen: false).updateSchoolDetails(AppManager(schoolName: schoolNamecontroller.text, schoolId: schoolIdcontroller.text));
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Save',
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
              ],
            ),
          ),
        )
      ),
    );
  }
}
