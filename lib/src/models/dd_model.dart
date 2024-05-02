import 'package:coordinate_converter/src/models/dms_model.dart';
import 'package:coordinate_converter/src/models/utm_model.dart';
import 'package:coordinate_converter/src/repo/converter_repo.dart';

/// Decimal Degrees - DD coordinates object.
class DDCoordinates {
  /// constructor
  DDCoordinates({required this.latitude, required this.longitude})
      : assert(
          latitude >= -90 && latitude <= 90,
          'Latitude must be between -90 and 90 degrees.',
        ),
        assert(
          longitude >= -180 && longitude <= 180,
          'Longitude must be between -180 and 180 degrees.',
        );

  /// Latitude in decimal degrees [double].
  /// Must be between -90 and 90 degrees.
  double latitude;

  /// Longitude in decimal degrees [double].
  /// Must be between -180 and 180 degrees.
  double longitude;

  /// Converts Degrees, Minutes and Seconds - DMS coordinates [DMSCoordinates]
  /// to Decimal Degrees - DD coordinates [DDCoordinates].
  static DDCoordinates fromDMS(DMSCoordinates ddCoords) {
    return ConverterRepository.convertDMStoDD(ddCoords);
  }

  /// Converts the current instance of Decimal Degrees (DD) coordinates
  /// [DDCoordinates] to Minutes, and Seconds (DMS) coordinates and returns the
  /// result as a [DMSCoordinates] object.
  DMSCoordinates toDMS() {
    return ConverterRepository.convertDDtoDMS(this);
  }

  /// Converts Universal Transverse Mercator - UTM coordinates [UTMCoordinates]
  /// to Decimal Degrees - DD coordinates [DDCoordinates].
  static DDCoordinates fromUTM(UTMCoordinates utmCoords) {
    return ConverterRepository.convertUTMtoDD(utmCoords);
  }

  /// Converts the current instance of Decimal Degrees (DD) coordinates
  /// [DDCoordinates] to Minutes, and Seconds (DMS) coordinates and returns the
  /// result as a [UTMCoordinates] object.
  UTMCoordinates toUTM() {
    return ConverterRepository.convertDDtoUTM(this);
  }

  /// Returns current instance of coordinates in [String].
  @override
  String toString() {
    return '$latitude, $longitude';
  }
}
