import 'dart:async';
import 'dart:convert';
import 'package:car_rental_app/screens/navigationbar_screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart'; // For fetching the current location
import 'package:http/http.dart' as http;

import '../widgets/car_card_maps_screen.dart'; // For making HTTP requests

class MapScreen extends StatefulWidget {
  final CarCardMapsScreen carCardMapsScreen;

  const MapScreen({super.key, required this.carCardMapsScreen});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  LatLng? _pickupLocation;
  LatLng? _dropoffLocation;
  String _travelTime = '';

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.4686, 39.6118), // Coordinates for Madinah, Saudi Arabia
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final position = await Geolocator.getCurrentPosition();

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.4746,
      ),
    ));
  }

  void _onMapTap(LatLng position) async {
    if (_pickupLocation == null) {
      setState(() {
        _pickupLocation = position;
        _addMarker(position, 'Pickup Location',
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
      });
    } else if (_dropoffLocation == null) {
      setState(() {
        _dropoffLocation = position;
        _addMarker(position, 'Dropoff Location',
            BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed));
      });

      if (_pickupLocation != null && _dropoffLocation != null) {
        await _calculateAndDrawRoute(_pickupLocation!, _dropoffLocation!);
      }
    } else {
      // If both pickup and drop-off locations are already set, clear the markers and start over
      setState(() {
        _markers.clear();
        _polylines.clear();
        _pickupLocation = null;
        _dropoffLocation = null;
        _travelTime = '';
        _onMapTap(position);
      });
    }
  }

  Future<void> _calculateAndDrawRoute(LatLng start, LatLng end) async {
    final directionsUrl = 'https://maps.googleapis.com/maps/api/directions/json'
        '?origin=${start.latitude},${start.longitude}'
        '&destination=${end.latitude},${end.longitude}'
        '&key=AIzaSyDgrDZj68xOqegZU8ZgjkT1Lxg9bOQgzng';

    try {
      final response = await http.get(Uri.parse(directionsUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Print response for debugging
        print('API Response: ${jsonEncode(data)}');

        final routes = data['routes'];

        if (routes.isEmpty) {
          throw Exception('No routes found in the API response');
        }

        final route = routes[0];
        final legs = route['legs'];

        if (legs.isEmpty) {
          throw Exception('No legs found in the route');
        }

        final leg = legs[0];
        final duration = leg['duration']['text'];

        setState(() {
          _travelTime = duration;
        });

        final polylinePoints = route['overview_polyline']['points'];
        final decodedPolyline = _decodePolyline(polylinePoints);

        final polyline = Polyline(
          polylineId: const PolylineId('route'),
          points: decodedPolyline,
          color: Colors.orange,
          width: 5,
        );

        setState(() {
          _polylines.add(polyline);
        });
      } else {
        throw Exception('Failed to load directions');
      }
    } catch (e) {
      print('Error: $e');
      // Optionally, you can show an error message to the user
      setState(() {
        _travelTime = 'Error fetching route';
      });
    }
  }

  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0;
    int len = polyline.length;
    int latitude = 0;
    int longitude = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      latitude += dlat;

      shift = 0;
      result = 0;

      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlon = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      longitude += dlon;

      final lat = (latitude / 1E5).toDouble();
      final lng = (longitude / 1E5).toDouble();
      points.add(LatLng(lat, lng));
    }

    return points;
  }

  void _addMarker(LatLng position, String title, BitmapDescriptor icon) {
    final marker = Marker(
      markerId: MarkerId(title),
      position: position,
      infoWindow: InfoWindow(
          title: title,
          snippet:
              _travelTime.isNotEmpty ? 'Estimated Time: $_travelTime' : ''),
      icon: icon,
    );

    setState(() {
      _markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapType: MapType.terrain,
              initialCameraPosition: _kGooglePlex,
              zoomControlsEnabled: false,
              markers: _markers,
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: _onMapTap, // Handle map taps
            ),
            Positioned(
              top: 30,
              left: 30,
              right: 30,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22.0),
                          color: Colors.white70,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileScreen(),
                            ),
                          );
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(22.0),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            'assets/images/me.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22.0),
                      color: Colors.white70,
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.gps_fixed_rounded,
                        size: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              left: 30,
              right: 30,
              child: CarCardMapsScreen(
                carTitle: widget.carCardMapsScreen.carTitle,
                dailyRent: widget.carCardMapsScreen.dailyRent,
                hourlyRent: widget.carCardMapsScreen.hourlyRent,
                carImage: widget.carCardMapsScreen.carImage,
                carBrand: widget.carCardMapsScreen.carBrand,
                isDailySelected: widget.carCardMapsScreen.isDailySelected,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
