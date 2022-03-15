import 'package:flutter/material.dart';
import 'package:fyp/components/cards.dart';
import 'package:fyp/components/header.dart';
import 'package:fyp/components/progress_bar.dart';
import 'package:fyp/components/round_text.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/menu.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double percent = 0.75;
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
              height: 120,
              width: width,
              color: kApricot,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Goals',
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
                  const ProgressBar(percent: 0.5, progress: "50%"),
                ],
              ),
            ),

            const TitleCard(
                title: "Current Goals", route: "/finance", button: "Manage"),
            space,

            SizedBox(
              width: width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GoalCard(
                        percent: percent, title: "Save", text: "50% of income"),
                    const SizedBox(width: 5),
                    const GoalCard(
                        percent: 0.6, title: "Reduce", text: "20% of expense"),
                    const SizedBox(width: 5),
                    const GoalCard(
                        percent: 0.3, title: "Invest", text: "10% of savings"),
                  ],
                ),
              ),
            ),

            space,

            const TitleCard(
              title: "Goals Achievement",
              route: "/home",
              button: "See More",
            ),
            smallSpace,

            //insert graph
          ],
        ),
      ),
    );
  }
}
