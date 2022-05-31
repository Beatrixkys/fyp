import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:fyp/components/cards.dart';
import 'package:fyp/components/round_text_field.dart';
import 'package:fyp/models/finance.dart';
import 'package:fyp/services/database.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class AccountList extends StatefulWidget {
  const AccountList({Key? key}) : super(key: key);

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    final accounts = Provider.of<List<AccountsData>>(context);

    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return AccountsTile(account: accounts[index], uid: uid);
      },
    );
  }
}

class AccountsTile extends StatelessWidget {
  const AccountsTile({Key? key, required this.account, required this.uid})
      : super(key: key);

  final AccountsData account;
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
              child: AccountSettingsForm(
                uid: uid,
                aid: account.accountid,
                aname: account.name,
                aamount: account.amount,
              ),
            );
          });
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/finance.png'),
          ),
          title: Text(
            account.name,
            style: kTitleTextstyle,
          ),
          subtitle: Text('RM ${account.amount}'),
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
                    await DatabaseService(uid).deleteAccount(account.accountid);
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

class AccountSettingsForm extends StatefulWidget {
  const AccountSettingsForm(
      {Key? key,
      required this.uid,
      required this.aid,
      required this.aname,
      required this.aamount})
      : super(key: key);

  final String uid;
  final String aid;
  final String aname;
  final int aamount;

  @override
  State<AccountSettingsForm> createState() => _AccountSettingsFormState();
}

class _AccountSettingsFormState extends State<AccountSettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final amountController = TextEditingController();

  final nameVal =
      MultiValidator([RequiredValidator(errorText: 'Field is Required')]);

  @override
  Widget build(BuildContext context) {
    String name = widget.aname;
    String amount = widget.aamount.toString();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Edit Account',
            style: kHeadingTextStyle,
          ),
          space,
          const Text(
            'Account Name',
            style: kSubTextStyle,
          ),
          RoundTextField(
              controller: nameController,
              title: name,
              isPassword: false,
              onSaved: (String? value) {
                name != value;
              },
              validator: nameVal),
          space,
          const Text(
            'Account Amount ',
            style: kSubTextStyle,
          ),
          RoundDoubleTextField(
              controller: amountController,
              title: amount,
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
                  //setState(() => loading = true);
                  var name = nameController.value.text;
                  int amount = int.parse(amountController.value.text);

                  await DatabaseService(widget.uid)
                      .updateAccount(name, amount, widget.aid);
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
    );
  }
}

class AccountCardList extends StatefulWidget {
  const AccountCardList({Key? key}) : super(key: key);

  @override
  State<AccountCardList> createState() => _AccountCardListState();
}

class _AccountCardListState extends State<AccountCardList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final accounts = Provider.of<List<AccountsData>>(context);
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return AccountsCard(account: accounts[index], uid: uid);
      },
    );
  }
}
