import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:simple_attendances/app/get_it_registry.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:simple_attendances/core/stores/user/user_store.dart';
import 'package:simple_attendances/views/helpers/dialog_helper.dart';

class GeoService {
  final UserStore userStore = getIt<UserStore>();
  final DialogHelper _dialogHelper = getIt<DialogHelper>();

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future determinePosition(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      final _result = await _dialogHelper.confirmationDialog(
        context,
        title: 'Location Services Disabled',
        message: 'Please enable location services to continue.',
      );

      if (_result) {
        // Open the location settings.
        Geolocator.openLocationSettings();
      }
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // TODO: Permissions are denied forever, handle appropriately.
      final _result = await _dialogHelper.confirmationDialog(
        context,
        title: 'Location Permissions Denied Forever',
        message: 'Please enable location permissions to continue.',
      );

      if (_result) {
        // Open the location settings.
        Geolocator.openLocationSettings();
      }
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await getCurrentPosition();
  }

  /// Determine the current position of the device.
  Future<Position> getCurrentPosition() async {
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  /// Determine the last known position of the device.
  Future<Position?> getLastKnownPosition() async {
    return await Geolocator.getLastKnownPosition();
  }

  /// Listen to location updates
  Stream<Position> positionStream() =>
      Geolocator.getPositionStream(locationSettings: const LocationSettings(accuracy: LocationAccuracy.bestForNavigation));

  /// Check if the device has location services enabled.
  Future<bool> isLocationServiceEnabled() async => await Geolocator.isLocationServiceEnabled();

  /// Check distance between two positions.
  double distanceBetween(LatLng position1, LatLng position2) {
    return Geolocator.distanceBetween(position1.latitude, position1.longitude, position2.latitude, position2.longitude);
  }

  /// Check if the device has location permissions.
  Future<LocationPermission> checkPermission() async => await Geolocator.checkPermission();

  /// Request location permissions.
  Future<LocationPermission> requestPermission() async => await Geolocator.requestPermission();

  /// Get location from address.
  Future<List<Location>> getLocationFromAddress({required String address}) async {
    try {
      return await locationFromAddress(address, localeIdentifier: userStore.getUserLocale());
    } catch (e) {
      _dialogHelper.snackBar(message: e.toString());
      return Future.error(e.toString());
    }
  }

  /// Get address from location.
  Future<List<Placemark>> getPlacemarkFromCoordinates(LatLng position) async {
    try {
      return await placemarkFromCoordinates(position.latitude, position.longitude, localeIdentifier: userStore.getUserLocale());
    } catch (e) {
      _dialogHelper.snackBar(message: e.toString());
      return Future.error(e.toString());
    }
  }
}
