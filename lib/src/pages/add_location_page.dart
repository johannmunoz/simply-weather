import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/blocs/weather_bloc.dart';
import 'package:weather_app/src/models/search_model.dart';

class AddLocationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddLocationPage();
  }
}

class _AddLocationPage extends State<AddLocationPage> {
  final TextEditingController _filter = TextEditingController();
  List<SearchInfo> _locations = [];
  Timer _debounce;

  @override
  void initState() {
    _filter.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 1000), () {
      if (_filter.text.length > 3) bloc.fetchSearchList(_filter.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _filter,
                autofocus: true,
                cursorColor: Colors.white,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.words,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: 'Search...',
                ),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              _filter.clear();
              setState(() {
                _locations.clear();
              });
            },
          )
        ],
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: bloc.getListLocations,
          builder: (context, AsyncSnapshot<SearchModel> snapshot) {
            if (!snapshot.hasData) {
              if (_filter.text.isEmpty) {
                return Container(
                  alignment: Alignment.topCenter,
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Type a location',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              }
              return Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  child: CircularProgressIndicator(),
                  height: 40.0,
                  width: 40.0,
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            _locations = snapshot.data.list;

            if (_locations.isEmpty) {
              return Container(
                alignment: Alignment.topCenter,
                padding: EdgeInsets.only(top: 20.0),
                child: Text(
                  'No values to show',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: _locations.length,
              itemBuilder: (context, index) {
                final location = _locations[index];
                final locationLabel =
                    '${location.name}, ${location.sys.country}';
                return GestureDetector(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    List<String> locationsStored =
                        prefs.getStringList('locations') ?? [];
                    locationsStored.add(location.toJson());
                    await prefs.setStringList('locations', locationsStored);

                    Navigator.pushNamedAndRemoveUntil(
                        context, "/", (Route<dynamic> route) => false);
                  },
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        title: Text(locationLabel),
                      ),
                      Divider(),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _filter.removeListener(_onSearchChanged);
    _filter.dispose();
    _debounce.cancel();
    super.dispose();
  }
}
