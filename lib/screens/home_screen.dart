import 'package:flutter/material.dart';
import 'package:fyp/components/cards.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/components/progress_bar.dart';
import 'package:fyp/components/round_text.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/menu.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //visuals
    double width = MediaQuery.of(context).size.width;

    //goals
    double overallProgress = 0.8;
    List<double> percent = [0.75, 0.6, 0.3];

    //finances
    double total = 1000;
    double income = 150;
    double expense = 50;

    final controller = ScrollController();

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
                            center: const CircleAvatar(
                              backgroundColor: kCream,
                              radius: 50.0,
                              backgroundImage: AssetImage(
                                'assets/owl.png',
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
                    route: "/",
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
                        ExpenditureCard(title: "Income", amount: '$income'),
                        ExpenditureCard(title: "Expense", amount: '$expense'),
                        space,
                      ],
                    ),
                  ),

                  const TitleCard(
                      title: "Goals", route: "/goals", button: "See More"),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GoalCard(
                            percent: percent[0],
                            title: "Save",
                            text: "50% of income"),
                        GoalCard(
                            percent: percent[1],
                            title: "Reduce",
                            text: "20% of expense"),
                        GoalCard(
                            percent: percent[2],
                            title: "Invest",
                            text: "10% of savings"),
                      ],
                    ),
                  ),

                  //Insert list view for Finance transfaction hisotry, retrieve from database, create placeholder for now,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
