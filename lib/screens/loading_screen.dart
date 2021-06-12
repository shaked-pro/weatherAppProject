import 'package:flutter/material.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:clima/services/weather.dart';

const PersonalApiKey = '065658292da33aa352ae089f58ffa894';

WeatherModel weather1 = WeatherModel();

class LoadingScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoadingScreenState();
  }
}

class _LoadingScreenState extends State<LoadingScreen> {
  double long;
  double lat;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    String dat = await weather1.getLocationWeather();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(
        weather: dat,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SpinKitWave(color: Colors.white, size: 100.0),
    ));
  }
}
