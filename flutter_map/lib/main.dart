import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';

void main() => runApp(MyFirstFlutterMap());

class MyFirstFlutterMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyFlutterMap(),
    );
  }
}

class MyFlutterMap extends StatefulWidget {
  @override
  _MyFlutterMapState createState() => _MyFlutterMapState();
}

class _MyFlutterMapState extends State<MyFlutterMap> {

  List<Marker> markers;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("First Map"),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09),
          zoom: 13.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://api.tiles.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken':
                  'pk.eyJ1IjoiZ2FyaWFuaSIsImEiOiJjazAxbzFxdG4wMDY3M25sc2RsYWU5c2o0In0.a6EUXyZdDKbqFDgPgX20Uw',
              'id': 'mapbox.streets',
            },
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(51.5, -0.09),
                builder: (ctx) => Container(
                  child: IconButton(
                    icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                    color: Colors.red,
                    iconSize: 45.0,
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (builder) {
                            return Card(
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                onTap: () {
                                  print('teste toque');
                                },
                                child: Container(
                                  width: 300,
                                  height: 100,
                                  child: Text('A card than can tapped!'),
                                ),
                              ),
                            );
                          });
                    },
                  ),
                ),
              ),
            ],
          ),
          MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            height: 40,
            width: 40,
            fitBoundsOptions: FitBoundsOptions(
              padding: EdgeInsets.all(50),
            ),
            markers: markers,
            polygonOptions: PolygonOptions(
                borderColor: Colors.blueAccent,
                color: Colors.black12,
                borderStrokeWidth: 3),
            builder: (context, markers) {
              return FloatingActionButton(
                child: Text(markers.length.toString()),
                onPressed: null,
              );
            },
          ),
        ],
      ),
    );
  }
}

/*
const int _bluePrimary = 0xFF395afa;
const MaterialColor mapBoxBlue = const MaterialColor(
  _bluePrimary,
  const <int, Color>{
    50: const Color(0xFFE7EBFE),
    100: const Color(0xFFC4CEFE),
    200: const Color(0xFF9CADFD),
    300: const Color(0xFF748CFC),
    400: const Color(0xFF5773FB),
    500: const Color(_bluePrimary),
    600: const Color(0xFF3352F9),
    700: const Color(0xFF2C48F9),
    800: const Color(0xFF243FF8),
    900: const Color(0xFF172EF6),
  },
);
*/
