// import 'package:flutter/cupertino.dart';
// import 'package:fnf/fnf/CalendarMethods.dart';
// import 'package:fnf/fnf/PostMethods.dart';
// import 'package:googleapis/cloudsearch/v1.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// import 'dart:async';
//
// import 'Classes/Event.dart';
// import 'Classes/Post.dart';
//
// class CustomCalendarWidget extends StatefulWidget {
//   const CustomCalendarWidget({Key? key}) : super(key: key);
//
//   @override
//   State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
// }
//
// class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime _firstDay = DateTime.utc(2003, 3, 23);
//   DateTime _lastDay = DateTime.utc(2023, 12, 31);
//
//   List<Post>? focusedDayPosts;
//
//   int tagCount = 1;
//   DateTime _selectedDay = DateTime.now();
//
//   final StreamController<Post> _controller = StreamController<Post>();
//
//   Stream<Post>? stream;
//   Map<String, List<Event>> events = {};
//   var subscription;
//
//   setPostForFocusedDay(){
//     if(_focusedDay == null) return;
//
//     CalendarMethods().getPostsForDay(_focusedDay.month, _focusedDay.day, _focusedDay.year).then(
//             (posts) {
//           focusedDayPosts = posts;
//           for(Post post in focusedDayPosts!){
//             print(post.body);
//           }
//
//           setState(() {
//
//           });
//         }
//     );
//   }
//
//   //
//   //
//   //
//   @override
//   initState(){
//     stream = _controller.stream;
//     subscription = stream!.listen((post) {
//       Event event = Event(post.body, post.watchMonth, post.watchDay, post.watchYear);
//
//       String postedDayString = DateTime(post.watchYear, post.watchMonth, post.watchDay).toString().substring(0, 10);
//       if(events[postedDayString] == null) events[postedDayString] = [];
//       events[postedDayString]!.add(event);
//
//       setPostForFocusedDay();
//
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TableCalendar(
//       focusedDay: _focusedDay,
//       firstDay: _firstDay,
//       lastDay: _lastDay,
//       selectedDayPredicate: (day) {
//         return isSameDay(_selectedDay, day);
//       },
//       onDaySelected: (selectedDay, focusedDay) {
//
//         if (isSameDay(selectedDay, _selectedDay)) return;
//
//         setState(() {
//           _selectedDay = selectedDay;
//           _focusedDay = focusedDay;
//           setPostForFocusedDay();
//
//           // todo update events displayed at bottom
//         });
//       },
//       eventLoader: (day) {
//         String dayAsString = day.toString().substring(0, 10);
//
//
//         var listOfEvents = events[dayAsString];
//         if (listOfEvents == null) {
//           events[dayAsString] = [];
//           CalendarMethods().streamPostForDay(day.month, day.day, day.year, _controller);
//           listOfEvents = [];
//         } else {
//
//         }
//         return listOfEvents;
//       },
//     );
//   }
// }
