import 'package:flutter/material.dart';
import 'package:fyp/components/cards.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/components/round_text_field.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/validator.dart';

class SetUpProfileAndAccountsScreen extends StatefulWidget {
  const SetUpProfileAndAccountsScreen({Key? key}) : super(key: key);

  @override
  State<SetUpProfileAndAccountsScreen> createState() =>
      _SetUpProfileAndAccountsScreenState();
}

class _SetUpProfileAndAccountsScreenState
    extends State<SetUpProfileAndAccountsScreen> {
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            PersonaCard(
                                icon: "assets/eagle.png",
                                title: "Eagle",
                                action:
                                    '/eaglePersona'), //switch cases in the page below
                            PersonaCard(
                                icon: "assets/pigeon.png",
                                title: "Pigeon",
                                action: '/pigonPersona'),
                            PersonaCard(
                                icon: "assets/owl.png",
                                title: "Owl",
                                action: '/owlPersona'),
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
                              onPressed: () {},
                              icon: const Icon(Icons.add_circle_outline)),
                          const Spacer(),
                        ],
                      ),
                    ),
                    space,
                    RoundDoubleTextField(
                        controller: nameController,
                        title: "Accounts Name",
                        onSaved: (String? value) {
                          name != value;
                        },
                        validator: (value) =>
                            AccRecValidator.validateName(name: name)),
                    space,
                    RoundDoubleTextField(
                        controller: amountController,
                        title: "Accounts Amount",
                        onSaved: (String? value) {
                          amount != value;
                        },
                        validator: (value) =>
                            AccRecValidator.validateAmount(name: amount)),
                    space,
                    SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        onPressed: () {
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
