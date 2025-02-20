import 'package:coordinate_converter/coordinate_converter.dart';
import 'package:coordinate_converter/src/math/from_utm_converter.dart';
import 'package:test/test.dart';

void main() {
  late UTMCoordinates utmCoordsBrazil;
  late UTMCoordinates utmCoordsUSA;
  late UTMCoordinates utmCoordsNetherlands;
  late UTMCoordinates utmCoordsAustralia;

  // Sets coordinates in the four quadrants of the globe
  setUpAll(() async {
    utmCoordsBrazil = UTMCoordinates(
      x: 236379,
      y: 7702067,
      zoneNumber: 24,
      isSouthernHemisphere: true,
    );

    utmCoordsUSA = UTMCoordinates(
      x: 502663,
      y: 4978888,
      zoneNumber: 15,
    );

    utmCoordsNetherlands = UTMCoordinates(
      x: 645263,
      y: 5773215,
      zoneNumber: 31,
    );

    utmCoordsAustralia = UTMCoordinates(
      x: 334718,
      y: 6250690,
      zoneNumber: 56,
      isSouthernHemisphere: true,
    );
  });
  group('FromUTMConverter - Test in Alegre|ES|Brazil', () {
    test('convertUTMtoDD returns correct DDCoordinates', () {
      final result = FromUTMConverter.convertUTMtoDD(utmCoordsBrazil);

      expect(result.latitude, closeTo(-20.762535, 0.0001));
      expect(result.longitude, closeTo(-41.531941, 0.0001));
    });

    test('convertUTMtoDMS returns correct DMSCoordinates', () {
      final result = FromUTMConverter.convertUTMtoDMS(utmCoordsBrazil);

      expect(result.latDegrees, 20);
      expect(result.latMinutes, 45);
      expect(result.latSeconds, closeTo(45.12, 0.1));
      expect(result.latDirection, DirectionY.south);
      expect(result.longDegrees, 41);
      expect(result.longMinutes, 31);
      expect(result.longSeconds, closeTo(54.98, 0.1));
      expect(result.longDirection, DirectionX.west);
    });
  });

  group('FromUTMConverter - Test in Oakdale|MN|USA', () {
    test('convertUTMtoDD returns correct DDCoordinates', () {
      final result = FromUTMConverter.convertUTMtoDD(utmCoordsUSA);

      expect(result.latitude, closeTo(44.963433, 0.0001));
      expect(result.longitude, closeTo(-92.966224, 0.0001));
    });

    test('convertUTMtoDMS returns correct DMSCoordinates', () {
      final result = FromUTMConverter.convertUTMtoDMS(utmCoordsUSA);

      expect(result.latDegrees, 44);
      expect(result.latMinutes, 57);
      expect(result.latSeconds, closeTo(48.35, 0.1));
      expect(result.latDirection, DirectionY.north);
      expect(result.longDegrees, 92);
      expect(result.longMinutes, 57);
      expect(result.longSeconds, closeTo(58.40, 0.1));
      expect(result.longDirection, DirectionX.west);
    });
  });

  group('FromUTMConverter - Test in Utrecht|UT|Netherlands', () {
    test('convertUTMtoDD returns correct DDCoordinates', () {
      final result = FromUTMConverter.convertUTMtoDD(utmCoordsNetherlands);

      expect(result.latitude, closeTo(52.090413, 0.0001));
      expect(result.longitude, closeTo(5.120372, 0.0001));
    });

    test('convertUTMtoDMS returns correct DMSCoordinates', () {
      final result = FromUTMConverter.convertUTMtoDMS(utmCoordsNetherlands);

      expect(result.latDegrees, 52);
      expect(result.latMinutes, 5);
      expect(result.latSeconds, closeTo(25.48, 0.1));
      expect(result.latDirection, DirectionY.north);
      expect(result.longDegrees, 5);
      expect(result.longMinutes, 7);
      expect(result.longSeconds, closeTo(13.33, 0.1));
      expect(result.longDirection, DirectionX.east);
    });
  });

  group('FromUTMConverter - Test in Sydney|NSW|Australia', () {
    test('convertUTMtoDD returns correct DDCoordinates', () {
      final result = FromUTMConverter.convertUTMtoDD(utmCoordsAustralia);

      expect(result.latitude, closeTo(-33.871180, 0.0001));
      expect(result.longitude, closeTo(151.213028, 0.0001));
    });

    test('convertUTMtoDMS returns correct DMSCoordinates', () {
      final result = FromUTMConverter.convertUTMtoDMS(utmCoordsAustralia);

      expect(result.latDegrees, 33);
      expect(result.latMinutes, 52);
      expect(result.latSeconds, closeTo(16.24, 0.1));
      expect(result.latDirection, DirectionY.south);
      expect(result.longDegrees, 151);
      expect(result.longMinutes, 12);
      expect(result.longSeconds, closeTo(46.90, 0.1));
      expect(result.longDirection, DirectionX.east);
    });
  });
}
