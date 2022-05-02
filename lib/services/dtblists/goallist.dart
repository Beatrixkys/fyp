import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fyp/components/round_text_field.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/models/goals.dart';
import 'package:fyp/services/database.dart';

import 'package:intl/intl.dart';
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
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              height: 500,
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: GoalSettingsForm(
                uid: uid,
                gid: goal.goalsid,
                gtitle: goal.title,
                gamount: goal.amount,
                gtarget: goal.target,
                genddate: goal.enddate,
              ),
            );
          });
    }

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
                  onPressed: () => _showSettingsPanel(),
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

class GoalSettingsForm extends StatefulWidget {
  const GoalSettingsForm(
      {Key? key,
      required this.uid,
      required this.gid,
      required this.gtitle,
      required this.gtarget,
      required this.gamount,
      required this.genddate})
      : super(key: key);

  final String uid;
  final String gid;
  final String gtitle;
  final String gtarget;
  final int gamount;
  final Timestamp genddate;
  @override
  State<GoalSettingsForm> createState() => _GoalSettingsFormState();
}

class _GoalSettingsFormState extends State<GoalSettingsForm> {
//Form
  final _formKey = GlobalKey<FormState>();
  final amountController = TextEditingController();

  final nameVal =
      MultiValidator([RequiredValidator(errorText: 'Field is Required')]);

  final amountVal = MultiValidator([
    RequiredValidator(errorText: 'Field is Required'),
    RangeValidator(
        min: 0, max: 100, errorText: 'Percentage must be in range 0-100')
  ]);

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String dropdowntitlevalue = widget.gtitle;
    String dropdowntargetvalue = widget.gtarget;
    String amount = (widget.gamount).toString();
    DateTime? _dateTime = (widget.genddate).toDate();

    //mock database
    List<String> goalTitle = ['Save', 'Reduce'];
    List<String> goalTarget = ['Income', 'Expense'];
    return Form(
      key: _formKey,
      child: SizedBox(
        height: 500,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                'Edit Goal',
                style: kHeadingTextStyle,
              ),
              space,

              const Text(
                'Goal Title',
                style: kSubTextStyle,
              ),
              smallSpace,

              DropdownButtonFormField(
                value: dropdowntitlevalue,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdowntitlevalue = newValue!;
                  });
                },
                items: goalTitle.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
              ),

              smallSpace,
              const Text(
                'Goal Target',
                style: kSubTextStyle,
              ),

              DropdownButtonFormField(
                value: dropdowntargetvalue,
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdowntargetvalue = newValue!;
                  });
                },
                items: goalTarget.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
              ),

              space,

              //Goal Amount
              RoundDoubleTextField(
                controller: amountController,
                title: "Goal Percentage",
                onSaved: (String? value) {
                  amount != value;
                },
                validator: nameVal,
              ),

              space,

              //TIME
              const Text(
                'Choose End Date ',
                style: kSubTextStyle,
              ),

              TextButton.icon(
                onPressed: () async {
                  DateTime? _newDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      lastDate: DateTime(2222));

                  if (_newDate == null) return;

                  setState(() => _dateTime = _newDate);
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_dateTime == null
                    ? 'Choose A Date'
                    : DateFormat('dd/MM/yyyy').format(_dateTime!).toString()),
              ),

              space,

              //save button
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      int amount = int.parse(amountController.value.text);

                      var target = dropdowntargetvalue;
                      var title = dropdowntitlevalue;
                      Timestamp enddate = Timestamp.fromDate(_dateTime!);

                      DatabaseService(widget.uid).updateGoal(
                        widget.gid,
                        amount,
                        target,
                        title,
                        enddate,
                      );
                    }
                    Navigator.pushNamed(context, "/managegoals");
                  },
                  child: const Text(
                    'Update',
                    style: kButtonTextStyle,
                  ),
                  style: kButtonStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
