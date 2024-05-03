import 'package:coordinate_converter/src/core/enums.dart';
import 'package:coordinate_converter/src/models/dd_model.dart';
import 'package:coordinate_converter/src/models/utm_model.dart';
import 'package:coordinate_converter/src/repo/converter_repo.dart';

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
  })  : assert(
          latDegrees >= -90 && latDegrees <= 90,
          'Latitude degrees must be between -90 and 90.',
        ),
        assert(
          latMinutes >= 0 && latMinutes < 60,
          'Latitude minutes must be between 0 and 59.',
        ),
        assert(
          latSeconds >= 0 && latSeconds < 60,
          'Latitude seconds must be between 0 and 59.',
        ),
        assert(
          latDirection == DirectionY.north || latDirection == DirectionY.south,
          'Invalid latitude direction.',
        ),
        assert(
          longDegrees >= -180 && longDegrees <= 180,
          'Longitude degrees must be between -180 and 180.',
        ),
        assert(
          longMinutes >= 0 && longMinutes < 60,
          'Longitude minutes must be between 0 and 59.',
        ),
        assert(
          longSeconds >= 0 && longSeconds < 60,
          'Longitude seconds must be between 0 and 59.',
        ),
        assert(
          longDirection == DirectionX.east || longDirection == DirectionX.west,
          'Invalid longitude direction.',
        );

  /// Latitude degrees in [int].
  /// Latitude degrees must be between -90 and 90.
  int latDegrees;

  /// Latitude minutes in [int].
  /// Latitude minutes must be between 0 and 59.
  int latMinutes;

  /// Latitude seconds in [double].
  /// Latitude seconds must be between 0 and 59.
  double latSeconds;

  /// Latitude direction in [DirectionY] enum.
  DirectionY latDirection;

  /// Longitude minutes in [int].
  /// Longitude degrees must be between -180 and 180.
  int longDegrees;

  /// Longitude minutes in [int].
  /// Longitude minutes must be between 0 and 59.
  int longMinutes;

  /// Longitude seconds in [double].
  /// Longitude seconds must be between 0 and 59.
  double longSeconds;

  /// Latitude direction in [DirectionX] enum.
  DirectionX longDirection;

  /// Converts Decimal Degrees (DD) coordinates to Degrees, Minutes and Seconds
  /// (DMS) coordinates.
  ///
  /// @param [DDCoordinates].
  /// @return [DMSCoordinates].
  static DMSCoordinates fromDD(DDCoordinates ddCoords) {
    return ConverterRepository.convertDDtoDMS(ddCoords);
  }

  /// Converts UTM coordinates to Degrees, Minutes and Seconds (DMS)
  /// coordinates.
  ///
  /// @param [UTMCoordinates].
  /// @return [DMSCoordinates].
  static DMSCoordinates fromUTM(UTMCoordinates utmCoordinates) {
    return ConverterRepository.convertUTMtoDMS(utmCoordinates);
  }

  /// Converts the current instance of Degrees, Minutes, and Seconds (DMS)
  /// coordinates to Decimal Degrees (DD) coordinates object.
  ///
  /// @return [DDCoordinates].
  DDCoordinates toDD() {
    return ConverterRepository.convertDMStoDD(this);
  }

  /// Converts the current instance of Degrees, Minutes, and Seconds (DMS)
  /// coordinates to UTM coordinates object.
  ///
  /// @return [UTMCoordinates].
  UTMCoordinates toUTM() {
    return ConverterRepository.convertDMStoUTM(this);
  }

  /// Returns current instance of coordinates in [String].
  @override
  String toString() {
    return "$latDegrees° $latMinutes' ${latSeconds.toStringAsFixed(2)}"
        ' ${latDirection.abbreviation}" | $longDegrees° $longMinutes '
        '${longSeconds.toStringAsFixed(2)}" ${longDirection.abbreviation}';
  }
}
