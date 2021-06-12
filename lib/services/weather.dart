import 'package:clima/Location.dart';
import 'package:clima/services/networking.dart';

const PersonalApiKey = '065658292da33aa352ae089f58ffa894';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  Future<String> getLocationWeather() async {
    double long;
    double lat;
    Location location = Location();
    await location.getCurrentLocation();
    lat = location.latitude;
    long = location.longitude;
    NetworkHelper net = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$PersonalApiKey&units=metric');
    String dat = await net.getdata();
    return dat;
  }

  Future<String> getCityWeather(String w) async {
    NetworkHelper net = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?q=$w&appid=$PersonalApiKey&units=metric');
    String dat = await net.getdata();
    return dat;
  }
}
