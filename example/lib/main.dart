import 'package:coordinate_converter/coordinate_converter.dart';
import 'package:flutter/material.dart';

void main() {
  // Create news instances of Coordinates objects
  DDCoordinates ddCoords = DDCoordinates(
    latitude: -20.762535,
    longitude: -41.531941,
  );

  DMSCoordinates dmsInput = DMSCoordinates(
    latDegrees: 20,
    latMinutes: 45,
    latSeconds: 45.12540000,
    latDirection: DirectionY.south,
    lonDegrees: 41,
    lonMinutes: 31,
    lonSeconds: 54.98760000,
    lonDirection: DirectionX.west,
  );

  UTMCoordinates utmInput = UTMCoordinates(
    x: 236379,
    y: 7702067,
    zoneNumber: 24,
    isSouthernHemisphere: true,
  );

  // Example 1: Convert DD to DMS
  // Use static method
  DMSCoordinates convertedDMSCoords = DMSCoordinates.fromDD(ddCoords);

  // OR
  // Convert the current instance
  convertedDMSCoords = ddCoords.toDMS();

  debugPrint('DD to DMS:');
  debugPrint('Input DD: ${ddCoords.toString()}');
  debugPrint('Output DMS: ${convertedDMSCoords.toString()}');
  // flutter: DD to DMS:
  // flutter: Input DD: -20.762535, -41.531941
  // flutter: Output DMS: 20° 45' 45.13 S" | 41° 31 54.99" W

  // Example 2: Convert DMS to DD
  // Use static method
  DDCoordinates convertedDDCoords = DDCoordinates.fromDMS(dmsInput);

  // OR
  // Convert the current instance
  convertedDDCoords = dmsInput.toDD();

  debugPrint('\nDMS to DD:');
  debugPrint('Input DMS: ${dmsInput.toString()}');
  debugPrint('Output DD: ${convertedDDCoords.toString()}');
  // flutter: DMS to DD:
  // flutter: Input DMS: 20° 45' 45.13 S" | 41° 31 54.99" W
  // flutter: Output DD: -20.762534833333333, -41.531940999999996

  // Example 3: Convert UTM to DD
  UTMCoordinates convertedUTMCoords = UTMCoordinates.fromDD(ddCoords);

  debugPrint('\nDD to UTM:');
  debugPrint('Input DD: ${ddCoords.toString()}');
  debugPrint('Output UTM: ${convertedUTMCoords.toString()}');
  debugPrint('Expected Output UTM: ${utmInput.toString()}');
  // flutter: Input DD: -20.762535, -41.531941
  // flutter: Output UTM: 236379.75470806437 | 7702067.102859227 24S
  // flutter: Output UTM: 24 236379.0 | 7702067.0 S
}
