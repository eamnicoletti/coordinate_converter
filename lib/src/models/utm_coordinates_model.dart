import 'package:coordinate_converter/src/models/dd_coordinates_model.dart';
import 'package:coordinate_converter/src/models/dms_coordinates_model.dart';
import 'package:coordinate_converter/src/repo/converter_repo.dart';

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

  /// Easting Coordinate in [double]. (x-coordinate in meters)
  double x;

  /// Northing Coordinate in [double]. (y-coordinate in meters)
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

  /// Converts Decimal Degrees (DD) coordinates [DDCoordinates]
  /// to Universal Transverse Mercator (UTM) coordinates [UTMCoordinates].
  static UTMCoordinates fromDD(DDCoordinates ddCoords) {
    return ConverterRepository.convertDDtoUTM(ddCoords);
  }

  /// Converts Degrees, Minutes and Seconds (DMS) coordinates [DMSCoordinates]
  /// to Universal Transverse Mercator (UTM) coordinates [UTMCoordinates].
  static UTMCoordinates fromDMS(DMSCoordinates dmsCoords) {
    return ConverterRepository.convertDMStoUTM(dmsCoords);
  }

  /// Converts the current instance of UTM coordinates [UTMCoordinates] to
  /// Decimal Degrees (DD) coordinates and returns the result as a
  /// [DDCoordinates] object.
  DDCoordinates toDD() {
    return ConverterRepository.convertUTMtoDD(this);
  }

  /// Converts the current instance of UTM coordinates [UTMCoordinates] to
  /// Degrees, Minutes and Seconds (DMS) coordinates and returns the result as
  /// a [DMSCoordinates] object.
  DMSCoordinates toDMS() {
    return ConverterRepository.convertUTMtoDMS(this);
  }

  /// Returns current instance of coordinates in [String].
  @override
  String toString() {
    return '$zoneNumber $x / $y ${isSouthernHemisphere ? 'South' : 'North'}';
  }

  // A decimal-point string-representation of this number.
  //
  // Converts this number to a [double] before computing the string
  // representation, as by [toDouble].
  //
  // If the absolute value of `this` is greater than or equal to `10^21`, then
  // this methods returns an exponential representation computed by
  // `this.toStringAsExponential()`. Otherwise the result is the closest string
  // representation with exactly [fractionDigits] digits after the decimal
  // point. If [fractionDigits] equals 0, then the decimal point is omitted.
  //
  // The parameter [fractionDigits] must be an integer satisfying:
  // `0 <= fractionDigits <= 20`.
  //
  /// @param [fractionDigits] as an integer .
  /// @return x of the current instance as a fixed-point [String] with
  /// [fractionDigits] decimal places. Just Numbers.
  String xToStringAsFixed(int fractionDigits) {
    return x.toStringAsFixed(fractionDigits);
  }

  // A decimal-point string-representation of this number.
  //
  // Converts this number to a [double] before computing the string
  // representation, as by [toDouble].
  //
  // If the absolute value of `this` is greater than or equal to `10^21`, then
  // this methods returns an exponential representation computed by
  // `this.toStringAsExponential()`. Otherwise the result is the closest string
  // representation with exactly [fractionDigits] digits after the decimal
  // point. If [fractionDigits] equals 0, then the decimal point is omitted.
  //
  // The parameter [fractionDigits] must be an integer satisfying:
  // `0 <= fractionDigits <= 20`.
  //
  /// @param [fractionDigits] as an integer .
  /// @return y of the current instance as a fixed-point [String] with
  /// [fractionDigits] decimal places. Just Numbers.
  String yToStringAsFixed(int fractionDigits) {
    return y.toStringAsFixed(fractionDigits);
  }
}
