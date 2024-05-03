import 'package:coordinate_converter/coordinate_converter.dart';
import 'package:coordinate_converter/src/math/from_dd_converter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late DDCoordinates ddCoordsBrazil;
  late DDCoordinates ddCoordsUSA;
  late DDCoordinates ddCoordsNetherlands;
  late DDCoordinates ddCoordsAustralia;

  // Sets coordinates in the four quadrants of the globe
  setUpAll(() async {
    ddCoordsBrazil = DDCoordinates(
      latitude: -20.762535,
      longitude: -41.531941,
    );

    ddCoordsUSA = DDCoordinates(
      latitude: 44.963433,
      longitude: -92.966224,
    );

    ddCoordsNetherlands = DDCoordinates(
      latitude: 52.090413,
      longitude: 5.120372,
    );

    ddCoordsAustralia = DDCoordinates(
      latitude: -33.871180,
      longitude: 151.213028,
    );
  });
  group('FromDDConverter - Test in Alegre|ES|Brazil', () {
    test('convertDDtoDMS returns correct DMSCoordinates', () {
      final result = FromDDConverter.convertDDtoDMS(ddCoordsBrazil);

      expect(result.latDegrees, 20);
      expect(result.latMinutes, 45);
      expect(result.latSeconds, closeTo(45.12, 0.1));
      expect(result.latDirection, DirectionY.south);
      expect(result.longDegrees, 41);
      expect(result.longMinutes, 31);
      expect(result.longSeconds, closeTo(54.98, 0.1));
      expect(result.longDirection, DirectionX.west);
    });

    test('convertDDtoUTM returns correct UTMCoordinates', () {
      final result = FromDDConverter.convertDDtoUTM(ddCoordsBrazil);

      expect(result.x, closeTo(236379.0, 0.9));
      expect(result.y, closeTo(7702067.0, 0.9));
      expect(result.zoneNumber, 24);
      expect(result.isSouthernHemisphere, true);
    });
  });

  group('FromDDConverter - Test in Oakdale|MN|USA', () {
    test('convertDDtoDMS returns correct DMSCoordinates', () {
      final result = FromDDConverter.convertDDtoDMS(ddCoordsUSA);

      expect(result.latDegrees, 44);
      expect(result.latMinutes, 57);
      expect(result.latSeconds, closeTo(48.35, 0.1));
      expect(result.latDirection, DirectionY.north);
      expect(result.longDegrees, 92);
      expect(result.longMinutes, 57);
      expect(result.longSeconds, closeTo(58.40, 0.1));
      expect(result.longDirection, DirectionX.west);
    });

    test('convertDDtoUTM returns correct UTMCoordinates', () {
      final result = FromDDConverter.convertDDtoUTM(ddCoordsUSA);

      expect(result.x, closeTo(502663.0, 0.9));
      expect(result.y, closeTo(4978888.0, 0.9));
      expect(result.zoneNumber, 15);
      expect(result.isSouthernHemisphere, false);
    });
  });

  group('FromDDConverter - Test in Utrecht|UT|Netherlands', () {
    test('convertDDtoDMS returns correct DMSCoordinates', () {
      final result = FromDDConverter.convertDDtoDMS(ddCoordsNetherlands);

      expect(result.latDegrees, 52);
      expect(result.latMinutes, 5);
      expect(result.latSeconds, closeTo(25.48, 0.1));
      expect(result.latDirection, DirectionY.north);
      expect(result.longDegrees, 5);
      expect(result.longMinutes, 7);
      expect(result.longSeconds, closeTo(13.33, 0.1));
      expect(result.longDirection, DirectionX.east);
    });

    test('convertDDtoUTM returns correct UTMCoordinates', () {
      final result = FromDDConverter.convertDDtoUTM(ddCoordsNetherlands);

      expect(result.x, closeTo(645263.0, 0.9));
      expect(result.y, closeTo(5773215.0, 0.9));
      expect(result.zoneNumber, 31);
      expect(result.isSouthernHemisphere, false);
    });
  });

  group('FromDDConverter - Test in Sydney|NSW|Australia', () {
    test('convertDDtoDMS returns correct DMSCoordinates', () {
      final result = FromDDConverter.convertDDtoDMS(ddCoordsAustralia);

      expect(result.latDegrees, 33);
      expect(result.latMinutes, 52);
      expect(result.latSeconds, closeTo(16.24, 0.1));
      expect(result.latDirection, DirectionY.south);
      expect(result.longDegrees, 151);
      expect(result.longMinutes, 12);
      expect(result.longSeconds, closeTo(46.90, 0.1));
      expect(result.longDirection, DirectionX.east);
    });

    test('convertDDtoUTM returns correct UTMCoordinates', () {
      final result = FromDDConverter.convertDDtoUTM(ddCoordsAustralia);

      expect(result.x, closeTo(334718.0, 0.9));
      expect(result.y, closeTo(6250690.0, 0.9));
      expect(result.zoneNumber, 56);
      expect(result.isSouthernHemisphere, true);
    });
  });
}
