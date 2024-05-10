




import 'package:boy/model/commande_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:boy/read.dart/getcommande.dart';
import 'package:latlong2/latlong.dart' as latlng;

const MAPBOX_ACCESS_TOKEN =
    'sk.eyJ1IjoiaG91c3NlbXphcnJvdWsiLCJhIjoiY2x2YXdnMTNhMDJsbjJsbGk0NWg1Z2E4OSJ9.FyvwrEH-G3FJ2zUZeagxsQ';

class MapScreen extends StatefulWidget {
  final CollectionReference commandes;

  const MapScreen({Key? key, required this.commandes}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  List<String> _docIDs = [];
  int _currentOrderIndex = 0;
  
  Polyline? _orderPolyline;
  List<LatLng> _orderLocations = [];
  
@override
void initState() {
  super.initState();
  _getCurrentLocation().then((_) {
    print("_currentLocation: $_currentLocation"); 
    _fetchCommandDocumentIDs();
  });
}


Future<void> _getCurrentLocation() async {
  loc.Location location = loc.Location();
  bool _serviceEnabled;
  loc.PermissionStatus _permissionGranted;
  loc.LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == loc.PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != loc.PermissionStatus.granted) {
      return;
    }
  }

  _locationData = await location.getLocation();
  setState(() {
    _currentLocation = LatLng(_locationData.latitude!, _locationData.longitude!);
  });
}


  Future<void> _createOrderPolyline() async {
    if (_currentLocation!= null && _orderLocations.isNotEmpty) {
      List<LatLng> polylinePoints = [_currentLocation!,..._orderLocations];
      setState(() {
        _orderPolyline = Polyline(
          points: polylinePoints,
          strokeWidth: 2.0,
          color: Colors.red,
        );
      });
    }
  }

Future<void> _fetchCommandDocumentIDs() async {
  QuerySnapshot querySnapshot = await widget.commandes.get();
  List<String> filteredDocIDs = [];
  Map<String, String> locationMap = {}; 

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String orderStatus = data['status'];
    if (orderStatus == 'pending') {
      filteredDocIDs.add(doc.id);
      // Store the location data instead of document IDs
      locationMap[doc.id] = data['Localisation'];
    }
  }

  setState(() {
    _docIDs = filteredDocIDs;
    _orderLocations.clear(); 
    _docIDs.forEach((docID) {
      if (locationMap.containsKey(docID)) {
        _getCoordinates(locationMap[docID]!);
      }
    });
  });
}




Future<void> _getCoordinates(String locationName) async {
  final apiKey = '925e5ea8729948e5b131f89347ccf228'; 
  final url = 'https://api.geoapify.com/v1/geocode/search?text=$locationName&apiKey=$apiKey';
  
  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final features = data['features'] as List<dynamic>;
      if (features.isNotEmpty) {
        final firstFeature = features[0];
        final coordinates = firstFeature['geometry']['coordinates'] as List<dynamic>;
        final longitude = coordinates[0] as double;
        final latitude = coordinates[1] as double;
        print('Longitude: $longitude, Latitude: $latitude');
        // You can now use longitude and latitude as needed
        // For example, you can add them to a list of LatLng
        setState(() {
          _orderLocations.add(LatLng(latitude, longitude));
          _createOrderPolyline(); // Update the polyline after fetching coordinates
        });
      } else {
        print('No features found in the response');
      }
    } else {
      print('Failed to fetch data from Geoapify API: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data from Geoapify API: $e');
  }
}


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          _currentLocation == null
              ? Center(child: CircularProgressIndicator())
              : FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: _currentLocation,
                    minZoom: 5,
                    maxZoom: 25,
                    zoom: 15,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                      additionalOptions: {
                        'accessToken': MAPBOX_ACCESS_TOKEN,
                        'id': 'mapbox/outdoors-v11',
                      },
                    ),
                    PolylineLayer(
                      polylines: _orderPolyline!= null
                         ? [_orderPolyline!]
                          : [],
                    ),
                    MarkerLayer(
                      markers: [
                        if (_currentLocation != null)
                          Marker(
                            width: 80.0,
                            height: 80.0,
                            point: _currentLocation!,
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        
                      ],
                    ),
                    PolylineLayer(
                      polylines: _orderPolyline != null
                          ? [_orderPolyline!]
                          : [],
                    ),
                  ],
                ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _docIDs.length,
                itemBuilder: (context, index) {
                  return 
                   FutureBuilder<DocumentSnapshot>(
                    future: widget.commandes.doc(_docIDs[index]).get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        Map<String, dynamic> data =
                            snapshot.data!.data() as Map<String, dynamic>;
                        if (data['status'] == 'pending') {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _currentOrderIndex = index;
                              });
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: GetCommande(
                                  documentId: _docIDs[index],
                                  fromHomepage: false),
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      }
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

 


 /* Future<LatLng?> _getCoordinates(String locationName) async {
  final apiKey = '925e5ea8729948e5b131f89347ccf228'; 
  final url = 'https://api.geoapify.com/v1/geocode/search?text=$locationName&apiKey=$apiKey';
  
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final features = data['features'] as List<dynamic>;
    if (features.isNotEmpty) {
      final firstFeature = features[0];
      final geometry = firstFeature['properties']['latlon'];
      final coordinates = geometry.split(',').map((coord) => double.parse(coord)).toList();
      return LatLng(coordinates[0], coordinates[1]);
    }
  }
  return null;
}




Future<void> _fetchCommandDocumentIDs() async {
  QuerySnapshot querySnapshot = await widget.commandes.get();
  List<String> filteredDocIDs = [];
  Map<String, LatLng> coordinatesMap = {}; 

  for (QueryDocumentSnapshot doc in querySnapshot.docs) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    String orderStatus = data['status'];
    if (orderStatus == 'pending') {
      filteredDocIDs.add(doc.id);
    
      LatLng? coordinates = await _getCoordinates(data['Localisation']);
      if (coordinates != null) {
        coordinatesMap[doc.id] = coordinates; 
      }
    }
  }

  setState(() {
    _docIDs = filteredDocIDs;
    _orderLocations.clear(); 
    _docIDs.forEach((docID) {
      if (coordinatesMap.containsKey(docID)) {
        _orderLocations.add(coordinatesMap[docID]!);
      }
    });
    _createOrderPolyline(); 
  });

  print(' document IDs: $_docIDs');
  print(' coordinatesMap: $coordinatesMap');
}
*/

  

/*Future<void> _getCoordinates(String locationName) async {
  final apiKey = '925e5ea8729948e5b131f89347ccf228'; 
  final url = 'https://api.geoapify.com/v1/geocode/search?text=$locationName&apiKey=$apiKey';
  
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    final features = data['features'] as List<dynamic>;
    if (features.isNotEmpty) {
      final firstFeature = features[0];
      final geometry = firstFeature['properties']['latlon'];
      final coordinates = geometry.split(',').map((coord) => double.parse(coord)).toList();
      setState(() {
        _orderLocations.add(LatLng(coordinates[0], coordinates[1]));
        _createOrderPolyline(); // Update the polyline after fetching coordinates
      });
    }
  }
}*/



