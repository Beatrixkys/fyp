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
import 'package:fyp/models/finance.dart';
import 'package:fyp/services/database.dart';
import 'package:fyp/services/dtblists/acclist.dart';
import 'package:fyp/services/dtblists/reclist.dart';
import 'package:fyp/services/logic.dart';
import 'package:fyp/services/menu.dart';
import 'package:provider/provider.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({Key? key}) : super(key: key);

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    //visuals
    final controller = ScrollController();
    double width = MediaQuery.of(context).size.width;

    final User? user = _auth.currentUser;
    final uid = user!.uid;
    //finances

    int total = 0;

    Future<void> totalAsset() async {
      total = await LogicService(uid).totalAsset();
    }

    totalAsset();

    var incomeTotal = LogicService(uid).totalIncome();
    var expenseTotal = LogicService(uid).totalExpense();

    //double total = 1000;
    //double incomeTotal = 100;
    //double expenseTotal = 50;
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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool accounts = true;

  void toggleView() {
    setState(() {
      accounts = !accounts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    double width = MediaQuery.of(context).size.width;

    //final _formKey = GlobalKey<FormState>();

    return MultiProvider(
      providers: [
        StreamProvider<List<AccountsData>>.value(
            value: DatabaseService(uid).accounts, initialData: const []),
        StreamProvider<List<RecordsData>>.value(
            value: DatabaseService(uid).records, initialData: const [])
      ],
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
                    SizedBox(
                        height: 400,
                        child: accounts
                            ? const AccountList()
                            : const RecordList()),
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

class AddFinanceScreen extends StatefulWidget {
  const AddFinanceScreen({Key? key}) : super(key: key);

  @override
  State<AddFinanceScreen> createState() => _AddFinanceScreenState();
}

class _AddFinanceScreenState extends State<AddFinanceScreen> {
  //Form
  String dropdownaccvalue = 'Bank';
  String dropdownreccatvalue = 'Leisure';
  String dropdownrectypevalue = 'Income';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

//Condition for toggle key
  bool accountState = true;

  void toggleView() {
    setState(() {
      accountState = !accountState;
    });
  }

  final nameVal =
      MultiValidator([RequiredValidator(errorText: 'Field is Required')]);

  @override
  void dispose() {
    nameController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Add',
                          style: kHeadingTextStyle,
                        ),
                        Column(
                          children: [
                            const Text('Switch:'),
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
                                    accountState ? "Accounts" : " Records ",
                                    style: kButtonTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    RoundTextField(
                        controller: nameController,
                        title: "Name",
                        isPassword: false,
                        onSaved: (String? value) {
                          name != value;
                        },
                        validator: nameVal),
                    const Spacer(),
                    if (!accountState)
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
                        validator: nameVal),
                    space,
                    if (!accountState)
                      SizedBox(
                        width: 300,
                        child: Column(
                          children: [
                            const Text(
                              'Accounts Type',
                              style: kSubTextStyle,
                            ),
                            DropdownButtonFormField(
                              value: dropdownaccvalue,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownaccvalue = newValue!;
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
                              value: dropdownreccatvalue,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownreccatvalue = newValue!;
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
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //setState(() => loading = true);
                            var name = nameController.value.text;
                            int amount = int.parse(amountController.value.text);
                            var recordtype = dropdownrectypevalue;
                            var accname = dropdownaccvalue;
                            var recordcategory = dropdownreccatvalue;

                            accountState
                                ? await DatabaseService(uid)
                                    .saveAccount(name, amount)
                                : DatabaseService(uid).saveRecord(name, amount,
                                    recordtype, recordcategory, accname);
                          }

                          Navigator.pushNamed(context, '/finance');
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
