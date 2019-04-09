import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageLocationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManageLocationsPageState();
  }
}

class _ManageLocationsPageState extends State<ManageLocationsPage> {
  static List<String> _locations = [];

  @override
  void initState() {
    _getLocations();
    super.initState();
  }

  void _getLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _locations = prefs.getStringList('locations') ?? [];
    });
  }

  void _onReorder(int oldIndex, int newIndex) async {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String location = _locations.removeAt(oldIndex);
      _locations.insert(newIndex, location);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('locations', _locations);
  }

  Widget buildListTile(String location) {
    Widget listTile;
    listTile = ListTile(
      key: Key(location),
      leading: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          setState(() {
            _locations.remove(location);
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setStringList('locations', _locations);
        },
      ),
      title: Text(location),
      trailing: Icon(Icons.drag_handle),
    );
    return listTile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, "/", (Route<dynamic> route) => false),
        ),
        title: Text('Manage Locations'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/add-location'),
      ),
      body: SafeArea(
        child: _locations.length > 0
            ? Scrollbar(
                child: ReorderableListView(
                  onReorder: _onReorder,
                  children: _locations.map(buildListTile).toList(),
                ),
              )
            : Center(
                child: Text(
                  'No locations to show',
                  style: TextStyle(color: Colors.black),
                ),
              ),
      ),
    );
  }
}
