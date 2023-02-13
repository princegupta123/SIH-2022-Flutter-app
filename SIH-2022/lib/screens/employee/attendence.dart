import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih/helpers/Kaksha.dart';
import 'package:sih/providers/TeacherProvider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../modal/Student.dart';
import '../../providers/AdminProvider.dart';

class MarkAttendence extends StatefulWidget {
  const MarkAttendence({Key? key}) : super(key: key);
  static const routeName = '/MarkAttendance';
  @override
  _MarkAttendenceState createState() => _MarkAttendenceState();
}

class _MarkAttendenceState extends State<MarkAttendence> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  //CalendarController _controller;
  DateTime _focusedDay = DateTime.now();

  DateTime _selectedDay = DateTime.now();
  String selectedkakshaName = '';
  List<String> kakshaNames = [];
  List<Kaksha> allKakshaOfSchool = []; //kaksha id... or name
  List<Student> Students = []; //list based on id selected class//student id and name (MODAL REQUIREMENTto store data of students of a class like id name ..usme api call)
  List<int> atndnce = [
    -1,
    1,
    0,
    1
  ]; //how to show three statuses..bydefault -1 if opened and saved then 0 or 1
  var loadatndnce = false;
  var isSaved = false;
  Kaksha? selectedKaksha;
  setlistofStudents(String kakshaId){

  }
  setkakshaName(){
    allKakshaOfSchool.forEach((element) {
      kakshaNames.add(element.kakshaName);
    });
    setState(() {
      selectedKaksha=allKakshaOfSchool[0];
      selectedkakshaName=kakshaNames[0];
    });
  }
  @override
  void initState() {
    //TODO api call to FetchKakshaofSchool
    //set List<Kaksha> and then kakshaName
    allKakshaOfSchool = Provider.of<AdminProvider>(context,listen: false).viewKaksha;
    setkakshaName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Homework',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //TableCalendar(firstDay: DateTime(2022,),lastDay: DateTime(2023),focusedDay: DateTime.now(),),
              TableCalendar(
                pageAnimationEnabled: false,

                firstDay: DateTime(2022),
                lastDay: DateTime(2023),
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay =
                          selectedDay; //TODO update the hw list also api call

                      _focusedDay = focusedDay;
                    });
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

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Add attendence for ',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _selectedDay.toLocal().toString(),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              //api call for list of classes of this school and student of selected class
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton(items:
                    kakshaNames.map((e) => DropdownMenuItem(child: Text(e),value: e,)).toList(), onChanged: (newvalue){

                      setState(() {
                        selectedkakshaName = newvalue.toString() ;

                      });

                    },
                        onTap: (){
                          //TODO api call to fetch subjects of this class id
                          //set to subjectname and selectedsubject to [0]

                        }
                        ,value: selectedkakshaName),
                    ElevatedButton(
                        onPressed: () {
                          //TODO api call to fetch list of Students with attendance of selectedDate (all details??)or List<model  bnv>

                          setState(() {
                            Students = Provider.of<TeacherProvider>(context,listen: false).studentsList;

                            loadatndnce = true;
                            isSaved = false;
                          });
                        },
                        child: Text('Student Names'))
                  ],
                ),
              ),
              //listview
              loadatndnce
                  ? Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(Students[index].name),
                              subtitle: Text(
                                atndnce[index] == 1
                                    ? 'Present'
                                    : atndnce[index] == 0
                                        ? 'Absent'
                                        : 'Not Marked',
                                style: TextStyle(
                                  color: atndnce[index] == 1
                                      ? Colors.lightGreenAccent
                                      : atndnce[index] == 0
                                          ? Colors.red
                                          : Colors.grey,
                                ),
                              ),
                              trailing: Switch(
                                value: atndnce[index] == 1,
                                onChanged: (newvalue) {
                                  setState(() {
                                    atndnce[index] = newvalue ? 1 : 0;
                                  });
                                },
                                activeTrackColor: Colors.green,
                                activeColor: Colors.black,
                                inactiveThumbColor: Colors.black,
                                inactiveTrackColor: Colors.red,
                              ),
                            );
                          },
                          itemCount: Students.length,
                        ),

                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              //api call to update with atndnce list
                              setState(() {
                                isSaved = true;
                                loadatndnce = false;
                              });
                            },
                            child: Text('Save')),
                      ],
                    )
                  : isSaved
                      ? const Text('Attendance Saved Successfully')
                      : Text('')
            ],
          ),
        ),
      ),
    );
  }
}
