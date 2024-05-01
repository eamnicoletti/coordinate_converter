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
    required this.longDegrees,
    required this.longMinutes,
    required this.longSeconds,
    required this.longDirection,
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
  int longDegrees;

  /// Longitude minutes in [int].
  int longMinutes;

  /// Longitude seconds in [double].
  double longSeconds;

  /// Latitude direction in [DirectionX] enum.
  DirectionX longDirection;

  /// Converts Decimal Degrees - DD coordinates [DDCoordinates] to
  /// Degrees, Minutes and Seconds - DMS coordinates [DMSCoordinates].
  static DMSCoordinates fromDD(DDCoordinates ddCoords) {
    return CoordConverter.ddToDMS(ddCoords);
  }

  /// Converts the current instance of Degrees, Minutes, and Seconds (DMS)
  /// coordinates [DMSCoordinates] to Decimal Degrees (DD) coordinates and
  /// returns the result as a [DDCoordinates] object.
  DDCoordinates toDD() {
    return CoordConverter.dmsToDD(this);
  }

  /// Returns current instance of coordinates in [String].
  @override
  String toString() {
    return "$latDegrees° $latMinutes' ${latSeconds.toStringAsFixed(2)}"
        ' ${latDirection.abbreviation}" | $longDegrees° $longMinutes '
        '${longSeconds.toStringAsFixed(2)}" ${longDirection.abbreviation}';
  }
}
