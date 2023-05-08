part of '../import_url_file.dart';

final _verificationCode = StateProvider<String>((ref) => "");

final currentTime = StateProvider<String>(
  (ref) => DateFormat("HH:mm").format(DateTime.now()),
);

/*final retrieveCurrentLocation = StreamProvider((ref) {
  LocationSettings? initLocation = const LocationSettings(
    accuracy: LocationAccuracy.best,
    distanceFilter: 20,
    timeLimit: Duration(seconds: 30),
  );

  return Geolocator.getPositionStream(locationSettings: initLocation).map(
    (position) =>
        {"longitude": position.longitude, "latitude": position.latitude},
  );
});*/

////////////////////////
///ITEM MENU PROVIDER///
////////////////////////

final itemMenu = StateProvider<Map<String, dynamic>>((ref) => {});
