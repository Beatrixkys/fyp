import 'package:flutter/material.dart';

class MyHeader extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final Color color;
  const MyHeader(
      {Key? key,
      required this.height,
      required this.width,
      required this.child,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(40.0),
            bottomLeft: Radius.circular(40.0),
          )),
      height: height,
      width: width,
      child: child,
    );
  }
}
