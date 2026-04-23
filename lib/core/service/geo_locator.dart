import 'package:geolocator/geolocator.dart';

final class GeolocatorService {
  const GeolocatorService._();
  static final GeolocatorService instance = const GeolocatorService._();
  /// Check if the location permission is granted
  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
  /// Check if the location service is enabled
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }
  /// Get the current location
  Future<Position?> getCurrentLocation() async {
    try {
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        return null;
      }

      bool hasPermission = await checkPermission();
      if (!hasPermission) {
        return null;
      }
      Position position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }
  /// Get the current location stream
  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    );
  }
  /// Get the distance between two points
  Future<double> getDistanceBetween(
      double startLat,
      double startLng,
      double endLat,
      double endLng,
      ) async {
    return Geolocator.distanceBetween(startLat, startLng, endLat, endLng);
  }
  Future<void> openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }
  /// Open app settings
  Future<void> openAppSettings() async {
    await Geolocator.openAppSettings();
  }
}