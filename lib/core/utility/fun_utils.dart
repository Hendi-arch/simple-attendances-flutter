import 'package:geocoding/geocoding.dart';

String concanatePlacemark(Placemark placemark) {
  final String? address = placemark.subThoroughfare != null ? '${placemark.subThoroughfare} ${placemark.thoroughfare}' : placemark.thoroughfare;

  final String? city = placemark.subLocality != null ? '${placemark.subLocality} ${placemark.locality}' : placemark.locality;

  final String? state =
      placemark.administrativeArea != null ? '${placemark.administrativeArea} ${placemark.subAdministrativeArea}' : placemark.subAdministrativeArea;

  final String? country = placemark.country != null ? '${placemark.country} ${placemark.isoCountryCode}' : placemark.isoCountryCode;

  return '$address, $city, $state, $country';
}

String getEnumName(dynamic enumValue) {
  final String enumString = '$enumValue';
  final String enumName = enumString.substring(enumString.indexOf('.') + 1);
  return enumName;
}
