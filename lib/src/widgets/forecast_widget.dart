import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  final String title;
  final String image;
  final String value;

  const ForecastWidget({
    Key key,
    this.title,
    this.image,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenSize = 22.7 * MediaQuery.of(context).devicePixelRatio;
    return Container(
      width: 100.0,
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Container(
            width: screenSize,
            height: screenSize,
            child: Image.asset(
              image,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
