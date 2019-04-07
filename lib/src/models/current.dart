class Current {
  final double temperature;
  final Condition condition;
  final int humidity;
  final double precipitation;
  final double uv;
  final int isDay;

  Current(
      {this.temperature,
      this.condition,
      this.humidity,
      this.precipitation,
      this.uv,
      this.isDay});

  factory Current.fromJson(Map<String, dynamic> parsedJson) {
    return Current(
      temperature: parsedJson['temp_c'],
      condition: Condition.fromJson(parsedJson['condition']),
      humidity: parsedJson['humidity'],
      precipitation: parsedJson['precip_mm'],
      uv: parsedJson['uv'],
      isDay: parsedJson['is_day'],
    );
  }
}

class Condition {
  final String text;
  final String icon;
  final int code;

  Condition({this.text, this.icon, this.code});

  factory Condition.fromJson(Map<String, dynamic> parsedJson) {
    final formatedUrl = 'http:' + parsedJson['icon'];
    return Condition(
      text: parsedJson['text'],
      icon: formatedUrl,
      code: parsedJson['code'],
    );
  }
}
