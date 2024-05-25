import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// A class to handle location permission and retrieve current position.
class CheckLocationPermission {
  /// Handles location permission requests.
  ///
  /// Returns `true` if location permission is granted, `false` otherwise.
  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      openAppSettings();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }

  /// Retrieves the current position if location permission is granted.
  ///
  /// Returns the current [Position], or `null` if permission is not granted or an error occurs.
  Future<Position?> getCurrentPosition() async {
    try {
      final hasPermission = await handleLocationPermission();
      if (!hasPermission) return null;
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      return null;
    }
  }

  /// Retrieves address from latitude and longitude.
  ///
  /// [position]: The [Position] object containing latitude and longitude.
  ///
  /// Returns a [Placemark] representing the address information for the given coordinates,
  /// or `null` if an error occurs.
  Future<Placemark?> getAddressFromLatLng(Position position) async {
    try {
      final placeMarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final place = placeMarks[0];
      return place;
    } catch (e) {
      return null;
    }
  }
}
