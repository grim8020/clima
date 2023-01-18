import 'package:clima_new/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  LoadingScreenState createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  // double? latitude;
  // double? longitude;

  @override //only called once
  void initState() {
    super.initState();
    getLocationData();
  }

  void getLocationData() async {
    WeatherModel weatherModel = WeatherModel();
    var weatherData = await weatherModel.getLocationWeather();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LocationScreen(
            locationWeather: weatherData,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

// print(response.statusCode);

/* HTTP return codes cheat sheet:
    1**. Hold ons
    2**. Here you go
    3**. Go away
    4**. You screwed up
    5**. Server screwed up
     */

// print(response.body);

//print(data);

// var longitude = jsonDecode(data)['coord']['lon'];
// print(longitude);

// var weatherDescription = jsonDecode(data)['weather'][0]['description'];
// print(weatherDescription);

//keep as a var to make it dynamic

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
