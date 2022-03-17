import 'package:flutter/material.dart';
import 'package:fyp/components/buttons.dart';
import 'package:fyp/components/cards.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/components/progress_bar.dart';
import 'package:fyp/components/round_text.dart';
import 'package:fyp/components/round_text_field.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/menu.dart';
import 'package:fyp/services/validator.dart';

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
                    children: [
                      const Text(
                        'Goals',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 22.0,
                          color: kSubTitleTextColor,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          color: kCream,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Center(
                            child: Text(
                              'Manage',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const ProgressBar(percent: 0.5, progress: "50%"),
                ],
              ),
            ),

            const TitleCard(
                title: "Current Goals", route: "/finance", button: "Manage"),
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
  const ManageGoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<String> goalsTarget = ['50% income', "20% expense", "10% savings"];
    List<String> goalsTitle = ['Save', 'Reduce', 'Invest'];

    //final _formKey = GlobalKey<FormState>();

    return Scaffold(
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
                      SmallButton(title: 'Add', route: '/home', color: kApricot)
                    ],
                  ),
                  space,
                  RoundFunctionText(
                    title: goalsTitle[0],
                    subtitle: goalsTarget[0],
                    icon1: const Icon(Icons.edit_outlined),
                    icon2: const Icon(Icons.delete_outlined),
                  ),
                  RoundFunctionText(
                    title: goalsTitle[1],
                    subtitle: goalsTarget[1],
                    icon1: const Icon(Icons.edit_outlined),
                    icon2: const Icon(Icons.delete_outlined),
                  ),
                  RoundFunctionText(
                    title: goalsTitle[2],
                    subtitle: goalsTarget[2],
                    icon1: const Icon(Icons.edit_outlined),
                    icon2: const Icon(Icons.delete_outlined),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class AddGoalsScreen extends StatefulWidget {
  const AddGoalsScreen({Key? key}) : super(key: key);

  @override
  State<AddGoalsScreen> createState() => _AddGoalsScreenState();
}

class _AddGoalsScreenState extends State<AddGoalsScreen> {
  @override
  Widget build(BuildContext context) {
    //visuals
    double width = MediaQuery.of(context).size.width;

    //Form
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final amountController = TextEditingController();

    String name = "";
    String amount = "";

    var time = ['Day', 'Month', 'Year'];
    String dropdownvalue = time[0];

    var goalMeasureType = ['Amount', 'Percentage'];
    String dropdownmeasurevalue = goalMeasureType[0];

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                    const Text(
                      'Add Goals',
                      style: kHeadingTextStyle,
                    ),
                    const Spacer(),
                    RoundTextField(
                        controller: nameController,
                        title: "Goal Name",
                        isPassword: false,
                        onSaved: (String? value) {
                          name != value;
                        },
                        validator: (value) =>
                            AccRecValidator.validateName(name: value)),
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Goal Measure Type',
                      style: kSubTextStyle,
                    ),
                    DropdownButton(
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        items: goalMeasureType.map((String goalMeasureType) {
                          return DropdownMenuItem(
                            child: Text(goalMeasureType),
                            value: goalMeasureType,
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        }),
                    RoundDoubleTextField(
                        controller: amountController,
                        title: "Amount",
                        onSaved: (String? value) {
                          amount != value;
                        },
                        validator: (value) =>
                            AccRecValidator.validateAmount(name: amount)),
                    space,
                    const Text(
                      'Time Measure Type ',
                      style: kSubTextStyle,
                    ),
                    DropdownButton(
                        value: dropdownmeasurevalue,
                        icon: const Icon(Icons.keyboard_arrow_down_outlined),
                        items: goalMeasureType.map((String time) {
                          return DropdownMenuItem(
                            child: Text(time),
                            value: time,
                          );
                        }).toList(),
                        onChanged: (String? time) {
                          setState(() {
                            dropdownmeasurevalue = time!;
                          });
                        }),
                    RoundDoubleTextField(
                        controller: amountController,
                        title: "Goal Time Period",
                        onSaved: (String? value) {
                          amount != value;
                        },
                        validator: (value) =>
                            AccRecValidator.validateAmount(name: amount)),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Text(
                        'Save',
                        style: kButtonTextStyle,
                      ),
                      style: kButtonStyle,
                    ),
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
