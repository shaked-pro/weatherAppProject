import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  double latitude;
  double longitude;
  String c; //stands for the city

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }

  // Future<void> getCity() async
  //{
  //try {
  //Position position = await Geolocator().getCurrentPosition(
  //  desiredAccuracy: LocationAccuracy.bestForNavigation);
  //    c=position.
  //  } catch (e) {
  //  print(e);
  //}
  //}
}
