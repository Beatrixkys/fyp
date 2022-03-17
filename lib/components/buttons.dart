import 'package:flutter/material.dart';

import '../constant.dart';

class SmallButton extends StatelessWidget {
  final String title;
  final String route;
  final Color color;

  const SmallButton(
      {Key? key, required this.title, required this.route, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        onPressed: () {},
        child: Center(
          child: Text(
            title,
            style: kButtonTextStyle,
          ),
        ),
      ),
    );
  }
}

class FinanceButton extends StatelessWidget {
  final Color bgColor;
  final Color btnColor;
  final IconData icon;

  const FinanceButton(
      {Key? key,
      required this.bgColor,
      required this.btnColor,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: ShapeDecoration(
        color: bgColor,
        shape: const CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(icon),
        color: btnColor,
        onPressed: () {},
      ),
    );
  }
}

class MyBackButton extends StatelessWidget {
  const MyBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'backButton',
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: kSteelBlue,
          ),
        ),
      ),
    );
  }
}
