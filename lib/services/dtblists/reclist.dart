import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/models/finance.dart';
import 'package:fyp/services/database.dart';
import 'package:provider/provider.dart';

class RecordList extends StatefulWidget {
  const RecordList({Key? key}) : super(key: key);

  @override
  State<RecordList> createState() => _RecordListState();
}

class _RecordListState extends State<RecordList> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    final records = Provider.of<List<RecordsData>>(context);
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    return ListView.builder(
      itemCount: records.length,
      itemBuilder: (context, index) {
        return RecordsTile(record: records[index], uid: uid);
      },
    );
  }
}

class RecordsTile extends StatelessWidget {
  const RecordsTile({Key? key, required this.record, required this.uid})
      : super(key: key);

  final RecordsData record;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage('assets/cash.png'),
          ),
          title: Text(
            record.name,
            style: kTitleTextstyle,
          ),
          subtitle: Text('RM ${record.amount} of ${record.recordtype} '),
          trailing: SizedBox(
            width: 96,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.delete_outlined),
                  onPressed: () async {
                    await DatabaseService(uid).deleteRecord(record.recordid);
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
