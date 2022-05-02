import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fyp/components/buttons.dart';
import 'package:fyp/components/cards.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/components/progress_bar.dart';
import 'package:fyp/components/round_text.dart';
import 'package:fyp/components/round_text_field.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/models/goals.dart';
import 'package:fyp/services/database.dart';
import 'package:fyp/services/dtblists/goallist.dart';
import 'package:fyp/services/menu.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double percent = 0.75;
    final controller = ScrollController();

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        backgroundColor: kApricot,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            MyHeader(
              height: 120,
              width: width,
              color: kApricot,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: const [
                      Text('Goals',
                          textAlign: TextAlign.start, style: kHeadingTextStyle),
                      Spacer(),
                      SmallButton(
                          title: "Manage",
                          route: "/managegoals",
                          color: kCream),
                    ],
                  ),
                  const ProgressBar(percent: 0.5, progress: "50%"),
                ],
              ),
            ),

            const TitleCard(
                title: "Current Goals",
                route: "/managegoals",
                button: "Manage"),
            space,

            SizedBox(
              width: width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GoalCard(
                        percent: percent, title: "Save", text: "50% of income"),
                    const SizedBox(width: 5),
                    const GoalCard(
                        percent: 0.6, title: "Reduce", text: "20% of expense"),
                    const SizedBox(width: 5),
                    const GoalCard(
                        percent: 0.3, title: "Invest", text: "10% of savings"),
                  ],
                ),
              ),
            ),

            space,

            const TitleCard(
              title: "Goals Achievement",
              route: "/home",
              button: "See More",
            ),
            smallSpace,

            //insert graph
          ],
        ),
      ),
    );
  }
}

class ManageGoalsScreen extends StatelessWidget {
  ManageGoalsScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    double width = MediaQuery.of(context).size.width;

    //final _formKey = GlobalKey<FormState>();

   

    return StreamProvider<List<GoalsData>>.value(
      initialData: const [],
      value: DatabaseService(uid).goals,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              MyHeader(
                height: 150,
                width: width,
                color: kCream,
                child: Column(
                  children: [
                    const MyBackButton(),
                    smallSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          'Manage Goals',
                          style: kHeadingTextStyle,
                        ),
                      ],
                    ),
                    const Spacer(),

                    space,
                    //add minus transaction bar
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text('Existing Goals', style: kHeadingTextStyle),
                        Spacer(),
                        SmallButton(
                            title: 'Add', route: '/addgoals', color: kApricot)
                      ],
                    ),
                    space,
                    const SizedBox(height: 200, child: GoalList()),
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

//!TODO ADD GOALS SCREEN EDIT
class AddGoalsScreen extends StatefulWidget {
  const AddGoalsScreen({Key? key}) : super(key: key);

  @override
  State<AddGoalsScreen> createState() => _AddGoalsScreenState();
}

class _AddGoalsScreenState extends State<AddGoalsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String dropdowntitlevalue = 'Save';
  String dropdowntargetvalue = 'Income';
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

  DateTime? _dateTime;

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    //final uid = user!.uid;

    //visuals
    double width = MediaQuery.of(context).size.width;

    //initialised within the state

    String amount = "0";

    //mock database
    List<String> goalTitle = ['Save', 'Reduce'];
    List<String> goalTarget = ['Income', 'Expense'];

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyHeader(
                height: 80,
                width: width,
                color: kCream,
                child: Column(
                  children: const [
                    MyBackButton(),
                    smallSpace,
                    Text(
                      'Add Goals',
                      style: kHeadingTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: SizedBox(
                width: 300,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      space,
                      const Text(
                        'Goal Title',
                        style: kSubTextStyle,
                      ),
                      space,

                      DropdownButtonFormField(
                        value: dropdowntitlevalue,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdowntitlevalue = newValue!;
                          });
                        },
                        items: goalTitle
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value,
                          );
                        }).toList(),
                      ),

                      space,
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
                        items: goalTarget
                            .map<DropdownMenuItem<String>>((String value) {
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
                            : DateFormat('dd/MM/yyyy')
                                .format(_dateTime!)
                                .toString()),
                      ),

                      space,

                      Text(_dateTime == null
                          ? 'No date chosen'
                          : DateFormat('dd/MM/yyyy')
                              .format(_dateTime!)
                              .toString()),

                      //save button
                      SizedBox(
                        width: 300,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              int amount =
                                  int.parse(amountController.value.text);

                              var target = dropdowntargetvalue;
                              var title = dropdowntitlevalue;
                              Timestamp enddate =
                                  Timestamp.fromDate(_dateTime!);
                              int progress = 0;

                              DatabaseService(user!.uid).saveGoal(
                                  amount, target, title, enddate, progress);
                            }
                            Navigator.pushNamed(context, '/goals');
                          },
                          child: const Text(
                            'Save',
                            style: kButtonTextStyle,
                          ),
                          style: kButtonStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
