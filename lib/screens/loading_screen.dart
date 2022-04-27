import 'location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
    NetworkHelper nethelp = NetworkHelper(
        'http://api.openweathermap.org/data/2.5/weather?lat=${latitude.toString()}&lon=${longitude.toString()}&appid=${token.toString()}');
    var weatherData = await nethelp.getData();
    int id = jsonDecode(weatherData)['weather'][0]['id'];
    double temperatue = jsonDecode(weatherData)['main']['temp'];
    String cityname = jsonDecode(weatherData)['name'];
    print(id);
    print(temperatue);
    print(cityname);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen();
    }));
    print("$latitude,$longitude");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
