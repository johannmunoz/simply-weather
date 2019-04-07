class AssetsLibrary {
  final Map<String, String> assets = {
    '10000': 'clear',
    '10001': 'sunny',
    '10030': 'partly_cloudy_night',
    '10031': 'partly_cloudy_day',
    '10060': 'partly_cloudy_night',
    '10061': 'cloudy',
    '10090': 'cloudy',
    '10091': 'cloudy',
    '10300': 'windy',
    '10301': 'windy',
    '10630': 'light_rain_night',
    '10631': 'light_rain_day',
    '10660': 'snow',
    '10661': 'snow',
    '10690': 'light_rain_night',
    '10691': 'light_rain_day',
    '10720': 'light_rain',
    '10721': 'light_rain',
    '10870': 'thundery_rainy_night',
    '10871': 'thundery_rainy_day',
    '11140': 'snow',
    '11141': 'snow',
    '11170': 'snow',
    '11171': 'snow',
    '11350': 'windy',
    '11351': 'windy',
    '11470': 'windy',
    '11471': 'windy',
    '11500': 'light_rain',
    '11501': 'light_rain',
    '11530': 'light_rain',
    '11531': 'light_rain',
    '11680': 'light_rain',
    '11681': 'light_rain',
    '11710': 'heavy_rain',
    '11711': 'heavy_rain',
    '11800': 'light_rain_night',
    '11801': 'light_rain_day',
    '11830': 'light_rain',
    '11831': 'light_rain',
    '11860': 'light_rain_night',
    '11861': 'light_rain_day',
    '11890': 'light_rain',
    '11891': 'light_rain',
    '11920': 'heavy_rain_night',
    '11921': 'heavy_rain_day',
    '11950': 'heavy_rain',
    '11951': 'heavy_rain',
    '11980': 'light_rain',
    '11981': 'light_rain',
    '12010': 'light_rain',
    '12011': 'light_rain',
    '12040': 'light_rain',
    '12041': 'light_rain',
    '12070': 'light_rain',
    '12071': 'light_rain',
    '12100': 'snow',
    '12101': 'snow',
    '12130': 'snow',
    '12131': 'snow',
    '12160': 'snow',
    '12161': 'snow',
    '12190': 'snow',
    '12191': 'snow',
    '12220': 'snow',
    '12221': 'snow',
    '12250': 'snow',
    '12251': 'snow',
    '12370': 'snow',
    '12371': 'snow',
    '12400': 'light_rain_night',
    '12401': 'light_rain_day',
    '12430': 'heavy_rain_night',
    '12431': 'heavy_rain_day',
    '12460': 'heavy_rain_night',
    '12461': 'heavy_rain_day',
    '12490': 'light_rain_night',
    '12491': 'light_rain_day',
    '12520': 'light_rain_night',
    '12521': 'light_rain_day',
    '12550': 'snow',
    '12551': 'snow',
    '12580': 'snow',
    '12581': 'snow',
    '12610': 'snow',
    '12611': 'snow',
    '12640': 'snow',
    '12641': 'snow',
    '12730': 'thundery_rainy_night',
    '12731': 'thundery_rainy_day',
    '12760': 'thundery_rainy_night',
    '12761': 'thundery_rainy_day',
    '12790': 'thundery_rainy_night',
    '12791': 'thundery_rainy_day',
    '12820': 'thundery_rainy_night',
    '12821': 'thundery_rainy_day',
  };

  String getAnimation(int code, int isDay) {
    final String key = code.toString() + isDay.toString();
    return "assets/animation/${assets[key]}.flr";
  }

  String getIcon(int code) {
    final String key = code.toString() + '1';
    return "assets/icon/${assets[key]}.png";
  }
}

final assetsLibrary = AssetsLibrary();
