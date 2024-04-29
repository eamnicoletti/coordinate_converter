# Coordinate Converter

<!-- [![pub package][pub_badge]][pub_badge_link] -->
[![License: MIT][license_badge]][license_badge_link]
[![style: very good analysis][badge]][badge_link]

A package for converting between UTM, DMS and DD coordinates in the WGS84 ellipsoid model.

- **UTM** | Universal Transverse Mercator
- **DMS** | - Degrees, Minutes and Seconds
- **DD** | - Decimal Degrees

- **WGS-84** | Standart used in most maps such as Google Maps, Apple Maps, Mapbox, OpenStreetMaps, etc

The Universal Transverse Mercator - UTM coordinate system is explained on this [Wikipedia](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system) page.
The Geographic Coordinate System - GCS is explained on this [Wikipedia](https://en.wikipedia.org/wiki/Geographic_coordinate_system) page.
The World Geodetic System and WGS84 are explained on this [Wikipedia](https://en.wikipedia.org/wiki/World_Geodetic_System#WGS84) page.

Based on formulas from [here](https://sigam.ambiente.sp.gov.br/sigam3/Controles/latlongutm.htm?latTxt=ctl00_con).

## Getting started

### Add dependency

```yaml
dependencies:
  coord_convert: 0.3.0
```

## Usage

Convert DD to DMS

```dart
import 'package:coordinate_converter/coordinate_converter.dart';
import 'package:flutter/material.dart';

// Create a DDCoordinates object
DDCoordinates ddCoordInput = DDCoordinates(
    latitude: -20.762535,
    longitude: -41.531941,
);

// call fromDD static method from DMSCoordinates
DMSCoordinates dmsCoords = DMSCoordinates.fromDD(ddCoordInput);

debugPrint('Output DMS: ${dmsCoords.toString()}');
// Print output of overridden toString method:
// flutter: Output DMS: 20° 45' 45.13 S" | 41° 31 54.99" W
```

Convert DMS to DD

```dart
// Create a DMSCoordinates object
 DMSCoordinates dmsCoordInput = DMSCoordinates(
    latDegrees: 20,
    latMinutes: 45,
    latSeconds: 45.12540000,
    latDirection: DirectionY.south,
    lonDegrees: 41,
    lonMinutes: 31,
    lonSeconds: 54.98760000,
    lonDirection: DirectionX.west,
  );

// call fromDMS static method from DDCoordinates
 DDCoordinates ddCoords = DDCoordinates.fromDMS(dmsCoordInput);

 debugPrint('Output DD: ${ddCoords.toString()}');
// Print output of overridden toString method:
// flutter: Output DD: -20.762534833333333, -41.531940999999996
```

Convert DD to UTM

```dart
// call fromDD static method from UTMCoordinates
 UTMCoordinates utmCoord = UTMCoordinates.fromDD(ddCoordInput);

debugPrint('Output UTM: ${utmCoord.toString()}');
// Print output of overridden toString method:
// flutter: Output UTM: 24 S 236379.0 | 7702067.0
```

## Contributing

Pull requests are welcome.

[badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[badge_link]: https://pub.dev/packages/very_good_analysis
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_badge_link]: https://opensource.org/licenses/MIT
<!-- 
[pub_badge]: https://img.shields.io/pub/v/
[pub_badge_link]: https://pub.dartlang.org/packages/coordinate_converter -->
