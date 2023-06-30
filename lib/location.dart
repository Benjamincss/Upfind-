import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(location());
}

class location extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<location> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFFFBD73),
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var long = "longitude";
  var lat = "latitude";
  void getlocation() async {
    LocationPermission per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied ||
        per == LocationPermission.deniedForever) {
      print("permission denied");
      LocationPermission per1 = await Geolocator.requestPermission();
    } else {
      Position currentLoc = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        long = currentLoc.longitude.toString();
        lat = currentLoc.latitude.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF202020),
      appBar: AppBar(
        backgroundColor: Color(0xFFFFBD73),
        title: Row(
          children: [
            Text(
              "location user ",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              "test",
              style: TextStyle(
                color: Colors.yellow,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "logitude : " + long,
              style: TextStyle(
                color: Color(0xFFFFBD73),
                fontSize: 30,
              ),
            ),
            Text(
              "latitude : " + lat,
              style: TextStyle(
                color:Color(0xFFFFBD73),
                fontSize: 30,
              ),
            ),
            Image.asset("assets/discover.png")
            ,
            MaterialButton(
              onPressed: getlocation,
              color: Color(0xFFFFBD73),
              child: Text(
                "Get Location",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}