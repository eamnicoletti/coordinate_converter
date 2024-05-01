import 'package:coordinate_converter/src/math/coord_converter.dart';
import 'package:coordinate_converter/src/models/dms_model.dart';
import 'package:coordinate_converter/src/models/utm_model.dart';

class FromDMSConverter {
  /// Converts DMS coordinates to decimal degrees coordinates (DMS).
  ///
  /// This function takes a [DMSCoordinates] object as input and returns a
  /// [UTMCoordinates] object. The conversion is done computing the ellipsoidal
  /// distance from the equator to a point at a given latitude.
  ///
  /// Reference: Hoffmann-Wellenhof, B., Lichtenegger, H., and Collins, J.,
  /// GPS: Theory and Practice, 3rd ed. New York: Springer-Verlag Wien, 1994.
  ///
  /// @param dmsCoords The DMS coordinates to convert.
  /// @return The converted UTM coordinates.
  static UTMCoordinates convertDMStoUTM(DMSCoordinates dmsCoords) {
    final ddCoords = CoordConverter.dmsToDD(dmsCoords);

    return CoordConverter.ddToUTM(ddCoords);
  }
}
