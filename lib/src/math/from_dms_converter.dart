import 'package:coordinate_converter/coordinate_converter.dart';
import 'package:coordinate_converter/src/math/from_dd_converter.dart';

/// A class for converting coordinates from DMS to UTM and DD.
class FromDMSConverter {
  /// Private constructor to prevent instantiation of the class.
  /// Since all methods are static, there's no need to create objects.
  FromDMSConverter._();

  /// Converts DMS coordinates to decimal degrees coordinates (DMS).
  ///
  /// This function takes a [DMSCoordinates] object as input and returns a
  /// [UTMCoordinates] object. The conversion is done computing the ellipsoidal
  /// distance from the equator to a point at a given latitude.
  ///
  /// Reference: Hoffmann-Wellenhof, B., Lichtenegger, H., and Collins, J.,
  /// GPS: Theory and Practice, 3rd ed. New York: Springer-Verlag Wien, 1994.
  ///
  /// @param dmsCoords: The DMS coordinates to convert.
  /// @return The converted UTM coordinates.
  static UTMCoordinates convertDMStoUTM(DMSCoordinates dmsCoords) {
    final ddCoords = convertDMStoDD(dmsCoords);

    return FromDDConverter.convertDDtoUTM(ddCoords);
  }

  /// Converts Degrees-Minutes-Seconds (DMS) coordinates to Decimal Degrees
  /// (DD).
  ///
  /// This method assumes the coordinates are in the WGS84 reference system
  ///
  /// @param dmsCoords: The DMS coordinates to convert.
  /// @return The converted DD coordinates.
  static DDCoordinates convertDMStoDD(DMSCoordinates dmsCoords) {
    final ddLatitude = _convertLatDMSToDD(
      dmsCoords.latDegrees,
      dmsCoords.latMinutes,
      dmsCoords.latSeconds,
      dmsCoords.latDirection,
    );
    final ddLongitude = _converLongtDMSToDD(
      dmsCoords.longDegrees,
      dmsCoords.longMinutes,
      dmsCoords.longSeconds,
      dmsCoords.longDirection,
    );

    return DDCoordinates(latitude: ddLatitude, longitude: ddLongitude);
  }

  /// Internal helper methods to convert DMS components (degrees, minutes,
  /// seconds) to decimal degrees.
  ///
  /// Args:
  ///   degrees: The integer value of degrees.
  ///   minutes: The integer value of minutes.
  ///   seconds: The double value of seconds.
  ///   direction: The direction (north or south) as an
  ///              [DirectionY] enum. 0 represents positive
  ///              (north or east), and 1 represents negative (south or west).
  ///
  /// Returns:
  ///   The converted latitude decimal degree value.
  static double _convertLatDMSToDD(
    int degrees,
    int minutes,
    double seconds,
    DirectionY direction,
  ) {
    final decimalDegrees = degrees + minutes / 60 + seconds / 3600;
    return direction == DirectionY.north ? decimalDegrees : -decimalDegrees;
  }

  /// Internal helper methods to convert DMS components (degrees, minutes,
  /// seconds) to decimal degrees.
  ///
  /// Args:
  ///   degrees: The integer value of degrees.
  ///   minutes: The integer value of minutes.
  ///   seconds: The double value of seconds.
  ///   direction: The direction (east or west) as an
  ///              [DirectionX] enum. 0 represents positive
  ///              (north or east), and 1 represents negative (south or west).
  ///
  /// Returns:
  ///   The converted longitude decimal degree value.
  static double _converLongtDMSToDD(
    int degrees,
    int minutes,
    double seconds,
    DirectionX direction,
  ) {
    final decimalDegrees = degrees + minutes / 60 + seconds / 3600;
    return direction == DirectionX.east ? decimalDegrees : -decimalDegrees;
  }
}
