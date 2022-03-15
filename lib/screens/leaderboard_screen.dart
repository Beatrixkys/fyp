import 'package:flutter/material.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/components/round_text.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/menu.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

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
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
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
                        onPressed: () {},
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
            SizedBox(
              height: 250,
              width: 350,

              child: Column(
                children: const [
                  RoundText(number: "1", name: "Beatrix", progress: "40"),
                ],
              ), //populate with numbers from the database
            ),
            space,

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20,
              ),
              decoration: BoxDecoration(
                  color: kTan, borderRadius: BorderRadius.circular(40)),
              height: 200,
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
                  RoundFriend(
                      title: 'Evan',
                      route1: '/leaderboard',
                      route2: '/leaderboard'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
