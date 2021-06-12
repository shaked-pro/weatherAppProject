import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'dart:convert';
import 'package:clima/services/weather.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weather});
  final weather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String city;
  int condition;
  int temp;
  WeatherModel we = WeatherModel();
  String oof;
  String icon;

  @override
  void initState() {
    super.initState();
    print(widget.weather);
    updateUI(widget.weather);
  }

  void updateUI(String weatherdata) {
    setState(() {
      if (weatherdata == null) {
        temp = 0;
        city = '';
        oof = 'unable to reach the location';
        icon = 'Error';
        return;
      }
      double t = jsonDecode(weatherdata)['main']['temp'];
      temp = t.round();
      condition = jsonDecode(weatherdata)['weather'][0]['id'];
      city = jsonDecode(weatherdata)['name'];
      oof = we.getMessage(temp);
      icon = we.getWeatherIcon(condition);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      WeatherModel weather2 = WeatherModel();
                      String dat = await weather2.getLocationWeather();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LocationScreen(
                          weather: dat,
                        );
                      }));
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var name = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }),
                      );
                      if (name != null) {
                        city = name;
                        WeatherModel weather2 = WeatherModel();
                        String dat = await weather2.getCityWeather(city);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return LocationScreen(
                            weather: dat,
                          );
                        }));
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$icon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$oof in $city',
                  //"It's 🍦 time in San Francisco!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
