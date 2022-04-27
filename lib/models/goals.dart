import 'package:cloud_firestore/cloud_firestore.dart';

class GoalsData {
  final String goalsid;
  final int amount;
  final String target;
  final String title;
  final int progress;
  final Timestamp enddate;

  GoalsData(
      {required this.goalsid,
      required this.amount,
      required this.target,
      required this.title,
      required this.progress,
      required this.enddate});
}
