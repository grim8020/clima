import 'dart:convert';

import 'package:clima_new/services/location.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const apiKey = '3abd6414bfb20a1e4202d7119ee3be95';

class LoadingScreen extends StatefulWidget {
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  double? latitude;
  double? longitude;

  @override //only called once
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    latitude = location.latitude;
    longitude = location.longitude;

    getData();
  }

  void getData() async {
    http.Response response = await http.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey'),
    );
    // print(response.statusCode);

    /* HTTP return codes cheat sheet:
    1**. Hold ons
    2**. Here you go
    3**. Go away
    4**. You screwed up
    5**. Server screwed up
     */

    // print(response.body);
    if (response.statusCode == 200) {
      String data = response.body;
      //print(data);

      // var longitude = jsonDecode(data)['coord']['lon'];
      // print(longitude);

      // var weatherDescription = jsonDecode(data)['weather'][0]['description'];
      // print(weatherDescription);

      var decodedData = jsonDecode(data); //keep as a var to make it dynamic

      double temp = decodedData['main']['temp'];
      print(temp);
      int condition = decodedData['weather'][0]['id'];
      print(condition);
      String cityName = decodedData['name'];
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

// void getLocation() async {
//   LocationPermission permission;
//   permission = await Geolocator.checkPermission();
//   permission = await Geolocator.requestPermission();
//   if (permission == LocationPermission.denied) {
//     print('Denied');
//   } else {
//     Position position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.low);
//     print(position);
//   }
// }
