import 'package:coordinate_converter/src/math/coord_converter.dart';
import 'package:coordinate_converter/src/models/dd_model.dart';

/// Universal Transverse Mercator - UTM coordinates object.
class UTMCoordinates {
  /// constructor
  UTMCoordinates({
    required this.x,
    required this.y,
    required this.zoneNumber,
    this.isSouthernHemisphere = false,
  }) {
    if (zoneNumber < 1 || zoneNumber > 60) {
      throw ArgumentError(
        'Invalid zone number. Zone number must be between 1 and 60.',
      );
    }
    zoneNumber = zoneNumber;
  }

  /// Easting Coordinate in [double]. (x-coordinate)
  double x;

  /// Northing Coordinate in [double]. (y-coordinate)
  double y;

  /// UTM Zone Number in [int].
  ///
  /// Note: The range is 1 to 60.
  ///
  /// If the number outside this range is passed an [ArgumentError] will
  /// be thrown.
  int zoneNumber;

  /// Northern Hemisphere ([bool] false) or Southern Hemisphere ([bool] true).
  bool isSouthernHemisphere;

  /// Converts Universal Transverse Mercator - UTM coordinates [UTMCoordinates]
  /// to Decimal Degrees - DD coordinates [DDCoordinates].
  static UTMCoordinates fromDD(DDCoordinates ddCoords) {
    return CoordConverter.ddToUTM(ddCoords);
  }

  /// Returns boths coordinates in [String].
  @override
  String toString() {
    return '$zoneNumber $x / $y ${isSouthernHemisphere ? 'S' : 'N'}';
  }
}
