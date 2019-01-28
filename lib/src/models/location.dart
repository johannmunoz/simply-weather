import 'package:intl/intl.dart';

class Location {
  final String name;
  final String country;
  final String localtime;

  Location({
    this.name,
    this.country,
    this.localtime,
  });

  factory Location.fromJson(Map<String, dynamic> parsedJson) {
    var arrayDate = parsedJson['localtime'].split(" ");
    var arrayTime = arrayDate[1].split(':');
    var dateFormated = '';
    final f = DateFormat('EEEE, hh:mm aaa');

    if (int.parse(arrayTime[0]) < 10) {
      dateFormated = arrayDate[0] + ' 0' + arrayDate[1] + ':00';
    } else {
      dateFormated = parsedJson['localtime'] + ':00';
    }

    return Location(
      name: parsedJson['name'],
      country: parsedJson['country'],
      localtime: f.format(DateTime.parse(dateFormated)),
    );
  }
}
