import 'package:flutter/material.dart';

import 'package:sih/screens/employee/dashboard.dart';

import '../login.dart';



class TeacherTabs extends StatefulWidget {
  //const Tabs({Key? key}) : super(key: key);
  static const routeName = '/TeacherTabsPage';
  @override
  TeacherTabsState createState() => TeacherTabsState();
}

class TeacherTabsState extends State<TeacherTabs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }
  int _selectedIndex = 0;

// 8
  List<Widget> pages = <Widget>[TeacherDashboard()];

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
                onTap: ()=>Navigator.pushReplacementNamed(context, Login.routeName),)
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
