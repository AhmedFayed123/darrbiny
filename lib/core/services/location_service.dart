// // services/location_service.dart
// import 'package:location/location.dart';
//
// class LocationService {
//   final Location _location = Location();
//
//   Future<LocationData> getCurrentLocation() async {
//     bool serviceEnabled = await _location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _location.requestService();
//       if (!serviceEnabled) {
//         throw Exception("Location service is not enabled");
//       }
//     }
//
//     PermissionStatus permissionGranted = await _location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         throw Exception("Location permission denied");
//       }
//     }
//
//     return await _location.getLocation();
//   }
// }
