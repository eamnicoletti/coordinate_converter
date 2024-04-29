import 'dart:math' as math;

import 'package:coordinate_converter/coordinate_converter.dart';

/// Class for converting coordinates between DMS and DD formats.
class CoordConverter {
  /// Private constructor to prevent instantiation of the class.
  /// Since all methods are static, there's no need to create objects.
  CoordConverter._();

  /// Semi-major axis of the ellipsoid model (WGS84), in meters.
  static const double smA = 6378137;

  /// Semi-minor axis of the ellipsoid model (WGS84), in meters.
  static const double smB = 6356752.314;

  /// Eccentricity squared of the ellipsoid model (WGS84).
  static const double smEccSquared = 6.69437999013e-03;

  /// Universal Transverse Mercator (UTM) scale factor.
  static const double utmScaleFactor = 0.9996;

  /// Converts Degrees-Minutes-Seconds (DMS) coordinates to Decimal Degrees
  /// (DD).
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

  /// Converts Decimal Degrees (DD) coordinates to Degrees-Minutes-Seconds
  /// (DMS).
  ///
  /// This method assumes the coordinates are in the WGS84 reference system.
  ///
  /// Args:
  ///   ddCoords: The DDCoordinates object containing the decimal degrees
  ///   values.
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

  /// Converts Decimal Degrees (DD) to Universal Transverse Mercator (UTM)
  /// coordinates.
  ///
  /// This function assumes the UTM coordinates are in the WGS84 reference
  /// system.
  ///
  /// Args:
  ///   utmEasting: The easting value in meters.
  ///   utmNorthing: The northing value in meters.
  ///   utmZone: The UTM zone number (1 to 60).
  ///   utmLetter: The UTM zone letter ('N' or 'S' for northern or southern
  ///   hemisphere).
  ///
  /// Returns:
  ///   A DDCoordinates object containing the converted decimal degrees values
  ///   for latitude and longitude.
  static UTMCoordinates ddToUTM(DDCoordinates ddCoords) {
    final lat = _degToRad(ddCoords.latitude);
    final lon = _degToRad(ddCoords.longitude);
    final zone =
        ((ddCoords.longitude + 180.0) / 6).floor() + 1; // Calculate UTM zone
    final lambda0 = _utmCentralMeridian(zone);
    final xy = _mapLatLonToXY(lat, lon, lambda0);
    xy[0] = xy[0] * utmScaleFactor + 500000.0;
    xy[1] = xy[1] * utmScaleFactor;
    if (xy[1] < 0.0) {
      xy[1] += 10000000.0;
    }

    // Check if the point is in the southern hemisphere
    final isSouthernHemisphere = ddCoords.latitude < 0;

    return UTMCoordinates(
      x: xy[0],
      y: xy[1],
      zoneNumber: zone,
      isSouthernHemisphere: isSouthernHemisphere,
    );
  }

  /// Converts degrees to radians.
  ///
  /// Args:
  ///   deg: Degrees to be converted to radians.
  ///
  /// Returns:
  ///   The equivalent value in radians.
  static double _degToRad(double deg) => deg / 180.0 * math.pi;

  /// Computes the ellipsoidal distance from the equator to a point at a given
  /// latitude.
  ///
  /// Reference: Hoffmann-Wellenhof, B., Lichtenegger, H., and Collins, J.,
  /// GPS: Theory and Practice, 3rd ed. New York: Springer-Verlag Wien, 1994.
  ///
  /// Args:
  ///   phi: Latitude of the point, in radians.
  ///
  /// Returns:
  ///   The ellipsoidal distance of the point from the equator, in meters.
  static double _arcLengthOfMeridian(double phi) {
    const n = (smA - smB) / (smA + smB);
    final alpha = ((smA + smB) / 2.0) *
        (1.0 + (math.pow(n, 2.0) / 4.0) + (math.pow(n, 4.0) / 64.0));
    final beta = (-3.0 * n / 2.0) +
        (9.0 * math.pow(n, 3.0) / 16.0) +
        (-3.0 * math.pow(n, 5.0) / 32.0);
    final gamma =
        (15.0 * math.pow(n, 2.0) / 16.0) + (-15.0 * math.pow(n, 4.0) / 32.0);
    final delta =
        (-35.0 * math.pow(n, 3.0) / 48.0) + (105.0 * math.pow(n, 5.0) / 256.0);
    final epsilon = 315.0 * math.pow(n, 4.0) / 512.0;
    final result = alpha *
        (phi +
            (beta * math.sin(2.0 * phi)) +
            (gamma * math.sin(4.0 * phi)) +
            (delta * math.sin(6.0 * phi)) +
            (epsilon * math.sin(8.0 * phi)));
    return result;
  }

  /// Determines the central meridian for the given UTM zone in radians.
  ///
  /// Args:
  ///   zone: An integer value designating the UTM zone, range [1,60].
  ///
  /// Returns:
  ///   The central meridian for the given UTM zone, in radians.
  ///   The range of the central meridian is the radian equivalent of
  ///   [-177,+177].
  static double _utmCentralMeridian(int zone) =>
      math.pi * (-183.0 + (zone * 6.0)) / 180.0;

  /// Converts a latitude/longitude pair to x and y coordinates in the
  /// Transverse Mercator projection.
  ///
  /// Reference: Hoffmann-Wellenhof, B., Lichtenegger, H., and Collins, J.,
  /// GPS: Theory and Practice, 3rd ed.  New York: Springer-Verlag Wien, 1994.
  ///
  /// Args:
  ///   phi: Latitude of the point, in radians.
  ///   lambda: Longitude of the point, in radians.
  ///   lambda0: Longitude of the central meridian to be used, in radians.
  ///
  /// Returns:
  ///   A list containing the x and y coordinates of the computed point.
  ///   Index 0 contains the x-coordinate, and index 1 contains the
  ///   y-coordinate.
  static List<double> _mapLatLonToXY(
    double phi,
    double lambda,
    double lambda0,
  ) {
    // Predefined variables used in the calculation.
    // Pre-calculate ep2, nu2, N, and t for simplification.
    final ep2 = (math.pow(smA, 2.0) - math.pow(smB, 2.0)) / math.pow(smB, 2.0);
    final nu2 = ep2 * math.pow(math.cos(phi), 2.0);
    final N = math.pow(smA, 2.0) / (smB * math.sqrt(1 + nu2));
    final t = math.tan(phi);
    final t2 = t * t;
    final l = lambda - lambda0;
    final l3coef = 1.0 - t2 + nu2;
    final l4coef = 5.0 - t2 + 9 * nu2 + 4.0 * (nu2 * nu2);
    final l5coef = 5.0 - 18.0 * t2 + (t2 * t2) + 14.0 * nu2 - 58.0 * t2 * nu2;
    final l6coef =
        61.0 - 58.0 * t2 + (t2 * t2) + 270.0 * nu2 - 330.0 * t2 * nu2;
    final l7coef = 61.0 - 479.0 * t2 + 179.0 * (t2 * t2) - (t2 * t2 * t2);
    final l8coef = 1385.0 - 3111.0 * t2 + 543.0 * (t2 * t2) - (t2 * t2 * t2);

    // Calculate easting (x) and northing (y).
    final x = N * math.cos(phi) * l +
        (N / 6.0 * math.pow(math.cos(phi), 3.0) * l3coef * math.pow(l, 3.0)) +
        (N / 120.0 * math.pow(math.cos(phi), 5.0) * l5coef * math.pow(l, 5.0)) +
        (N / 5040.0 * math.pow(math.cos(phi), 7.0) * l7coef * math.pow(l, 7.0));

    final y = _arcLengthOfMeridian(phi) +
        (t / 2.0 * N * math.pow(math.cos(phi), 2.0) * math.pow(l, 2.0)) +
        (t /
            24.0 *
            N *
            math.pow(math.cos(phi), 4.0) *
            l4coef *
            math.pow(l, 4.0)) +
        (t /
            720.0 *
            N *
            math.pow(math.cos(phi), 6.0) *
            l6coef *
            math.pow(l, 6.0)) +
        (t /
            40320.0 *
            N *
            math.pow(math.cos(phi), 8.0) *
            l8coef *
            math.pow(l, 8.0));

    // Return the list with computed x and y coordinates.
    return [x, y];
  }

  /// Internal helper methods to convert DMS components (degrees, minutes,
  /// seconds) to decimal degrees.
  ///
  /// Args:
  ///   degrees: The integer value of degrees.
  ///   minutes: The integer value of minutes.
  ///   seconds: The double value of seconds.
  ///   direction: The direction (north, south, east, or west) as an
  ///              [DirectionX] or [DirectionY] enum. 0 represents positive
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
  ///   A list containing [degrees, minutes, seconds, direction] (all integers
  ///   except seconds). Direction is 0 for positive (north or east) and 1 for
  ///   negative (south or west).
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
