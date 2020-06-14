import 'dart:convert';

class SearchModel {
  List<SearchInfo> list;
  SearchModel({
    this.list,
  });

  Map<String, dynamic> toMap() {
    return {
      'list': list?.map((x) => x?.toMap())?.toList(),
    };
  }

  static SearchModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return SearchModel(
      list:
          List<SearchInfo>.from(map['list']?.map((x) => SearchInfo.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  static SearchModel fromJson(String source) => fromMap(json.decode(source));
}

class SearchInfo {
  int id;
  String name;
  Coord coord;
  Sys sys;

  SearchInfo({
    this.id,
    this.name,
    this.coord,
    this.sys,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'coord': coord?.toMap(),
      'sys': sys?.toMap(),
    };
  }

  static SearchInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return SearchInfo(
      id: map['id'],
      name: map['name'],
      coord: Coord.fromMap(map['coord']),
      sys: Sys.fromMap(map['sys']),
    );
  }

  String toJson() => json.encode(toMap());

  static SearchInfo fromJson(String source) => fromMap(json.decode(source));
}

class Sys {
  String country;
  Sys({
    this.country,
  });

  Map<String, dynamic> toMap() {
    return {
      'country': country,
    };
  }

  static Sys fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Sys(
      country: map['country'],
    );
  }

  String toJson() => json.encode(toMap());

  static Sys fromJson(String source) => fromMap(json.decode(source));
}

class Coord {
  double lat;
  double lon;
  Coord({
    this.lat,
    this.lon,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lon': lon,
    };
  }

  static Coord fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Coord(
      lat: map['lat'],
      lon: map['lon'],
    );
  }

  String toJson() => json.encode(toMap());

  static Coord fromJson(String source) => fromMap(json.decode(source));
}
