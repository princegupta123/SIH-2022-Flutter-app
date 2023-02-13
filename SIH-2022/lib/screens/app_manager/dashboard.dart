
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih/providers/AppManagerProvider.dart';
import 'package:sih/screens/app_manager/edit_details.dart';

import '../../modal/Admin.dart';
import '../login.dart';








class AppManagerTabs extends StatefulWidget {
  //const Tabs({Key? key}) : super(key: key);
  static const routeName = '/AppManagerTabsPage';
  @override
  AppManagerTabsState createState() => AppManagerTabsState();
}

class AppManagerTabsState extends State<AppManagerTabs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }
  int _selectedIndex = 0;

// 8
  List<Widget> pages = <Widget>[AppManagerDashboard()];

// 9
  void _onItemTapped(int index) {
    if(index!=1){
      setState(() {
        _selectedIndex = index;
      });
    }
    else{
      openDrawer();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: Drawer(width: MediaQuery.of(context).size.width*0.7,
        backgroundColor: Colors.blue,
        child: SingleChildScrollView(child:
        ListView(shrinkWrap: true,
            children: [
              ListTile(title: Text('Logout',style: TextStyle(color: Colors.white),),leading: Icon(Icons.logout),
                onTap: ()=>Navigator.pushReplacementNamed(context, Login.routeName),),
              ListTile(title: Text('Edit Details',style: TextStyle(color: Colors.white),),leading: Icon(Icons.edit),
                onTap: ()=>Navigator.pushNamed(context, AppManagerEditDetails.routeName),),
            ]),),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,

        onTap: _onItemTapped,
        selectedItemColor: Colors.black,

        // 6

        items: <BottomNavigationBarItem>[

          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: 'More',
          ),

        ],
      ),
    );
  }
}



class AppManagerDashboard extends StatefulWidget {
  //const Dashboard({Key? key}) : super(key: key);
  static const routeName = '/AppManagerDashboard';

  @override
  State<AppManagerDashboard> createState() => _AppManagerDashboardState();
}

class _AppManagerDashboardState extends State<AppManagerDashboard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final adminidcontroller = TextEditingController();
  final schoolidcontroller = TextEditingController();
  final adminNamecontroller = TextEditingController();
  final adminphonecontroller = TextEditingController();
  final adminemailcontroller = TextEditingController();
  final services = ['View Admins', 'Add Admin', 'Remove Admin', ];
  final removeadminidcontroller = TextEditingController();
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
  List<Admin> viewAdmins = [];
  var isViewing=false,isAdding=false,isRemoving=false;
    submit()  {
      if(schoolIdController.text!="" && adminidcontroller.text!="" && adminNamecontroller.text!=null && adminphonecontroller.text!=null && adminemailcontroller.text!=null){
        Provider.of<AppManagerProvider>(context,listen: false).addAdmin(Admin(phoneNumber: adminphonecontroller.text,emailId: adminemailcontroller.text,schoolId: schoolIdController.text,adminId: adminidcontroller.text,adminName: adminNamecontroller.text));
        schoolIdController.text="";
        adminNamecontroller.text= "";
        adminidcontroller.text= "";
        adminemailcontroller.text="";
        adminphonecontroller.text="";
        setState(() {
          //loading false
          isAdding = false;
        });
      }
      /*if( _formKey.currentState!.validate()==null){
        return;

      }
      _formKey.currentState!.save();
    //api call to save data
     //addAdmin(newAdmin);
    setState(() {
      //loading false
      isAdding = false;
    });*/
  }
  TextEditingController schoolIdController = TextEditingController();

  loadAdminList() {
    viewAdmins = Provider.of<AppManagerProvider>(context,listen: false).adminList;
  }
  addAdmin(Admin newAdmin) {
    Provider.of<AppManagerProvider>(context,listen: false).addAdmin(newAdmin);
  }
   removeAdmin( String adminId) {
    Provider.of<AppManagerProvider>(context,listen: false).removeAdmin(adminId);
    removeadminidcontroller.text="";
  }
  var loggedInAppManager;
  @override
  void initState() {
     loggedInAppManager = Provider.of<AppManagerProvider>(context,listen: false).loggedInAppManager;
    super.initState();
  }
  Widget cnt(BuildContext context, int index) {


    return GestureDetector(
      onTap: (){
        switch (index){
          case 0:
            //api call to get list of admins
            loadAdminList();
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
    loggedInAppManager = Provider.of<AppManagerProvider>(context).loggedInAppManager;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    schoolIdController.text = Provider.of<AppManagerProvider>(context).loggedInAppManager.schoolId;
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.school,
          color: Colors.black,
        ),
        title: Text(
          loggedInAppManager.schoolName,
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
                      loggedInAppManager.schoolId,
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

                      return ListTile(leading: Text('${index+1}.',style: TextStyle(fontWeight: FontWeight.bold),),title: Text(viewAdmins[index].adminName),);
                    },itemCount: viewAdmins.length,),
                  )
                      :isAdding?Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'SchoolId',

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
                            labelText: 'NewAdmin Id',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide()),
                          ),
                          controller: adminidcontroller,
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
                            labelText: 'Admin Name',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide()),
                          ),
                          controller: adminNamecontroller,
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
                            labelText: 'Admin Phone Number',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide()),
                          ),
                          controller: adminphonecontroller,
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value?.length != 10) {
                              return 'Enter 10 digit Mobile Number';
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
                            labelText: 'Admin Email Id',

                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide()),
                          ),
                          controller: adminemailcontroller,
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
                          onPressed: submit,
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
                          labelText: 'Admin Id',

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
                      SizedBox(height: 5,),
                      ElevatedButton(
                        onPressed: (){removeAdmin(removeadminidcontroller.text);},//api call
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

/*
GridView.builder(shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1 ),
                      itemBuilder: (ctx, index) {

                        return Container(child:Text(index.toString()));
                      },
                      padding: EdgeInsets.all(10),
                      itemCount: services.length,
                    ),
*/
//or use wrap with row
