import 'package:cloud_firestore/cloud_firestore.dart';

import 'Day.dart';

class Month {
  int monthNum = 0;
  int yearNum = 0;

  Month({required int month, required int year}){
    // set month attribute if month is between 1 and 12 inclusive
    if(month  <= 0) throw new Exception("Month must be at least 1!");
    if(month > 12) throw new Exception("Month must be 12 or less!");

    this.monthNum = month;

    // set year if year is not negative
    if(year  < 0) throw new Exception("Month must be at least 0!");

    this.yearNum = year;
  }


  factory Month.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();

    if(data?["monthNum"] == null) data?["monthNum"] = 0;
    if(data?["dayNum"] == null) data?["dayNum"] = 0;


    return Month(
        month: data?['monthNum'],
        year: data?['yearNum'] ,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (monthNum != null) "monthNum": monthNum,
      if (yearNum != null) "yearNum": yearNum,
    };
  }

}