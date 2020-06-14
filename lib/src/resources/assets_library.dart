class AssetsLibrary {
  String getAnimation(String iconCode) {
    final String filename = _getFileName(iconCode);
    return "assets/animation/$filename.flr";
  }

  String getIcon(String iconCode) {
    final String filename = _getFileName(iconCode);
    return "assets/icon/$filename.png";
  }

  String _getFileName(String iconCode) {
    switch (iconCode) {
      case '01n':
        return 'clear';
      case '01d':
        return 'sunny';
      case '02n':
        return 'partly_cloudy_night';
      case '02d':
        return 'partly_cloudy_day';
      case '03n':
      case '03d':
      case '04n':
      case '04d':
        return 'cloudy';
      case '09d':
        return 'heavy_rain_day';
      case '09n':
        return 'heavy_rain_night';
      case '10d':
        return 'light_rain_day';
      case '10n':
        return 'light_rain_night';
      case '11d':
        return 'thundery_rainy_day';
      case '11n':
        return 'thundery_rainy_night';
      case '13d':
      case '13n':
        return 'snow';
      case '50d':
      case '50n':
        return 'windy';

      default:
        return 'partly_cloudy_day';
    }
  }
}

final assetsLibrary = AssetsLibrary();
