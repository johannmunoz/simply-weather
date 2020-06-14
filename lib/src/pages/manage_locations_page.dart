import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/src/models/search_model.dart';

class ManageLocationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManageLocationsPageState();
  }
}

class _ManageLocationsPageState extends State<ManageLocationsPage> {
  static List<SearchInfo> _locations = [];

  @override
  void initState() {
    _getLocations();
    super.initState();
  }

  void _getLocations() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> locationsJson = prefs.getStringList('locations') ?? [];
    final locations =
        locationsJson.map((location) => SearchInfo.fromJson(location)).toList();

    setState(() {
      _locations = locations;
    });
  }

  void _onReorder(int oldIndex, int newIndex) async {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final location = _locations.removeAt(oldIndex);
      _locations.insert(newIndex, location);
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'locations', _locations.map((e) => e.toJson()).toList());
  }

  Widget buildListTile(SearchInfo location) {
    Widget listTile;
    listTile = ListTile(
      key: Key(location.id.toString()),
      leading: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          setState(() {
            _locations.remove(location);
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();

          prefs.setStringList(
              'locations', _locations.map((e) => e.toJson()).toList());
        },
      ),
      title: Text('${location.name}, ${location.sys.country}'),
      trailing: Icon(Icons.drag_handle),
    );
    return listTile;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Navigator.of(context).pushReplacementNamed("/", result: true);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
                context, "/", (Route<dynamic> route) => false),
          ),
          title: Text('Manage Locations'),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add a new location',
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
      ),
    );
  }
}
