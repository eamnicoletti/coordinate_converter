import 'package:coordinate_converter/coordinate_converter.dart';
import 'package:coordinate_converter/src/math/coord_converter.dart';
import 'package:proj4dart/proj4dart.dart';

class FromUTMConverter {
  /// Converts UTM coordinates to decimal degree coordinates.
  ///
  /// This function takes a [UTMCoordinates] object as input and returns a
  /// [DDCoordinates] object. The conversion is done using the proj4dart
  /// library, which provides accurate and efficient coordinate transformations.
  ///
  /// @param utm The UTM coordinates to convert.
  /// @return The converted decimal degree coordinates.
  static DDCoordinates convertUTMtoDD(UTMCoordinates utmCoords) {
    // Determine the UTM zone and hemisphere
    final utmZone = utmCoords.zoneNumber;
    final utmHemisphere = utmCoords.isSouthernHemisphere ? 'S' : 'N';

    // Define the UTM projection and WGS84 (DD) projection string
    final defString = '+proj=utm +zone='
        '$utmZone +${utmHemisphere == 'N' ? 'north' : 'south'} '
        '+ellps=WGS84 +datum=WGS84 +units=m +no_defs';

    // Create a UTM projection using the zone number and hemisphere
    final utmProjection = Projection.add(
      'UTM$utmZone$utmHemisphere',
      defString,
    );

    // Create a WGS84 projection
    final wgs84Projection = Projection.get('EPSG:4326');

    // Create a point from the UTM coordinates
    final point = Point(x: utmCoords.x, y: utmCoords.y);

    // Transform the point from the UTM projection to the WGS84 projection
    final transformedPoint = utmProjection.transform(wgs84Projection!, point);

    // Return the transformed point as decimal degree coordinates
    return DDCoordinates(
      latitude: transformedPoint.y,
      longitude: transformedPoint.x,
    );
  }

  /// Converts UTM coordinates to degrees, minutes and seconds (DMS)
  /// coordinates.
  ///
  /// This function takes a [UTMCoordinates] object as input and returns a
  /// [DDCoordinates] object. The conversion is done using the proj4dart
  /// library, which provides accurate and efficient coordinate transformations.
  ///
  /// @param utm The UTM coordinates to convert.
  /// @return The converted DMS coordinates.
  static DMSCoordinates convertUTMtoDMS(UTMCoordinates utmCoords) {
    // Convert UTM to DD
    final ddCoords = convertUTMtoDD(utmCoords);

    // Convert decimal degrees to DMS
    return CoordConverter.ddToDMS(ddCoords);
  }
}
