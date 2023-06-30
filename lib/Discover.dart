
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latLng;
class Discover extends StatefulWidget {
  const Discover({Key? key}) : super(key: key);

  @override
  _DiscoverState createState() => _DiscoverState();
}

class _DiscoverState extends State<Discover> {
  @override
  Widget build(BuildContext context) {
    return
      FlutterMap(
      options: MapOptions(
        center: latLng.LatLng(49.1813403, -0.3635615),
        zoom: 8.0,
        interactiveFlags: InteractiveFlag.pinchZoom | InteractiveFlag.drag,
      ),
      layers: [
        TileLayerOptions(
            urlTemplate:
            "https://api.mapbox.com/styles/v1/skyrayzs/ckyma0v6rez8v16n23rpss3vl/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoic2t5cmF5enMiLCJhIjoiY2t5bTlidHNuM2R6MzJwbzhrdm5tdmVwYiJ9.9ysur8_QsNf3dvIckGDSFw",
            additionalOptions: {
              'accessToken':
              'pk.eyJ1Ijoic2t5cmF5enMiLCJhIjoiY2t5bTlidHNuM2R6MzJwbzhrdm5tdmVwYiJ9.9ysur8_QsNf3dvIckGDSFw',
              'id': 'mapbox.satellite'
            }),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 59.0,
              height: 59.0,
              point: latLng.LatLng(49.1813403, -0.3635615),
              builder: (ctx) => Container(
                  child: IconButton(
                    icon: Image.asset('assets/fetes.png', height: 400 , width: 400,),
                    iconSize: 400,

                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (builder) {
                          return SingleChildScrollView(
                            child: new Center(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            SingleChildScrollView()
                              ,new Text(
                            'Soiree de',
                            style: TextStyle(
                              fontFamily: 'PaybAck',
                              fontSize: 35,
                              color: Color(0xFFFFBD73),
                            ),
                          )




                          ,

                            new Text(
                              'theme',
                              style: TextStyle(
                                fontFamily: 'PaybAck',
                                fontSize: 35,
                                color: Color(0xFFFFBD73),
                              ),
                            )
                            ,new Text(
                              'date',
                              style: TextStyle(
                                fontFamily: 'PaybAck',
                                fontSize: 35,
                                color: Color(0xFFFFBD73),
                              ),
                            )
                            ,new Text(
                              'Filtres',
                              style: TextStyle(
                                fontFamily: 'PaybAck',
                                fontSize: 35,
                                color: Color(0xFFFFBD73),
                              ),
                            )
                          ]
                          ),


                          )
                          );
                        },
                      );

                    },

                  )

              ),

            ),

          ],
        ),
      ],
    );










    
  }
}
