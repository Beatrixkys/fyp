import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fyp/components/cards.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/components/loading.dart';
import 'package:fyp/components/round_text_field.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/database.dart';

class SetUpProfileAndAccountsScreen extends StatefulWidget {
  const SetUpProfileAndAccountsScreen({Key? key}) : super(key: key);

  @override
  State<SetUpProfileAndAccountsScreen> createState() =>
      _SetUpProfileAndAccountsScreenState();
}

class _SetUpProfileAndAccountsScreenState
    extends State<SetUpProfileAndAccountsScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //push data into firebase here

//Form
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();
  bool loading = false;

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

    String name = "";
    String amount = "";

    return loading
        ? const Loading()
        : Scaffold(
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
                          space,
                          space,
                          Text(
                            'Set Up and Profile and Accounts',
                            style: kHeadingTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          space,
                          const Text(
                            'Choose Persona',
                            style: kTitleTextstyle,
                          ),
                          space,
                          SizedBox(
                            width: width,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PersonaCardSetUp(
                                    icon: "assets/eagle.png",
                                    title: "Eagle",
                                    user: uid,
                                    personaname: "Eagle",
                                    personaDescription: "Amount Based",
                                  ), //switch cases in the page below
                                  PersonaCardSetUp(
                                    icon: "assets/pigeon.png",
                                    title: "Pigeon",
                                    user: uid,
                                    personaname: "Pigeon",
                                    personaDescription: "Percentage Based",
                                  ),
                                  PersonaCardSetUp(
                                    icon: "assets/owl.png",
                                    title: "Owl",
                                    user: uid,
                                    personaname: "Owl",
                                    personaDescription: "Consistency Based",
                                  ),
                                ],
                              ),
                            ),
                          ),
                          space,
                          SizedBox(
                            width: 300,
                            child: Row(
                              children: [
                                const Spacer(),
                                const Text(
                                  'Add Accounts',
                                  style: kTitleTextstyle,
                                ),
                                IconButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        //setState(() => loading = true);
                                        var name = nameController.value.text;
                                        int amount = int.parse(
                                            amountController.value.text);

                                        await DatabaseService(uid)
                                            .saveAccount(name, amount);

                                        nameController.clear();
                                        amountController.clear();
                                      }
                                    },
                                    icon: const Icon(Icons.add_circle_outline)),
                                const Spacer(),
                              ],
                            ),
                          ),
                          space,
                          RoundTextField(
                              controller: nameController,
                              isPassword: false,
                              title: "Accounts Name",
                              onSaved: (String? value) {
                                name != value;
                              },
                              validator: nameVal),
                          space,
                          RoundDoubleTextField(
                              controller: amountController,
                              title: "Accounts Amount",
                              onSaved: (String? value) {
                                amount != value;
                              },
                              validator: nameVal),
                          space,
                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() => loading = true);
                                  var name = nameController.value.text;
                                  int amount =
                                      int.parse(amountController.value.text);

                                  await DatabaseService(uid)
                                      .saveAccount(name, amount);
                                }

                                Navigator.pushNamed(context, '/home');
                              },
                              child: const Text(
                                'Next',
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
