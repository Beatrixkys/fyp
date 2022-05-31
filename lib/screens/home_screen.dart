import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/components/cards.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/components/progress_bar.dart';
import 'package:fyp/components/round_text.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/models/goals.dart';
import 'package:fyp/services/database.dart';
import 'package:fyp/services/dtblists/goallist.dart';
import 'package:fyp/services/menu.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    //visuals
    double width = MediaQuery.of(context).size.width;

    //profile
    String profileImage = 'assets/owl.png';

    //goals
    double overallProgress = 0.8;

    //finances
    double total = 1000;
    double income = 150;
    double expense = 50;

    final controller = ScrollController();

    return MultiProvider(
        providers: [
          StreamProvider<List<GoalsData>>.value(
              value: DatabaseService(uid).goals, initialData: const []),
          //StreamProvider<List<FriendRequestData>>.value(
          //value: DatabaseService(uid).friendreqs, //initialData: const [])
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
                    height: 200,
                    width: width,
                    color: kApricot,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 0.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                CircularPercentIndicator(
                                  radius: 80.0,
                                  lineWidth: 8.0,
                                  animation: true,
                                  percent: overallProgress,
                                  circularStrokeCap: CircularStrokeCap.round,
                                  progressColor: kCream,
                                  backgroundColor: kApricot,
                                  center: CircleAvatar(
                                    backgroundColor: kCream,
                                    radius: 50.0,
                                    backgroundImage: AssetImage(
                                      profileImage,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Welcome Back!',
                                      textAlign: TextAlign.start,
                                      style: kHeadingTextStyle,
                                    ),
                                    Text(
                                      'Total Assets:RM $total',
                                      textAlign: TextAlign.start,
                                      style: kSubTextStyle,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        const TitleCard(
                          title: "Overview of the Month",
                          route: "/finance",
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
                                  title: "Income", amount: '$income'),
                              ExpenditureCard(
                                  title: "Expense", amount: '$expense'),
                              space,
                            ],
                          ),
                        ),

                        const TitleCard(
                            title: "Goals",
                            route: "/goals",
                            button: "See More"),

                        const SizedBox(
                          width: 350,
                          height: 250,
                          child: GoalCardList(),
                        ),

                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/setupprofile');
                            },
                            icon: const Icon(Icons.portrait_outlined)),

                        IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/biosignin');
                            },
                            icon: const Icon(Icons.fingerprint)),
                        //Insert list view for Finance transfaction hisotry, retrieve from database, create placeholder for now,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
