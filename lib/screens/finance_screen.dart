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

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();
    int total = 1000;
    double width = MediaQuery.of(context).size.width;
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
                children: <Widget>[
                  Row(
                    children: [
                      const Text(
                        'Finances',
                        textAlign: TextAlign.start,
                        style: kHeadingTextStyle,
                      ),
                      const Spacer(),
                      Container(
                        height: 40.0,
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
                  Text(
                    'Total Assets: RM $total',
                    textAlign: TextAlign.start,
                    style: kSubTextStyle,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  space,
                  const TitleCard(
                    title: "Overview of the Month",
                    route: "/home",
                    button: "See More",
                  ),

                  smallSpace,

                  const ProgressBar(percent: 0.5, progress: "50%"),
                  smallSpace,
                  SizedBox(
                    width: 350,
                    child: Row(
                      children: const [
                        ExpenditureCard(title: "Income", amount: "150.00"),
                        ExpenditureCard(title: "Expense", amount: "50.00"),
                        space,
                      ],
                    ),
                  ),
                  space,

                  const TitleCard(
                      title: "Accounts", route: "/home", button: "Manage"),

                  space,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        AccountsCard(
                            icon: "assets/bank.png",
                            title: "Bank",
                            text: "RM1500.00"),
                        AccountsCard(
                            icon: "assets/cash.png",
                            title: "Cash",
                            text: "RM40.00"),
                        AccountsCard(
                            icon: "assets/ewallet.png",
                            title: "E-wallet",
                            text: "RM50.00"),
                      ],
                    ),
                  ),
                  //create scrollable accounts
                  space,
                  const TitleCard(
                      title: "Transaction", route: "/home", button: "Manage"),
                  space,
                  Center(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.arrow_left),
                        ),
                        const Text(
                          "14-5-2000",
                          style: kTitleTextstyle,
                        ),
                        InkWell(
                          onTap: () {},
                          child: const Icon(Icons.arrow_right),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ManageFinanceScreen extends StatelessWidget {
  const ManageFinanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    String name = "";

    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MyHeader(
              height: 200,
              width: width,
              color: kCream,
              child: Column(
                children: [
                  const MyBackButton(),
                  space,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Manage Finances',
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      SmallButton(title: 'Accounts', route: '/home'),
                      SmallButton(title: 'Records', route: '/home')
                    ],
                  ),
                  //add minus transaction bar
                ],
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //title
                    RoundTextField(
                        controller: nameController,
                        title: "Name",
                        isPassword: false,
                        onSaved: (String? value) {
                          name != value;
                        },
                        validator: (value) =>
                            EPValidator.validateName(name: value)),

                    //amount
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
