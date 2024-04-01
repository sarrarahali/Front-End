/*import 'package:flutter/material.dart';


class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Example'),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(51.5, -0.09), // Initial map center coordinates
          zoom: 13.0, // Initial zoom level
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'], // Subdomains for the tile provider
          ),
          // Add more layers if needed, e.g., MarkerLayerOptions, PolylineLayerOptions, etc.
        ],
      ),
    );
  }
}

class MapUI extends StatefulWidget {
  const MapUI({Key? key}) : super(key: key);

  @override
  _MapUIState createState() => _MapUIState();
}

class _MapUIState extends State<MapUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map UI')),
      body: MapScreen(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MapUI(),
  ));
}
*/