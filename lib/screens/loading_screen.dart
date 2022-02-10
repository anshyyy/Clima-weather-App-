import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'package:clima/utilities/constants.dart';
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
    getLocation();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=${latitude.toString()}&lon=${longitude.toString()}&appid=${token.toString()}'));
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);
      var id = jsonDecode(data)['weather'][0]['id'];
      var temperatue = jsonDecode(data)['main']['temp'];
      var cityname = jsonDecode(data)['name'];
      print(cityname);
      print(id);
      print(temperatue);
    } else {
      print(response.statusCode);
    }
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
            onPressed: () {
              print(latitude);
              print(longitude);
              getData();
            },
            child: Text('Get Location')),
      ),
    );
  }
}
