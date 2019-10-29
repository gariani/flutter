import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {

  final Widget teste;

  MapPage({this.teste});

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> with AutomaticKeepAliveClientMixin {

  List<Marker> markers;
  var locate = Location();
  double lt, lg;
  int pointIndex;
  List points = [
    LatLng(51.5, -0.09),
    LatLng(49.8566, 3.3522),
  ];

  MapController mapController = MapController();

  @override
  void initState() {
    pointIndex = 0;
    super.initState();
    markers = getMarkerList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
//      floatingActionButtonButtonLocation: FloatingActionButtonLocation.endTop,
//      floatingActionButton: FloatingActionButton(
//        heroTag: "map_page",
//        child: Icon(Icons.refresh),
//        onPressed: () {
//          pointIndex++;
//          if (pointIndex >= points.length) {
//            pointIndex = 0;
//          }
//          setState(() {
//            markers[0] = Marker(
//              point: points[pointIndex],
//              anchorPos: AnchorPos.align(AnchorAlign.center),
//              height: 30,
//              width: 30,
//              builder: (ctx) => Icon(Icons.pin_drop),
//            );
//            markers = getMarkerList();
//          });
//        },
//      ),
      body: FlutterMap(
        //mapController: mapController,
//              mapController: mapController,
        options: MapOptions(
          plugins: [MarkerClusterPlugin()],
          center: LatLng(-27.597426, -48.572474),
          zoom: 14.0,
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
          MarkerClusterLayerOptions(
            maxClusterRadius: 120,
            size: Size(40, 40),
            anchor: AnchorPos.align(AnchorAlign.center),
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
                heroTag: "map_page_layer",
                child: Text(markers.length.toString()),
                onPressed: null,
              );
            },
          ),
        ],
      ),
    );
  }

  List<Marker> getMarkerList(){
    final List<LatLng> latLg = List<LatLng>();

    latLg.add(LatLng(-27.588084, -48.601062));
    latLg.add(LatLng(-27.593866, -48.588727));
    latLg.add(LatLng(-27.593531, -48.556825));
    latLg.add(LatLng(-27.594383, -48.551162));
    latLg.add(LatLng(-27.597448, -48.553254));

    List<Marker> markers = latLg.map((l) => _createMarker(lt: l.latitude, lg: l.longitude, color: Colors.red)).toList();
    return markers;
  }

  Marker _createMarker({double lt, double lg, Color color}) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(lt, lg),
      builder: (ctx) => Container(
        child: IconButton(
          icon: Icon(FontAwesomeIcons.mapMarkerAlt),
          color: color,
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
