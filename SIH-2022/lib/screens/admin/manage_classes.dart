import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih/helpers/Kaksha.dart';
import 'package:sih/modal/Admin.dart';
import 'package:sih/providers/AdminProvider.dart';
class ManageClasses extends StatefulWidget {
  //const Dashboard({Key? key}) : super(key: key);
  static const routeName = '/ManageClasses';

  @override
  State<ManageClasses> createState() => _ManageClassesState();
}

class _ManageClassesState extends State<ManageClasses> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final kakshaidcontroller = TextEditingController();
  final services = ['View Kaksha', 'Add Kaksha', 'Remove Kaksha', ];
  final removeadminidcontroller = TextEditingController();
  final kakshaNameController = TextEditingController();
  final schoolIdController = TextEditingController();
  final sujectNameController = TextEditingController();
  final teacherIdController = TextEditingController();
  //schoolIdController.text = Provider.of<AppManager>
  List<String > subjectList = [];
  List<String > teachersId = [];
  addtosubjectList(String subjectName){
    setState(() {
      subjectList.add(subjectName);
      sujectNameController.text = '';
    });
  }
  addtoteachersIdList(String teacherId){
    setState(() {
      teachersId.add(teacherId);
      teacherIdController.text = '';
    });
  }
  final icons = [
    Icons.view_list,
    Icons.person_add,
    Icons.person_remove,

  ];

  final colors = [
    Colors.amber,
    Colors.lightBlueAccent,
    Colors.greenAccent,

  ];
  List<Kaksha> viewKaksha = [];
  var isViewing=false,isAdding=false,isRemoving=false;
   submit(Kaksha newKaksha) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    //api call to save data
    await addKaksha(newKaksha);
    subjectList=[];
    teachersId = [];
    kakshaidcontroller.text="";
    kakshaNameController.text="";

    setState(() {
      //loading false
      isAdding = false;
    });
  }
  Future<void> loadKakshaList() async{
    viewKaksha = Provider.of<AdminProvider>(context,listen: false).viewKaksha;
  }
  Future<void> addKaksha(Kaksha newKaksha) async{
    Provider.of<AdminProvider>(context,listen: false).addKaksha(newKaksha);
  }
  Future<void > removeKaksha( String kakshaId) async{
    Provider.of<AdminProvider>(context,listen: false).removeKaksha(kakshaId);
    removeadminidcontroller.text="";
  }

  @override
  void initState() {

    super.initState();
  }
  Widget cnt(BuildContext context, int index) {


    return GestureDetector(
      onTap: (){
        switch (index){
          case 0:
          //api call to get list of admins
            loadKakshaList();
            setState(() {
              isViewing=true;
              isAdding=isRemoving=false;
            });

            break;
          case 1:

            setState(() {
              isAdding =true;
              isViewing=isRemoving=false;
            });
            break;
          case 2:
            setState(() {
              isRemoving=true;
              isViewing=isAdding=false;
            });
        }
      },
      child: Container(

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(),
          color: Colors.white,
        ),
        height: 120,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icons[index],
                    color: colors[index],
                    size: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child:Text(services[index],
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            Container(
              height: 10,
              color: colors[index],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loggedInAdmin = Provider.of<AdminProvider>(context).loggedInAdmin;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.school,
          color: Colors.black,
        ),
        title: Text(
          loggedInAdmin.schoolId,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            /*Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(215, 100, 100, 1).withOpacity(0.5),
                      Color.fromRGBO(255, 100, 100, 1).withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0, 1],
                  )),
            ),*/
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(
                        width * 0.02, height * 0.03, width * 0.02, 2),
                    padding: EdgeInsets.symmetric(vertical: 7),
                    alignment: Alignment.center,
                    color: Colors.indigo,
                    child: Text(
                      loggedInAdmin.adminName,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cnt(context, 0),
                          cnt(context, 1),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          cnt(context, 2),

                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  isViewing?Container(
                    color: Colors.white,
                    child: ListView.builder(
                      shrinkWrap: true
                      ,itemBuilder: (context, index) {

                      return ListTile(leading: Text('${index+1}.',style: TextStyle(fontWeight: FontWeight.bold),),title: Text(viewKaksha[index].kakshaName),);
                    },itemCount: viewKaksha.length,),
                  )
                      :isAdding?Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'School Id',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide()),
                          ),
                          controller: schoolIdController,
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
                            labelText: 'ClassId',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide()),
                          ),
                          controller: kakshaidcontroller,
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
                            labelText: 'Class Name',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide()),
                          ),
                          controller: kakshaNameController,
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
                        Wrap(
                          spacing: 0,
                          runSpacing: 0,
                          children: subjectList.map((e) =>Container(
                            child: Chip(
                              label: Text(e),
                              elevation: 4,
                              shadowColor: Colors.grey[50],
                              padding: EdgeInsets.all(4),
                            ),
                          ) ).toList(),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Subject Name',

                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16),
                                      borderSide: BorderSide()),
                                ),
                                controller: sujectNameController,
                                keyboardType: TextInputType.text,

                                onSaved: (value) {

                                },
                              ),
                            ),
                            SizedBox(width: 5,),
                            ElevatedButton(onPressed: (){
                              addtosubjectList(sujectNameController.text);

                            },child: Text('Add'),),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Wrap(
                          spacing: 0,
                          runSpacing: 0,
                          children: teachersId.map((e) =>Container(
                            child: Chip(
                              label: Text(e),
                              elevation: 4,
                              shadowColor: Colors.grey[50],
                              padding: EdgeInsets.all(4),
                            ),
                          ) ).toList(),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child : TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Teacher Id',

                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide()),
                              ),
                              controller: teacherIdController,
                              keyboardType: TextInputType.text,

                              onSaved: (value) {

                              },
                            ),),
                            SizedBox(width: 5,),
                            ElevatedButton(onPressed: (){
                              addtoteachersIdList(teacherIdController.text);

                            },child: Text('Add'),),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        ElevatedButton(
                          onPressed: (){
                              submit(Kaksha(kakshaName: kakshaNameController.text, kakshaId: kakshaidcontroller.text, schoolId: schoolIdController.text,subjects: subjectList,teachersId: teachersId));
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
                  )
                      :isRemoving?Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Kaksha Id',

                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide()),
                        ),
                        keyboardType: TextInputType.text,
                        controller: removeadminidcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Can\'t be empty';
                          }
                        },
                        onSaved: (value) {

                        },
                      ),
                      ElevatedButton(
                        onPressed: (){removeKaksha(removeadminidcontroller.text);
                        setState(() {
                          isRemoving = false;
                        });},//api call
                        child: Text(
                          'Remove',
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
                  )

                      :Text('')
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
