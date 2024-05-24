import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class CheckLocationPermission {
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
