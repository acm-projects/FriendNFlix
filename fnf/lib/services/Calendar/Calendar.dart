import 'dart:async';

import 'package:flutter/material.dart';

import 'package:table_calendar/table_calendar.dart';

import 'CalendarMethods.dart';
import 'Event.dart';
import 'package:fnf/services/Post/Post.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime _firstDay = DateTime.utc(2003, 3, 23);
  DateTime _lastDay = DateTime.utc(2023, 12, 31);

  List<Post>? focusedDayPosts;
  List<Widget> eventWidgets = [];

  int tagCount = 1;
  DateTime _selectedDay = DateTime.now();

  final StreamController<Post> _controller = StreamController<Post>();

  Stream<Post>? stream;
  Map<String, List<Event>> events = {};
  var subscription;

  setPostForFocusedDay() {
    if (_selectedDay == null) return;

    CalendarMethods()
        .getPostsForDay(_selectedDay.month, _selectedDay.day, _selectedDay.year)
        .then((posts) {
      focusedDayPosts = posts;
      eventWidgets = [];

      for (Post post in focusedDayPosts!) {
        // eventWidgets.add(createEventWidgetFromPost(post));
        eventWidgets.add(
          Container(
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  height: 100,
                  width: 370,
                  color: Color(0xFFEAE2B7).withOpacity(0.4),
                  child: Text('Watched ${post.filmTitle}'),
                ),
              ),
            ),
          ),
        );
      }

      if (eventWidgets.isEmpty) {
        eventWidgets.add(Text("No events on this day"));
      }

      setState(() {});
    });
  }

  @override
  initState() {
    stream = _controller.stream;
    subscription = stream!.listen((post) {
      Event event =
      Event(post.body, post.watchMonth, post.watchDay, post.watchYear);

      String postedDayString =
      DateTime(post.watchYear, post.watchMonth, post.watchDay)
          .toString()
          .substring(0, 10);
      if (events[postedDayString] == null) events[postedDayString] = [];
      events[postedDayString]!.add(event);

      setPostForFocusedDay();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFAF3037),
            size: 30,
            ), onPressed: () {
            Navigator.pop(
              context,
            );
          },
          ),
          title: Text("Calendar",
              style: TextStyle(
                  color: Color(0xFFAF3037),
                  fontSize: 25,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          actionsIconTheme: const IconThemeData(
            color: Colors.green,
            size: 30,
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Divider(
                color: Color(0xFFAF3037),
                thickness: 2,
              ),
              // SizedBox(height: 380), todo
              Padding(
                  padding:
                  const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                  child: TableCalendar(
                    // style Calendar header
                    headerStyle: const HeaderStyle(
                      titleTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(
                          color: Color(0xFFAF3037),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)
                          )),
                      formatButtonVisible: false,
                      leftChevronIcon: Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 15),
                      rightChevronIcon: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),

                    // Style Calendar Day Labels
                    daysOfWeekStyle: const DaysOfWeekStyle(
                        decoration: BoxDecoration(
                          color: Color(0xFFAF3037),
                        ),
                        weekdayStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            backgroundColor: Color(0xFFAF3037)),
                        weekendStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            backgroundColor: Color(0xFFAF3037))),

                    rowHeight: 50,
                    // daysOfWeekHeight: 15,

                    calendarStyle: const CalendarStyle(

                      // tableBorder: TableBorder(
                      //
                      // ),
                        rowDecoration: BoxDecoration(color: Color(0xFFAF3037)),
                        defaultDecoration: BoxDecoration(
                          color: Color(0xFFAF3037),
                        ),
                        defaultTextStyle: TextStyle(color: Colors.white),
                        weekendDecoration: BoxDecoration(
                          color: Color(0xFFAF3037),
                        ),
                        weekendTextStyle: TextStyle(color: Colors.white),
                        todayDecoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        todayTextStyle: TextStyle(color: Colors.white),
                        selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        selectedTextStyle: TextStyle(color: Colors.white),
                        outsideDecoration: BoxDecoration(
                          color: Color(0xFFAF3037),
                        ),
                        outsideTextStyle: TextStyle(color: Colors.white)),

                    focusedDay: _selectedDay,
                    firstDay: _firstDay,
                    lastDay: _lastDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (isSameDay(selectedDay, _selectedDay)) return;

                      setState(() {
                        _selectedDay = selectedDay;
                        // _focusedDay = focusedDay;
                        setPostForFocusedDay();

                        // todo update events displayed at bottom
                      });
                    },
                    eventLoader: (day) {
                      String dayAsString = day.toString().substring(0, 10);

                      var listOfEvents = events[dayAsString];
                      if (listOfEvents == null) {
                        events[dayAsString] = [];
                        CalendarMethods().streamPostForDay(
                            day.month, day.day, day.year, _controller);
                        listOfEvents = [];
                      } else {}
                      return listOfEvents;
                    },
                  )),
              // todo uncomment widgets
              Container(
                child: Align(
                  alignment: Alignment(-0.85, 0.0),
                  child: Text("Events",
                      style: TextStyle(
                          color: Color(0xFFAF3037),
                          fontSize: 21,
                          fontWeight: FontWeight.bold)),
                ),
              ),
              Divider(
                color: Color(0xFFAF3037),
                thickness: 2,
              ),
              SizedBox(height: 35),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: eventWidgets,
              ),
              // Container(
              //   child: Center(
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(30),
              //       child: Container(
              //         height: 100,
              //         width: 370,
              //         color: Color(0xFFEAE2B7).withOpacity(0.4),
              //       ),
              //     ),
              //   ),
              // ),
              SizedBox(height: 30),
              Container(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      height: 100,
                      width: 370,
                      color: Color(0xFFEAE2B7).withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}