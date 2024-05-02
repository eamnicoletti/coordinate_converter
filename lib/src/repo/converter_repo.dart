import 'dart:developer';

import 'package:coordinate_converter/coordinate_converter.dart';
import 'package:coordinate_converter/src/math/from_dd_converter.dart';
import 'package:coordinate_converter/src/math/from_dms_converter.dart';
import 'package:coordinate_converter/src/math/from_utm_converter.dart';

/// A repository class for converting coordinates between different formats.
class ConverterRepository {
  /// Private constructor to prevent instantiation of the class.
  /// Since all methods are static, there's no need to create objects.
  ConverterRepository._();

  /// Converts Decimal Degree (DD) coordinates to Degrees, Minutes, and Seconds
  /// (DMS) coordinates.
  ///
  /// @param ddCoords The DD coordinates to convert.
  /// @return The converted DMS coordinates.
  /// @throws Exception if an error occurs during the conversion.
  static DMSCoordinates convertDDtoDMS(DDCoordinates ddCoords) {
    try {
      return FromDDConverter.convertDDtoDMS(ddCoords);
    } catch (e, stackTrace) {
      final errorMessage = 'Error converting DD to DMS: $e';
      log(errorMessage, error: e, stackTrace: stackTrace);
      throw Exception(errorMessage);
    }
  }

  /// Converts Decimal Degree (DD) coordinates to Universal Transverse Mercator
  /// (UTM) coordinates.
  ///
  /// @param ddCoords The DD coordinates to convert.
  /// @return The converted UTM coordinates.
  /// @throws Exception if an error occurs during the conversion.
  static UTMCoordinates convertDDtoUTM(DDCoordinates ddCoords) {
    try {
      return FromDDConverter.convertDDtoUTM(ddCoords);
    } catch (e, stackTrace) {
      final errorMessage = 'Error converting DD to UTM: $e';
      log(errorMessage, error: e, stackTrace: stackTrace);
      throw Exception(errorMessage);
    }
  }

  /// Converts Degrees, Minutes, and Seconds (DMS) coordinates to Decimal Degree
  /// (DD) coordinates.
  ///
  /// @param dmsCoords The DMS coordinates to convert.
  /// @return The converted DD coordinates.
  /// @throws Exception if an error occurs during the conversion.
  static DDCoordinates convertDMStoDD(DMSCoordinates dmsCoords) {
    try {
      return FromDMSConverter.convertDMStoDD(dmsCoords);
    } catch (e, stackTrace) {
      final errorMessage = 'Error converting DMS to DD: $e';
      log(errorMessage, error: e, stackTrace: stackTrace);
      throw Exception(errorMessage);
    }
  }

  /// Converts Degrees, Minutes, and Seconds (DMS) coordinates to Universal
  /// Transverse Mercator (UTM) coordinates.
  ///
  /// @param dmsCoordinates The DMS coordinates to convert.
  /// @return The converted UTM coordinates.
  /// @throws Exception if an error occurs during the conversion.
  static UTMCoordinates convertDMStoUTM(DMSCoordinates dmsCoordinates) {
    try {
      return FromDMSConverter.convertDMStoUTM(dmsCoordinates);
    } catch (e, stackTrace) {
      final errorMessage = 'Error converting DMS to UTM: $e';
      log(errorMessage, error: e, stackTrace: stackTrace);
      throw Exception(errorMessage);
    }
  }

  /// Converts Universal Transverse Mercator (UTM) coordinates to Decimal Degree
  /// (DD) coordinates.
  ///
  /// @param utmCoords The UTM coordinates to convert.
  /// @return The converted DD coordinates.
  /// @throws Exception if an error occurs during the conversion.
  static DDCoordinates convertUTMtoDD(UTMCoordinates utmCoords) {
    try {
      return FromUTMConverter.convertUTMtoDD(utmCoords);
    } catch (e, stackTrace) {
      final errorMessage = 'Error converting UTM to DD: $e';
      log(errorMessage, error: e, stackTrace: stackTrace);
      throw Exception(errorMessage);
    }
  }

  /// Converts Universal Transverse Mercator (UTM) coordinates to
  /// Degrees-Minutes-Seconds (DMS) coordinates.
  ///
  /// @param utmCoords The UTM coordinates to convert.
  /// @return The converted DMS coordinates.
  /// @throws Exception if an error occurs during the conversion.
  static DMSCoordinates convertUTMtoDMS(UTMCoordinates utmCoords) {
    try {
      return FromUTMConverter.convertUTMtoDMS(utmCoords);
    } catch (e, stackTrace) {
      final errorMessage = 'Error converting UTM to DMS: $e';
      log(errorMessage, error: e, stackTrace: stackTrace);
      throw Exception(errorMessage);
    }
  }
}
