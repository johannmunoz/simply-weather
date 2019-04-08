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
    return Container(
      width: 100.0,
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.body2,
          ),
          Container(
            width: 60.0,
            height: 60.0,
            child: Image.asset(
              image,
            ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.body2,
          ),
        ],
      ),
    );
  }
}
