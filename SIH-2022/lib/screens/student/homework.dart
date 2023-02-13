import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih/helpers/Homework.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../providers/studentProvider.dart';

class StudentHomework extends StatefulWidget {
  //const StudentHomework({Key? key}) : super(key: key);
  static const routeName = '/studentHomework';

  @override
  State<StudentHomework> createState() => _StudentHomeworkState();
}

class _StudentHomeworkState extends State<StudentHomework> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  //CalendarController _controller;
  DateTime _focusedDay = DateTime.now();

  DateTime _selectedDay= DateTime.now();


  List<Homework> hw=[];//contains object of type hw of _selectedDay//TEXT SELECTABLE??
  Widget hwCard(BuildContext context,Homework h/*todo object type*/){
    return Card(margin: EdgeInsets.symmetric(vertical:  MediaQuery.of(context).size.height*0.01,horizontal: MediaQuery.of(context).size.width*0.02),
      child: Container(

        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.02,vertical:  MediaQuery.of(context).size.height*0.02),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(),
          color: Colors.blue,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Text('${h.teacherName} - ',style: TextStyle(color: Colors.white,fontSize: 18,),),Text (h.subjectName,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
            ],),
            Row(mainAxisAlignment: MainAxisAlignment.center,children: [
              Text(
            '(${h.homeworkDate})',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],),
            Divider(color: Colors.white,thickness: 2,endIndent: MediaQuery.of(context).size.width*0.02,indent: MediaQuery.of(context).size.width*0.02,),
            Text(h.homeworkContent,style: TextStyle(color: Colors.white,fontSize: 18,),),

          ],
        ),
      ),);
  }
  _fetchHomeworkSelectedDate(){
    //TODO api call to fetch and set for selected date
  }
  //teacher name of given teacher id

  @override
  Widget build(BuildContext context) {
    final loggedInStudentHomework = Provider.of<StudentProvider>(context).homeworksofUser;//to fetch userid,school id
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //TableCalendar(firstDay: DateTime(2022,),lastDay: DateTime(2023),focusedDay: DateTime.now(),),
              TableCalendar(
                firstDay: DateTime(2022),
                lastDay: DateTime(2023),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {

                      _selectedDay = selectedDay;//TODO update the hw list also api call

                      _focusedDay = focusedDay;
                    });
                    _fetchHomeworkSelectedDate();
                    //loading spinner??
                  }

                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    // Call `setState()` when updating calendar format
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  // No need to call `setState()` here
                  _focusedDay = focusedDay;
                },

                // Enable week numbers (disabled by default).
                //weekNumbersVisible: true,
              ),



              Row(mainAxisAlignment: MainAxisAlignment.start,children: [
                Text('Homework for ',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                Text(_selectedDay.toLocal().toString(),style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
              ],),
              Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                Text(
                  _selectedDay.toLocal().toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ],),
              SizedBox(height: 10,),
              //listview return card scroll problem
              //TODO if list for that day is empty so no homework and a mark on table also
              loggedInStudentHomework.isEmpty?Text('No Homework '):
              Column(children: loggedInStudentHomework.map((e) => hwCard(context,e))
                  .toList(),),
            ],
          ),
        ),
      ),
    );
  }
}
