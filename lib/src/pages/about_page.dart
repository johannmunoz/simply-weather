import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        children: <Widget>[
          Text(
            'About me',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'I am awesome and you know it.',
            style: TextStyle(color: Colors.black),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(
            'About the others',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            'Bottom Icons by...',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Icons by...',
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
