import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/models/goals.dart';
import 'package:fyp/services/database.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class GoalList extends StatefulWidget {
  const GoalList({Key? key}) : super(key: key);

  @override
  State<GoalList> createState() => _GoalListState();
}

class _GoalListState extends State<GoalList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final goals = Provider.of<List<GoalsData>>(context);
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    return ListView.builder(
      itemCount: goals.length,
      itemBuilder: (context, index) {
        return GoalsTile(goal: goals[index], uid: uid);
      },
    );
  }
}

class GoalsTile extends StatelessWidget {
  const GoalsTile({Key? key, required this.goal, required this.uid})
      : super(key: key);

  final GoalsData goal;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircularProgressIndicator(
            value: (goal.progress / 100).toDouble(),
          ),
          title: Text(goal.title),
          subtitle: Text('${goal.target} of ${goal.amount}%'),
          trailing: SizedBox(
            width: 96,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outlined),
                  onPressed: () async {
                    await DatabaseService(uid).deleteGoal(goal.goalsid);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
