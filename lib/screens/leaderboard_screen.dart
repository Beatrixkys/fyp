import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/components/round_text.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/models/friends.dart';
import 'package:fyp/services/database.dart';
import 'package:fyp/services/dtblists/friendlist.dart';
import 'package:fyp/services/menu.dart';
import 'package:provider/provider.dart';

class LeaderboardScreen extends StatelessWidget {
  LeaderboardScreen({Key? key}) : super(key: key);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    final controller = ScrollController();
    double width = MediaQuery.of(context).size.width;

    return MultiProvider(
        providers: [
          StreamProvider<List<FriendsData>>.value(
              value: DatabaseService(uid).friends, initialData: const []),
          StreamProvider<List<FriendRequestData>>.value(
              value: DatabaseService(uid).friendreqs, initialData: const [])
        ],
        builder: (context, snapshot) {
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 0.0),
                      child: Row(
                        children: [
                          const Text(
                            'Leaderboard',
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
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      _buildPopupDialog(context),
                                );
                              },
                              child: const Center(
                                child: Text(
                                  'Add Friend',
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
                    ),
                  ),
                  //convert to single scroll within the columns/list view
                  space,
                  const SizedBox(
                    height: 400,
                    width: 350,

                    child: LeaderboardList(),
                    //populate with numbers from the database
                  ),

                  space,

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                        color: kTan, borderRadius: BorderRadius.circular(40)),
                    height: 350,
                    width: 400,
                    child: Column(
                      children: const [
                        Text(
                          'Pending Friend Requests',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 22.0,
                            color: kSubTitleTextColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        space,
                        SizedBox(
                          height: 250,
                          width: 350,

                          child: FriendRequestList(),
                          //populate with numbers from the database
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Search Friends'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("Hello"),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
