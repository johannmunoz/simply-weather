import 'package:flutter/material.dart';

class ManageLocationsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ManageLocationsPageState();
  }
}

class _ManageLocationsPageState extends State<ManageLocationsPage> {
  static List<String> _locations = [];

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String location = _locations.removeAt(oldIndex);
      _locations.insert(newIndex, location);
    });
    print(_locations);
  }

  Widget buildListTile(String location) {
    Widget listTile;
    listTile = ListTile(
      key: Key(location),
      leading: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {},
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
        title: Text('Manage Locations'),
      ),
      body: _locations.length > 0
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
    );
  }
}
