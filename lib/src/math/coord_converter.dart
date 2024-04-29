import 'package:coordinate_converter/coordinate_converter.dart';

/// Class for converting coordinates between DMS and DD formats.
class CoordConverter {
  /// Private constructor to prevent instantiation of the class.
  /// Since all methods are static, there's no need to create objects.
  CoordConverter._();

  /// Converts Degrees-Minutes-Seconds (DMS) coordinates to Decimal Degrees (DD).
  ///
  /// This method assumes the coordinates are in the WGS84 reference system.
  ///
  /// Args:
  ///   dmsCoords: The DMSCoordinates object containing the DMS values.
  ///
  /// Returns:
  ///   A new DDCoordinates object with the converted decimal degrees values.
  static DDCoordinates dmsToDD(DMSCoordinates dmsCoords) {
    final ddLatitude = _convertLatDMSToDD(
      dmsCoords.latDegrees,
      dmsCoords.latMinutes,
      dmsCoords.latSeconds,
      dmsCoords.latDirection,
    );
    final ddLongitude = _converLongtDMSToDD(
      dmsCoords.lonDegrees,
      dmsCoords.lonMinutes,
      dmsCoords.lonSeconds,
      dmsCoords.lonDirection,
    );

    return DDCoordinates(latitude: ddLatitude, longitude: ddLongitude);
  }

  /// Converts Decimal Degrees (DD) coordinates to Degrees-Minutes-Seconds (DMS).
  ///
  /// This method assumes the coordinates are in the WGS84 reference system.
  ///
  /// Args:
  ///   ddCoords: The DDCoordinates object containing the decimal degrees values.
  ///
  /// Returns:
  ///   A new DMSCoordinates object with the converted DMS values.
  static DMSCoordinates ddToDMS(DDCoordinates ddCoords) {
    final latParts = _convertDDToDMS(ddCoords.latitude);
    final lonParts = _convertDDToDMS(ddCoords.longitude);

    return DMSCoordinates(
      latDegrees: latParts[0] as int,
      latMinutes: latParts[1] as int,
      latSeconds: latParts[2] as double,
      latDirection: latParts[3] == 0 ? DirectionY.north : DirectionY.south,
      lonDegrees: lonParts[0] as int,
      lonMinutes: lonParts[1] as int,
      lonSeconds: lonParts[2] as double,
      lonDirection: lonParts[3] == 0 ? DirectionX.east : DirectionX.west,
    );
  }

  // Converts Universal Transverse Mercator (UTM) coordinates to Decimal Degrees (DD).
  ///
  /// This function assumes the UTM coordinates are in the WGS84 reference system.
  ///
  /// Args:
  ///   utmEasting: The easting value in meters.
  ///   utmNorthing: The northing value in meters.
  ///   utmZone: The UTM zone number (1 to 60).
  ///   utmLetter: The UTM zone letter ('N' or 'S' for northern or southern hemisphere).
  ///
  /// Returns:
  ///   A DDCoordinates object containing the converted decimal degrees values for latitude and longitude.

  /// Internal helper method to convert DMS components (degrees, minutes,
  /// seconds) to decimal degrees.
  ///
  /// Args:
  ///   degrees: The integer value of degrees.
  ///   minutes: The integer value of minutes.
  ///   seconds: The double value of seconds.
  ///   direction: The direction (north, south, east, or west) as an [DirectionX]
  ///              or [DirectionY] enum. 0 represents positive (north or east),
  ///              and 1 represents negative (south or west).
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

  static double _converLongtDMSToDD(
    int degrees,
    int minutes,
    double seconds,
    DirectionX direction,
  ) {
    final decimalDegrees = degrees + minutes / 60 + seconds / 3600;
    return direction == DirectionX.east ? decimalDegrees : -decimalDegrees;
  }

  /// Internal helper method to convert decimal degrees to DMS components.
  ///
  /// Args:
  ///   dd: The decimal degree value.
  ///
  /// Returns:
  ///   A list containing [degrees, minutes, seconds, direction] (all integers except seconds).
  ///   Direction is 0 for positive (north or east) and 1 for negative (south or west).
  static List<dynamic> _convertDDToDMS(double dd) {
    /// Treat the coordinate as positive for calculations
    final positiveDD = dd.abs();
    final degrees = positiveDD.floor();
    final remaining = (positiveDD - degrees) * 60;
    final minutes = remaining.floor();
    final seconds = (remaining - minutes) * 60;

    /// Determine the correct direction based on the original DD value
    final direction = dd >= 0 ? 0 : 1;

    return [degrees, minutes, seconds, direction];
  }
}
