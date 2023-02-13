import 'package:flutter/material.dart';
import 'package:sih/screens/student/Qr.dart';
import 'package:sih/screens/student/dashboard.dart';

import '../login.dart';



class Tabs extends StatefulWidget {
  //const Tabs({Key? key}) : super(key: key);
  static const routeName = '/TabsPage';
  @override
  TabsState createState() => TabsState();
}

class TabsState extends State<Tabs> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState!.openEndDrawer();
  }
  int _selectedIndex = 1;

// 8
  List<Widget> pages = <Widget>[Qr(),StudentDashboard()];

// 9
  void _onItemTapped(int index) {
    if(index!=2){
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
            icon: Icon(Icons.qr_code),
            label: 'QR',
          ),
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
