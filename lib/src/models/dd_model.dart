import 'package:coordinate_converter/src/math/coord_converter.dart';
import 'package:coordinate_converter/src/models/dms_model.dart';

/// Decimal Degrees - DD coordinates object.
class DDCoordinates {
  /// constructor
  DDCoordinates({required this.latitude, required this.longitude});

  /// Latitude in decimal degrees [double].
  double latitude;

  /// Longitude in decimal degrees [double].
  double longitude;

  /// Converts Degrees, Minutes and Seconds - DMS coordinates [DMSCoordinates]
  /// to Decimal Degrees - DD coordinates [DDCoordinates].
  static DDCoordinates fromDMS(DMSCoordinates ddCoords) {
    return CoordConverter.dmsToDD(ddCoords);
  }

  /// Converts the current instance of Decimal Degrees (DD) coordinates to
  /// Minutes, and Seconds (DMS) coordinates [DDCoordinates] and returns the
  /// result as a [DMSCoordinates] object.
  DMSCoordinates toDMS() {
    return CoordConverter.ddToDMS(this);
  }

  /// Returns boths coordinates in [String].
  @override
  String toString() {
    return '$latitude, $longitude';
  }
}
