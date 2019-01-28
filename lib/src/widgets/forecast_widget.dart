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
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white70,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Icon(
            icon,
            color: Colors.white70,
            size: 45.0,
          ),
          SizedBox(
            height: 5.0,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.body1,
          ),
        ],
      ),
    );
  }
}
