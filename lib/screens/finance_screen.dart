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
    //visuals
    final controller = ScrollController();
    double width = MediaQuery.of(context).size.width;
    //finances
    double total = 1000;
    double incomeTotal = 100;
    double expenseTotal = 50;
    List<double> accountsTotal = [1500, 40, 50];
    List<String> accountsTitle = ['Bank', 'Cash', 'E-Wallet'];
    //goal
    double overallProgress = 0.5;
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
                          onPressed: () {
                            Navigator.pushNamed(context, '/managefinance');
                          },
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
                    route: "/goals",
                    button: "See More",
                  ),

                  smallSpace,

                  ProgressBar(
                      percent: overallProgress,
                      progress: '${(overallProgress * 100).round()}%'),
                  smallSpace,
                  SizedBox(
                    width: 350,
                    child: Row(
                      children: [
                        ExpenditureCard(
                            title: "Income", amount: '$incomeTotal'),
                        ExpenditureCard(
                            title: "Expense", amount: '$expenseTotal'),
                        space,
                      ],
                    ),
                  ),
                  space,

                  const TitleCard(
                      title: "Accounts",
                      route: "/managefinance",
                      button: "Manage"),

                  space,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AccountsCard(
                            icon: "assets/bank.png",
                            title: accountsTitle[0],
                            text: "RM ${accountsTotal[0]}"),
                        AccountsCard(
                            icon: "assets/cash.png",
                            title: accountsTitle[1],
                            text: "RM${accountsTotal[1]}"),
                        AccountsCard(
                            icon: "assets/ewallet.png",
                            title: accountsTitle[2],
                            text: "RM${accountsTotal[2]}"),
                      ],
                    ),
                  ),
                  //create scrollable accounts
                  space,
                  const TitleCard(
                      title: "Transaction",
                      route: "/managefinance",
                      button: "Manage"),
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

class ManageFinanceScreen extends StatefulWidget {
  const ManageFinanceScreen({Key? key}) : super(key: key);

  @override
  State<ManageFinanceScreen> createState() => _ManageFinanceScreenState();
}

class _ManageFinanceScreenState extends State<ManageFinanceScreen> {
  bool accounts = true;

  void toggleView() {
    setState(() {
      accounts = !accounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<double> accountsTotal = [1500, 40, 50];
    List<String> accountsTitle = ['Bank', 'Cash', 'E-Wallet'];

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
                        'Manage Finances',
                        style: kHeadingTextStyle,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                        width: 120,
                        child: Text(
                          "Change View:",
                          style: kSubTextStyle,
                        ),
                      ),
                      Container(
                        height: 40,
                        width: 120,
                        decoration: BoxDecoration(
                          color: kApricot,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextButton(
                          onPressed: () => toggleView(),
                          child: Center(
                            child: Text(
                              accounts ? "Accounts" : "Records ",
                              style: kButtonTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      Text('Existing Data', style: kHeadingTextStyle),
                      Spacer(),
                      SmallButton(
                          title: 'Add', route: '/addfinance', color: kApricot)
                    ],
                  ),
                  space,
                  RoundFunctionText(
                    title: accountsTitle[0],
                    subtitle: 'RM ${accountsTotal[0]}',
                    icon1: const Icon(Icons.edit_outlined),
                    icon2: const Icon(Icons.delete_outlined),
                  ),
                  RoundFunctionText(
                    title: accountsTitle[1],
                    subtitle: 'RM${accountsTotal[1]}',
                    icon1: const Icon(Icons.edit_outlined),
                    icon2: const Icon(Icons.delete_outlined),
                  ),
                  RoundFunctionText(
                    title: accountsTitle[2],
                    subtitle: 'RM${accountsTotal[2]}',
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

class AddFinanceScreen extends StatefulWidget {
  const AddFinanceScreen({Key? key}) : super(key: key);

  @override
  State<AddFinanceScreen> createState() => _AddFinanceScreenState();
}

class _AddFinanceScreenState extends State<AddFinanceScreen> {
  //Form
  String dropdownvalue = 'Bank';
  String dropdownrecvalue = 'Leisure';
  String dropdownrectypevalue = 'Income';
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

//condition for toggle view
  bool records = true;

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //visuals
    double width = MediaQuery.of(context).size.width;

    //form (changes within the state)
    String name = "";
    String amount = "";

// Mock Database
    var accounts = ['Bank', 'Cash', 'E-Wallet'];
    var record = ['Leisure', 'Work', 'Transport'];
    var recordType = ['Income', 'Expense'];

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyHeader(
                height: 250,
                width: width,
                color: kCream,
                child: Column(
                  children: [
                    const MyBackButton(),
                    smallSpace,
                    const Text(
                      'Add Finances',
                      style: kHeadingTextStyle,
                    ),
                    const Spacer(),
                    RoundTextField(
                        controller: nameController,
                        title: "Title",
                        isPassword: false,
                        onSaved: (String? value) {
                          name != value;
                        },
                        validator: (value) =>
                            AccRecValidator.validateName(name: value)),
                    const Spacer(),
                    if (records)
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            const Text(
                              'Records Type',
                              style: kSubTextStyle,
                            ),
                            DropdownButtonFormField(
                              value: dropdownrectypevalue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownrectypevalue = newValue!;
                                });
                              },
                              items: recordType.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ),
                            space,
                          ],
                        ),
                      ),

                    //add minus transaction bar
                  ],
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    space,
                    RoundDoubleTextField(
                        controller: amountController,
                        title: "Amount",
                        onSaved: (String? value) {
                          amount != value;
                        },
                        validator: (value) =>
                            AccRecValidator.validateAmount(name: amount)),
                    space,
                    if (records)
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            const Text(
                              'Accounts Type',
                              style: kSubTextStyle,
                            ),
                            DropdownButtonFormField(
                              value: dropdownvalue,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownvalue = newValue!;
                                });
                              },
                              items: accounts.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ),
                            space,
                            const Text(
                              'Record Category',
                              style: kSubTextStyle,
                            ),
                            DropdownButtonFormField(
                              value: dropdownrecvalue,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownrecvalue = newValue!;
                                });
                              },
                              items: record.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem(
                                  child: Text(value),
                                  value: value,
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    space,
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
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
              )),
            ],
          ),
        ),
      ),
    );
  }
}
