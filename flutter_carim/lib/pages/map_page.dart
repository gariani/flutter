import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {
  List<Marker> markers;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(      
      alignment: Alignment.center,
      margin: EdgeInsets.all(1.0),
      padding: EdgeInsets.all(1.0),
      child: FlutterMap(
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
                  'pk.eyJ1IjoiZ2FyaWFuaSIsImEiOiJjazFmaGp4dm0wa2NnM2JuejRhdnhka3Y3In0.L9Cc7q7gg2qWexHWBovEeQ',
              'id': 'mapbox.streets',
            },
          ),
          MarkerLayerOptions(
            markers: [
              _createMarker(),
            ],
          ),
        ],
      ),
    );
  }

  Marker _createMarker() {
    return Marker(
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
    );
  }

  @override
  bool get wantKeepAlive => true;
}
