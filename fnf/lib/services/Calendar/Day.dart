import 'package:cloud_firestore/cloud_firestore.dart';

class Day {
  int dayNum = 0;
  int monthNum = 0;
  int yearNum = 0;
  List<String>? postsIds;

  Day({required this.dayNum, required this.monthNum, required this.yearNum, this.postsIds});
  factory Day.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();

    // if(data?["dayNum"] == null) data?["dayNum"] = 0;
    // if(data?["monthNum"] == null) data?["monthNum"] = 0;
    // if(data?["yearNum"] == null) data?["yearNum"] = 0;

    return Day(
      dayNum: data?["dayNum"],
      monthNum: data?['monthNum'],
      yearNum: data?['yearNum'],
      postsIds:
      data?['postIds'] is Iterable ? List.from(data?['postIds']) : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (monthNum != null) "dayNum" : dayNum,
      if (monthNum != null) "monthNum": monthNum,
      if (yearNum != null) "yearNum": yearNum,
      if (postsIds != null) "postIds" : postsIds,
    };
  }

}