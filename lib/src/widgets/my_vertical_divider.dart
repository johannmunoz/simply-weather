import 'package:flutter/material.dart';

class MyVerticalDivider extends StatelessWidget {
  MyVerticalDivider(
      {@required this.height,
      this.width = 1.0,
      this.color = Colors.white,
      this.margin = 0.0});

  final double height;
  final double width;
  final Color color;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: margin),
      height: 90.0,
      width: 1.0,
      color: Colors.white70,
    );
  }
}
