import 'package:boy/Widgets/Colors.dart';
import 'package:boy/read.dart/getcommande.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:latlong2/latlong.dart';
import 'package:location/location.dart' as loc;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math' as math;



const MAPBOX_ACCESS_TOKEN =
    'sk.eyJ1IjoiaG91c3NlbXphcnJvdWsiLCJhIjoiY2x2YXdnMTNhMDJsbjJsbGk0NWg1Z2E4OSJ9.FyvwrEH-G3FJ2zUZeagxsQ';

class MapScreen extends StatefulWidget {
  final CollectionReference<Object?> commandes;
  final String? specificOrderLocation;
  final bool fromHomepage;
  final bool showPolyline;
  final String? source;

  const MapScreen({
    Key? key,
    required this.commandes,
    this.specificOrderLocation,
    required this.fromHomepage,
    required this.showPolyline,
     this.source,
  }) : super(key: key);

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
  List<Marker> _orderMarkers = [];

  @override
  void initState() {
    super.initState();
    if (widget.showPolyline) {
      _getCurrentLocation().then((_) {
        if (widget.specificOrderLocation != null) {
          _fetchGeopointFromAddress(widget.specificOrderLocation!).then((_) {
            if (_orderLocations.isNotEmpty) {
              _updateMapForSelectedOrder();
            }
          });
        } else {
          _fetchCommandDocumentIDs().then((_) {
            if (_docIDs.isNotEmpty) {
              _updateMapForSelectedOrder();
            }
          });
        }
      });
    } else {
      if (widget.specificOrderLocation != null) {
        _fetchGeopointFromAddress(widget.specificOrderLocation!).then((_) {
          if (_orderLocations.isNotEmpty) {
            _updateMapForSelectedOrder();
          }
        });
      } else {
        _fetchCommandDocumentIDs().then((_) {
          if (_docIDs.isNotEmpty) {
            _updateMapForSelectedOrder();
          }
        });
      }
    }
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
      _currentLocation = LatLng(
        _locationData.latitude!,
        _locationData.longitude!,
      );
    });
  }

  Future<void> _fetchCommandDocumentIDs() async {
    QuerySnapshot querySnapshot = await widget.commandes.get();
    List<String> filteredDocIDs = [];
    String userId = FirebaseAuth.instance.currentUser!.uid;

    for (QueryDocumentSnapshot doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      if (data['status'] == 'pending' &&
          !(data['refusedBy'] ?? []).contains(userId) &&
          (data['acceptedByUserId'] == null || data['acceptedByUserId'].isEmpty)) {
        filteredDocIDs.add(doc.id);
        await _fetchGeopointFromAddress(data['Localisation']); // Fetch location for the order
      }
    }

    setState(() {
      _docIDs = filteredDocIDs;
    });

    print('Document IDs: $_docIDs');
  }

  Future<void> _fetchGeopointFromAddress(String address) async {
    String encodedAddress = Uri.encodeQueryComponent(address);
    String url = 'https://api.geoapify.com/v1/geocode/search?text=$encodedAddress&apiKey=925e5ea8729948e5b131f89347ccf228';

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> result = json.decode(response.body);

      if (result.containsKey('features') && result['features'].isNotEmpty) {
        Map<String, dynamic> firstFeature = result['features'][0];
        double latitude = firstFeature['properties']['lat'];
        double longitude = firstFeature['properties']['lon'];
        String place = firstFeature['properties']['name'] ?? address;
        String street = firstFeature['properties']['street'] ?? 'Unknown';
        String city = firstFeature['properties']['city'] ?? 'Unknown';
        String country = firstFeature['properties']['country'] ?? 'Unknown';
        String postalCode = firstFeature['properties']['postal_code'] ?? 'Unknown';

        print('Geopoint for $address: Latitude: $latitude, Longitude: $longitude');
        print('Place: $place, Street: $street, City: $city');
        print('Country: $country, Postal Code: $postalCode');

        setState(() {
          _orderLocations.add(LatLng(latitude, longitude));
        });

        _updateOrderMarkers();
      } else {
        print('No results found for the address: $address');
      }
    } else {
      print('Error fetching geopoint: ${response.reasonPhrase}');
    }
  }

  void _updateOrderMarkers() {
    _orderMarkers.clear();
    for (var location in _orderLocations) {
      _orderMarkers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: location,
          child: Image.asset(
            "images/geolocalisation.png",
          ),
        ),
      );
    }
  }

  Future<double?> _fetchDistance(LatLng source, LatLng target) async {
    var myHeaders = {
      "Content-Type": "application/json"
    };

    var body = json.encode({
      "mode": "drive",
      "sources": [
        {"location": [source.longitude, source.latitude]}
      ],
      "targets": [
        {"location": [target.longitude, target.latitude]}
      ]
    });

    var response = await http.post(
      Uri.parse("https://api.geoapify.com/v1/routematrix?apiKey=c1dc7de35696400284d7aff8a144063f"),
      headers: myHeaders,
      body: body,
    );

    if (response.statusCode == 200) {
      var result = json.decode(response.body);
      if (result['sources_to_targets'] != null &&
          result['sources_to_targets'][0] != null &&
          result['sources_to_targets'][0][0] != null) {
        double distance = result['sources_to_targets'][0][0]['distance'] / 1000.0; 
        return distance;
      }
    } else {
      print('Error fetching distance: ${response.reasonPhrase}');
    }

    return null;
  }

  Future<void> _updateMapForSelectedOrder() async {
    if (widget.showPolyline && _currentLocation != null && _orderLocations.isNotEmpty) {
      // Clear previous markers and polyline
      _orderMarkers.clear();
      _orderPolyline = null;

      LatLng orderLocation = _orderLocations[_currentOrderIndex];

      _orderMarkers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: orderLocation,
          child: Image.asset(
            "images/geolocalisation.png",
          ),
        ),
      );

      List<LatLng> polylinePoints = [_currentLocation!, orderLocation];
      setState(() {
        _orderPolyline = Polyline(
          points: polylinePoints,
          strokeWidth: 2.0,
          color: GlobalColors.mainColorbg,
        );
      });

      double? distance = await _fetchDistance(_currentLocation!, orderLocation);

      if (distance != null) {
        // Debug print to see the calculated distance
        print('Calculated distance: $distance km');

        // Update the 'Km' field in Firestore
        String docID = _docIDs.isNotEmpty ? _docIDs[_currentOrderIndex] : '';
        if (docID.isNotEmpty) {
          await widget.commandes.doc(docID).update({'Km': distance.toStringAsFixed(2)});
        }
      }

      double minLat = math.min(_currentLocation!.latitude, orderLocation.latitude);
      double maxLat = math.max(_currentLocation!.latitude, orderLocation.latitude);
      double minLng = math.min(_currentLocation!.longitude, orderLocation.longitude);
      double maxLng = math.max(_currentLocation!.longitude, orderLocation.longitude);

      LatLngBounds bounds = LatLngBounds(
        LatLng(minLat, minLng),
        LatLng(maxLat, maxLng),
      );

      _mapController.fitBounds(
        bounds,
        options: FitBoundsOptions(padding: EdgeInsets.all(50.0)),
      );
    } else if (_orderLocations.isNotEmpty) {
      // Clear previous markers and polyline
      _orderMarkers.clear();
      _orderPolyline = null;

      LatLng orderLocation = _orderLocations[_currentOrderIndex];

      _orderMarkers.add(
        Marker(
          width: 80.0,
          height: 80.0,
          point: orderLocation,
          child: Image.asset(
            "images/geolocalisation.png",
          ),
        ),
      );

      setState(() {
        _orderPolyline = null; // No polyline to draw
      });

      double minLat = orderLocation.latitude;
      double maxLat = orderLocation.latitude;
      double minLng = orderLocation.longitude;
      double maxLng = orderLocation.longitude;

      LatLngBounds bounds = LatLngBounds(
        LatLng(minLat, minLng),
        LatLng(maxLat, maxLng),
      );

      _mapController.fitBounds(
        bounds,
        options: FitBoundsOptions(padding: EdgeInsets.all(50.0)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        
      
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
             //  center: _orderLocations.isNotEmpty ? _orderLocations[_currentOrderIndex] : LatLng(0, 0),
              center: _currentLocation, 
              minZoom: 5,
              maxZoom: 25,
              zoom: 20,
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
              if (widget.showPolyline && _orderPolyline != null)
                PolylineLayer(
                  polylines: [_orderPolyline!],
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
                              color: GlobalColors.mainColor,
                              size: 30,
                            ),
                          ),
              
                  ..._orderMarkers,
                      ],
                    ),
                  ],
                ),
          
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                child: _docIDs.isNotEmpty
                    ? PageView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: _docIDs.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentOrderIndex = index;
                            _updateMapForSelectedOrder();
                          });
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: GetCommande(
                              documentId: _docIDs[index],
                              fromHomepage: false,
                            ),
                          );
                        },
                      )
                    : SizedBox()
                    //Center(child: Text("No pending orders available")),
              ),
            ),
             if (widget.source == 'HomeScreen' || widget.source == 'PendingScreen')
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant MapScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateMapForSelectedOrder();
  }
}

 
