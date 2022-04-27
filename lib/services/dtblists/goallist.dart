import 'package:flutter/material.dart';
import 'package:fyp/models/goals.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class GoalList extends StatefulWidget {
  const GoalList({Key? key}) : super(key: key);

  @override
  State<GoalList> createState() => _GoalListState();
}

class _GoalListState extends State<GoalList> {
  @override
  Widget build(BuildContext context) {
    final goals = Provider.of<List<GoalsData>>(context);

    return ListView.builder(
      itemCount: goals.length,
      itemBuilder: (context, index) {
        return GoalsTile(goal: goals[index]);
      },
    );
  }
}

class GoalsTile extends StatelessWidget {
  const GoalsTile({Key? key, required this.goal}) : super(key: key);

  final GoalsData goal;

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
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
