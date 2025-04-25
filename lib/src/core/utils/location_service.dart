import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sundaymart/src/core/constants/app_constants.dart';
import 'package:sundaymart/src/models/response/google_map_response_model.dart'
    as googleResponseModel;

import 'package:permission_handler/permission_handler.dart' as ph;

class LocationService {
  // Future<void> _checkPermission() async {
  //   if (await Permission.locationWhenInUse.isGranted) {
  //     _getCurrentLocation();
  //   } else {
  //     var status = await Permission.locationWhenInUse.request();
  //     if (status == PermissionStatus.granted) {
  //       _getCurrentLocation();
  //     } else {
  //       // Handle permission denied
  //     }
  //   }
  // }
/*
  Future<LocationData> getLocation() async {
    if (await ph.Permission.locationWhenInUse.isGranted) {
      return await getLocationHandel();
    } else {
      var status = await ph.Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        return await getLocationHandel();
      } else {
        // Handle permission denied
      }
      return await getLocationHandel();
    }
  }
*/
  Future<Position> _getCurrentLocation() async {
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<Position> checkPermission() async {
    if (await Permission.locationWhenInUse.isGranted) {
      return await _getCurrentLocation();
    } else {
      var status = await Permission.locationWhenInUse.request();
      if (status == PermissionStatus.granted) {
        return await _getCurrentLocation();
      } else {
        // Handle permission denied
     return await   _getCurrentLocation();
      }
    }
  }

  // Future<LocationData> getLocation() async {
  //   Location location = Location();

  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   LocationData _locationData;

  //   _serviceEnabled = await location.serviceEnabled();
  //   print("Service Enabled : $_serviceEnabled");
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       _serviceEnabled = await location.serviceEnabled();
  //       //  throw Exception();
  //       // return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted == PermissionStatus.deniedForever) {
  //       _permissionGranted = await location.requestPermission();
  //       throw Exception('deniedForever');
  //     } else if (_permissionGranted != PermissionStatus.granted) {
  //       _permissionGranted = await location.requestPermission();
  //       throw Exception('granted');
  //     }
  //   }

  //   _locationData = await location.getLocation();

  //   return _locationData;
  // }

  Future<Map<String, dynamic>> fetchPlaceDetails(String placeId) async {
    final apiKey =
        AppConstants.googleMapApiKey; // Replace with your Google Maps API key
    final apiUrl =
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$apiKey';

    final response = await Dio().get(apiUrl);

    if (response.statusCode == 200) {
      final data = response.data;
      return data['result'];
    } else {
      throw Exception('Failed to load place details');
    }
  }

  Future<Map<String, String>?> fetchAddress(
      double latitude, double longitude) async {
    final apiKey =
        AppConstants.googleMapApiKey; // Replace with your Google Maps API key
    final apiUrl =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&language=ar&key=$apiKey';

    try {
      final response = await Dio().get(apiUrl);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'OK') {
          var model = googleResponseModel.GoogleMapResposneModel.fromJson(
              response.data);

          if (model.results!.isNotEmpty) {
            // place_id
            return {
              "address": model.results![0].formattedAddress ?? "",
              "placeId": model.results![0].placeId ?? "",
            };
          }
        }
      }
    } catch (e, s) {
      debugPrint(e.toString());
      throw "Erro";
    }

    // Return null if there's an error or if no results were found
    return null;
  }
}
