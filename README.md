# Coordinate Converter

<p align="left">
  <img src=https://raw.githubusercontent.com/eamnicoletti/coordinate_converter/main/assets/logo/logo.png width="300" alt="Coordinate Converter Logo">
</p>

[![pub package][pub_badge]][pub_badge_link]
[![License: MIT][license_badge]][license_badge_link]
[![style: very good analysis][badge]][badge_link]

---

A package for converting between UTM, DMS and DD coordinates in the WGS84 ellipsoid model.


- **UTM** | Universal Transverse Mercator
- **DMS** | - Degrees, Minutes and Seconds
- **DD** | - Decimal Degrees

- **WGS-84** | Standart used in most maps such as Google Maps, Apple Maps, Mapbox, OpenStreetMaps, etc


The Universal Transverse Mercator - UTM coordinate system is explained on this [Wikipedia](https://en.wikipedia.org/wiki/Universal_Transverse_Mercator_coordinate_system) page.

The Geographic Coordinate System - GCS is explained on this [Wikipedia](https://en.wikipedia.org/wiki/Geographic_coordinate_system) page.

The World Geodetic System and WGS84 are explained on this [Wikipedia](https://en.wikipedia.org/wiki/World_Geodetic_System#WGS84) page.


**Note**: This package was inspired by [sigam][sigam_link].

If you like this tool please [star it on GitHub][github_repository_link]

## Getting started

### Add dependency

```yaml
dependencies:
  coord_convert: 1.0.0
```

### Usage

Create new instances of Coordinates objects

```dart
import 'package:coordinate_converter/coordinate_converter.dart';

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
```

1. Convert to DD

```dart
// 1.1 DMS to DD
// Use static method
DDCoordinates convertedDDCoords = DDCoordinates.fromDMS(dmsCoords);
// OR
// Convert the current instance
convertedDDCoords = dmsCoords.toDD();

// 1.2 UTM to DD
// Use static method
convertedDDCoords = DDCoordinates.fromUTM(utmCoords);
// OR
// Convert the current instance
convertedDDCoords = utmCoords.toDD();

debugPrint('Output DD: ${convertedDDCoords.toString()}');
// Print output of overridden toString method:
// flutter: Output DD: -20.76253582021867, -41.53194825871451
```

2. Convert to DMS

```dart
// 2.1 DD to DMS
// Use static method
DMSCoordinates convertedDMSCoords = DMSCoordinates.fromDD(ddCoords);
// OR
// Convert the current instance
convertedDMSCoords = ddCoords.toDMS();

// 2.2 UTM to DMS
// Use static method
convertedDMSCoords = DMSCoordinates.fromUTM(utmCoords);
// OR
// Convert the current instance
convertedDMSCoords = utmCoords.toDMS();

debugPrint('Output DMS: ${convertedDMSCoords.toString()}');
// Print output of overridden toString method:
// flutter: Output DMS: 20° 45' 45.13" S | 41° 31 54.99" W
```
3. Convert to UTM

```dart
// 3.1 DD to UTM
// Use static method
UTMCoordinates convertedUTMCoords = UTMCoordinates.fromDD(ddCoords);
// OR
// Convert the current instance
convertedUTMCoords = ddCoords.toUTM();

// 3.2 DMS to UTM
// Use static method
convertedUTMCoords = UTMCoordinates.fromDMS(dmsCoords);
// OR
// Convert the current instance
convertedUTMCoords = dmsCoords.toUTM();

debugPrint('Output UTM: ${convertedUTMCoords.toString()}');
// Print output of overridden toString method:
// flutter: Output UTM: 24 236379.75470806437 / 7702067.102859227 S
```

Fixed-point string with fixed decimal places

```dart

debugPrint(ddCoords.latitudeToStringAsFixed(2));
debugPrint(ddCoords.longitudeToStringAsFixed(4));
// flutter: -20.76
// flutter: -41.5319

debugPrint(dmsCoords.latitudeToStringAsFixed(4));
debugPrint(dmsCoords.longitudeToStringAsFixed(4));
// flutter: 20° 45' 45.1200"
// flutter: 41° 31' 54.9800"

debugPrint(utmCoords.xToStringAsFixed(5));
debugPrint(utmCoords.yToStringAsFixed(0));
// flutter: 236379.00000
// flutter: 7702067
```

## Contributing

##### :beer: Pull requests are welcome!
Don't forget that `open-source` makes no sense without contributors. No matter how big your changes are, it helps a lot even it is a line of change.

Reporting bugs and issues are contribution too, yes it is.

### Donation
Your donation **motivates** me to work more on the **coordinate_converter** and resolve issues.
There are multiple ways to donate:

1. You can be my sponsor on [GitHub](https://github.com/sponsors/eamnicoletti)
2. If you are a fan of crypto, you can donate me Bitcoins here: `1HhHqNQyJctrcwcYzUE8SrB3b3TVcNVx5P`
3. Or you just: 

   [![Buy Me a Coffee][bymeacoffe_button]][bymeacoffe_donation_link]

[badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[badge_link]: https://pub.dev/packages/very_good_analysis
[bymeacoffe_button]: https://img.buymeacoffee.com/button-api/?slug=eamnicoletq&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[bymeacoffe_donation_link]: https://www.buymeacoffee.com/eamnicoletq
[github_repository_link]: https://github.com/eamnicoletti/coordinate_converter
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_badge_link]: https://opensource.org/licenses/MIT
[pub_badge]: https://img.shields.io/pub/v/coordinate_converter
[pub_badge_link]: https://pub.dartlang.org/packages/coordinate_converter
[sigam_link]: https://sigam.ambiente.sp.gov.br/sigam3/Controles/latlongutm.htm?latTxt=ctl00_con
