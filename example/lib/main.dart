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
}
