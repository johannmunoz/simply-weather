import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final String value;

  const ForecastWidget({
    Key key,
    this.title,
    this.icon,
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
          SizedBox(
            height: 5.0,
          ),
          Icon(
            icon,
            size: 45.0,
          ),
          SizedBox(
            height: 5.0,
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
