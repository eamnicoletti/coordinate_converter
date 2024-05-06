import 'package:coordinate_converter/coordinate_converter.dart';
import 'package:flutter/material.dart';

void main() {
  // Create news instances of Coordinates objects
  // Decimal Degrees Coordinates
  DDCoordinates ddCoords = DDCoordinates(
    latitude: -20.762535,
    longitude: -41.531941,
  );

  // Degrees, Minutes and Seconds Coordinates
  DMSCoordinates dmsCoords = DMSCoordinates(
    latDegrees: 20,
    latMinutes: 45,
    latSeconds: 45.12,
    latDirection: DirectionY.south,
    longDegrees: 41,
    longMinutes: 31,
    longSeconds: 54.98,
    longDirection: DirectionX.west,
  );

  // Universal Transverse Mercator Coordinates
  UTMCoordinates utmCoords = UTMCoordinates(
    x: 236379,
    y: 7702067,
    zoneNumber: 24,
    isSouthernHemisphere: true,
  );

  // ---------------------------------------------------------------------------

  // Example 1: Convert to DD

  // 1.1 DMS to DD
  // Use static method
  DDCoordinates convertedDDCoords = DDCoordinates.fromDMS(dmsCoords);
  // OR
  // Convert the current instance
  convertedDDCoords = dmsCoords.toDD();

  debugPrint('\n1.1. DMS to DD:');
  debugPrint('Input DMS: ${dmsCoords.toString()}');
  debugPrint('Output DD: ${convertedDDCoords.toString()}');
  // flutter: DMS to DD:
  // flutter: Input DMS: 20° 45' 45.12" S | 41° 31 54.98" W
  // flutter: Output DD: -20.762533333333334, -41.53193888888889

  // 1.2 UTM to DD
  // Use static method
  convertedDDCoords = DDCoordinates.fromUTM(utmCoords);
  // OR
  // Convert the current instance
  convertedDDCoords = utmCoords.toDD();

  debugPrint('\n1.2. UTM to DD:');
  debugPrint('Input UTM: ${utmCoords.toString()}');
  debugPrint('Output DD: ${convertedDDCoords.toString()}');
  // flutter: DMS to DD:
  // flutter: Input UTM: 24 236379.0 / 7702067.0 S
  // flutter: Output DD: -20.76253582021867, -41.53194825871451

  // ---------------------------------------------------------------------------

  // Example 2: Convert to DMS

  // 2.1 DD to DMS
  // Use static method
  DMSCoordinates convertedDMSCoords = DMSCoordinates.fromDD(ddCoords);
  // OR
  // Convert the current instance
  convertedDMSCoords = ddCoords.toDMS();

  debugPrint('\n2.1. DD to DMS:');
  debugPrint('Input DD: ${ddCoords.toString()}');
  debugPrint('Output DMS: ${convertedDMSCoords.toString()}');
  // flutter: DD to DMS:
  // flutter: Input DD: -20.762535, -41.531941
  // flutter: Output DMS: 20° 45' 45.13" S | 41° 31 54.99" W

  // 2.2 UTM to DMS
  // Use static method
  convertedDMSCoords = DMSCoordinates.fromUTM(utmCoords);
  // OR
  // Convert the current instance
  convertedDMSCoords = utmCoords.toDMS();

  debugPrint('\n2.2. UTM to DMS:');
  debugPrint('Input UTM: ${utmCoords.toString()}');
  debugPrint('Output DMS: ${convertedDMSCoords.toString()}');
  // flutter: UTM to DMS:
  // flutter: Input UTM: 24 236379.0 / 7702067.0 S
  // flutter: Output DMS: 20° 45' 45.13" S | 41° 31 54.99" W

  // ---------------------------------------------------------------------------

  // Example 3: Convert to UTM

  // 3.1 DD to UTM
  // Use static method
  UTMCoordinates convertedUTMCoords = UTMCoordinates.fromDD(ddCoords);
  // OR
  // Convert the current instance
  convertedUTMCoords = ddCoords.toUTM();

  debugPrint('\n3.1. DD to UTM:');
  debugPrint('Input DD: ${ddCoords.toString()}');
  debugPrint('Output UTM: ${convertedUTMCoords.toString()}');
  // flutter: Input DD: -20.762535, -41.531941
  // flutter: Output UTM: 24 236379.75470806437 / 7702067.102859227 S

  // 3.2 DMS to UTM
  // Use static method
  convertedUTMCoords = UTMCoordinates.fromDMS(dmsCoords);
  // OR
  // Convert the current instance
  convertedUTMCoords = dmsCoords.toUTM();

  debugPrint('\n3.2. DMS to UTM:');
  debugPrint('Input DMS: ${dmsCoords.toString()}');
  debugPrint('Output UTM: ${convertedUTMCoords.toString()}');
  // flutter: Input DMS: 20° 45' 45.12" S | 41° 31 54.98" W
  // flutter: Output UTM: 24 236379.75470806437 / 7702067.102859227 S
}
