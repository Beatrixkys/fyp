import 'package:flutter/material.dart';
import 'package:fyp/constant.dart';
import 'package:fyp/services/database.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

//Finances

class FinancialCard extends StatelessWidget {
  final String icon;
  final String title;
  final String route;

  const FinancialCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.route,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        padding: const EdgeInsets.all(15),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE5E5E5),
          ),
        ),
        child: Column(
          children: <Widget>[
            Image.asset(icon, height: 50),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class AccountsCard extends StatelessWidget {
  final String icon;
  final String title;
  final String text;

  const AccountsCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: 130,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        color: Colors.white,
      ),
      child: Column(
        children: <Widget>[
          Image.asset(icon, height: 90),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ExpenditureCard extends StatelessWidget {
  final String title;
  final String amount;

  const ExpenditureCard({Key? key, required this.title, required this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 175,
      height: 150,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Center(
        child: Column(
          children: [
            Text(
              title,
              style: kSubTextStyle,
            ),
            const Text("RM", style: kTitleTextstyle),
            Text(
              amount,
              style: kHeadingTextStyle,
            ),
          ],
        ),
      ),
    );
  }
}

//Goals

class GoalCard extends StatelessWidget {
  final double percent; //use persona image
  final String title;
  final String text;

  const GoalCard({
    Key? key,
    required this.percent,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 250,
        width: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: kLightBlue,
          border: Border.all(
            color: const Color(0xFFE5E5E5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularPercentIndicator(
                animation: true,
                radius: 65.0,
                percent: percent,
                lineWidth: 10.0,
                circularStrokeCap: CircularStrokeCap.round,
                backgroundColor: Colors.white10,
                progressColor: Colors.white,
                center: Text(
                  '${(percent * 100).round()}%',
                  style: const TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              text,
            ),
          ],
        ),
      ),
    );
  }
}

class PersonaCard extends StatelessWidget {
  final String icon;
  final String title;
  final String user;
  final String personaname;
  final String personaDescription;

  const PersonaCard({
    Key? key,
    required this.icon,
    required this.title,
    required this.user,
    required this.personaname,
    required this.personaDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DatabaseService(user).updatePersona(personaname, personaDescription);
      }, //update database details
      child: Container(
        height: 160,
        width: 120,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Image.asset(icon, height: 110),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonaCardSetUp extends StatelessWidget {
  final String icon;
  final String title;
  final String user;
  final String personaname;
  final String personaDescription;

  const PersonaCardSetUp({
    Key? key,
    required this.icon,
    required this.title,
    required this.user,
    required this.personaname,
    required this.personaDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DatabaseService(user).savePersona(personaname, personaDescription);
      }, //update database details
      child: Container(
        height: 160,
        width: 120,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: <Widget>[
            Image.asset(icon, height: 110),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
