import 'package:flutter/material.dart';
import 'package:fyp/models/finance.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class AccountList extends StatefulWidget {
  const AccountList({Key? key}) : super(key: key);

  @override
  State<AccountList> createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  @override
  Widget build(BuildContext context) {
    final accounts = Provider.of<List<AccountsData>>(context);

    return ListView.builder(
      itemCount: accounts.length,
      itemBuilder: (context, index) {
        return AccountsTile(account: accounts[index]);
      },
    );
  }
}

class AccountsTile extends StatelessWidget {
  const AccountsTile({Key? key, required this.account}) : super(key: key);

  final AccountsData account;

  @override
  Widget build(BuildContext context) {
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

          //TODO!: Add a popout to choose delete or edit options
          trailing: IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
