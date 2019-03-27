class SearchModel {
  final List<SearchInfo> locations;

  SearchModel({this.locations});

  factory SearchModel.fromJson(List<dynamic> parsedJson) {
    List<SearchInfo> locations = List<SearchInfo>();

    locations = parsedJson.map((i) => SearchInfo.fromJson(i)).toList();

    return SearchModel(
      locations: locations,
    );
  }
}

class SearchInfo {
  final String name;

  SearchInfo({this.name});

  factory SearchInfo.fromJson(Map<String, dynamic> parsedJson) {
    return SearchInfo(
      name: parsedJson['name'],
    );
  }
}
