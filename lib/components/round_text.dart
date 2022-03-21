import 'package:flutter/material.dart';
import 'package:fyp/constant.dart';

class RoundText extends StatelessWidget {
  final String number;
  final String name;
  final String progress;

  const RoundText({
    Key? key,
    required this.number,
    required this.name,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 400,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            border: Border.all(
                width: 1, color: kSteelBlue, style: BorderStyle.solid)),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                number,
                style: kTitleTextstyle,
              ),
            ),
            const Spacer(),
            Text(
              name,
              style: kTitleTextstyle,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                progress,
                style: kTitleTextstyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoundFunctionText extends StatelessWidget {
  final String title;
  final String subtitle;
  final Icon icon1;
  final Icon icon2;

  const RoundFunctionText({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.icon1,
    required this.icon2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: 400,
        height: 50,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          border:
              Border.all(width: 1, color: kLightBlue, style: BorderStyle.solid),
          color: kLightBlue,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                title,
                style: kTitleTextstyle,
              ),
            ),
            const Spacer(),
            Text(
              subtitle,
              style: kSubTextStyle,
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: icon1),
            IconButton(onPressed: () {}, icon: icon2),
          ],
        ),
      ),
    );
  }
}

class TitleCard extends StatelessWidget {
  final String title;
  final String route;
  final String button;

  const TitleCard(
      {Key? key,
      required this.title,
      required this.route,
      required this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kTitleTextstyle,
          ),
          const Spacer(),
          TextButton(
            child: Text(
              button,
              style: const TextStyle(
                color: kSteelBlue,
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, route);
            },
          ),
        ],
      ),
    );
  }
}
