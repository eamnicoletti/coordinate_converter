import 'package:proj4dart/proj4dart.dart';

/// A class for managing projections.
class ProjectionManager {
  ProjectionManager._();

  /// Map to store the created projections.
  static final Map<String, Projection> _projections = {};

  /// Creates a UTM projection using the zone number and hemisphere.
  /// If the projection already exists, it is retrieved from the map.
  static Projection getUTMProjection(
    int utmZone, {
    required bool isSouthernHemisphere,
  }) {
    // Determine the hemisphere and UTM zone key
    final utmHemisphere = isSouthernHemisphere ? 'S' : 'N';
    final projectionKey = 'UTM$utmZone$utmHemisphere';

    // Define the UTM projection and WGS84 (DD) projection string
    final defString = '+proj=utm +zone='
        '$utmZone +${utmHemisphere == 'N' ? 'north' : 'south'} '
        '+ellps=WGS84 +datum=WGS84 +units=m +no_defs';

    // check if the key exists and set a new one if it doesn't
    return _projections.putIfAbsent(
      projectionKey,
      () => Projection.add(projectionKey, defString),
    );
  }
}
