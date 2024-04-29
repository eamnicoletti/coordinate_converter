import 'package:coordinate_converter/src/core/constants.dart';
import 'package:coordinate_converter/src/math/coord_converter.dart';
import 'package:coordinate_converter/src/models/dd_model.dart';

/// Degrees, Minutes and Seconds - DMS coordinates object.
class DMSCoordinates {
  /// constructor
  DMSCoordinates({
    required this.latDegrees,
    required this.latMinutes,
    required this.latSeconds,
    required this.latDirection,
    required this.lonDegrees,
    required this.lonMinutes,
    required this.lonSeconds,
    required this.lonDirection,
  });

  /// Latitude degrees in [int].
  int latDegrees;

  /// Latitude minutes in [int].
  int latMinutes;

  /// Latitude seconds in [double].
  double latSeconds;

  /// Latitude direction in [DirectionY] enum.
  DirectionY latDirection;

  /// Longitude minutes in [int].
  int lonDegrees;

  /// Longitude minutes in [int].
  int lonMinutes;

  /// Longitude seconds in [double].
  double lonSeconds;

  /// Latitude direction in [DirectionX] enum.
  DirectionX lonDirection;

  /// Converts Decimal Degrees - DD coordinates [DDCoordinates] to
  /// Degrees, Minutes and Seconds - DMS coordinates [DMSCoordinates].
  static DMSCoordinates fromDD(DDCoordinates ddCoords) {
    return CoordConverter.ddToDMS(ddCoords);
  }

  /// Returns boths coordinates in [String].
  @override
  String toString() {
    return "$latDegrees° $latMinutes' ${latSeconds.toStringAsFixed(2)}"
        ' ${latDirection.abbreviation}" | $lonDegrees° $lonMinutes '
        '${lonSeconds.toStringAsFixed(2)}" ${lonDirection.abbreviation}';
  }
}
