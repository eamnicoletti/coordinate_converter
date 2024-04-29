import 'package:coordinate_converter/coordinate_converter.dart';
import 'package:flutter/material.dart';

void main() {
  // Example 1: Convert DD to DMS
  DDCoordinates ddCoords = DDCoordinates(
    latitude: -20.762535,
    longitude: -41.531941,
  );
  DMSCoordinates dmsCoords = DMSCoordinates.fromDD(ddCoords);
  debugPrint('DD to DMS:');
  debugPrint('Input DD: ${ddCoords.latitude}, ${ddCoords.longitude}');
  debugPrint('Output DMS: ${dmsCoords.toString()}');

  // Example 2: Convert DMS to DD
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

  DDCoordinates convertedDD = DDCoordinates.fromDMS(dmsInput);
  debugPrint('\nDMS to DD:');
  debugPrint('Input DMS: ${dmsInput.toString()}');
  debugPrint('Output DD: ${convertedDD.toString()}');

  // Example 3: Convert UTM to DD
  UTMCoordinates utmInput = UTMCoordinates(
    x: 236379,
    y: 7702067,
    zoneNumber: 24,
    isSouthernHemisphere: true,
  );

  UTMCoordinates utmCoordinatesOutPut = UTMCoordinates.fromDD(ddCoords);
  debugPrint('\nDD to UTM:');
  debugPrint('Input DD: ${ddCoords.toString()}');
  debugPrint('Output UTM: ${utmCoordinatesOutPut.toString()}');
  debugPrint('Expected Output UTM: ${utmInput.toString()}');
}
