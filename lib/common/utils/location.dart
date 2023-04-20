import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:travelgrid/common/utils/show_alert.dart';
import 'package:tuple/tuple.dart';
class LocationUtils{

  Future<Tuple2<Position,String>> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    MetaAlert.showErrorAlert(message: "Please Enable Location!");
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
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.

  Position pos = await Geolocator.getCurrentPosition();

  return  GetAddressFromLatLong(pos) ;
}


    Future<Tuple2<Position,String>> GetAddressFromLatLong(Position position)async {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      print(placemarks);
      Placemark place = placemarks[0];
   //  String address = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
     String address = '${place.street}, ${place.subLocality}, ${place.locality},\n ${place.postalCode}';

      return Tuple2(position,address);
    }


}