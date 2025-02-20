import 'package:coordinate_converter/coordinate_converter.dart';
import 'package:coordinate_converter/src/math/from_dms_converter.dart';
import 'package:test/test.dart';

void main() {
  late DMSCoordinates dmsCoordsBrazil;
  late DMSCoordinates dmsCoordsUSA;
  late DMSCoordinates dmsCoordsNetherlands;
  late DMSCoordinates dmsCoordsAustralia;

  // Sets coordinates in the four quadrants of the globe
  setUpAll(() async {
    dmsCoordsBrazil = DMSCoordinates(
      latDegrees: 20,
      latMinutes: 45,
      latSeconds: 45.12,
      latDirection: DirectionY.south,
      longDegrees: 41,
      longMinutes: 31,
      longSeconds: 54.98,
      longDirection: DirectionX.west,
    );

    dmsCoordsUSA = DMSCoordinates(
      latDegrees: 44,
      latMinutes: 57,
      latSeconds: 48.35,
      latDirection: DirectionY.north,
      longDegrees: 92,
      longMinutes: 57,
      longSeconds: 58.40,
      longDirection: DirectionX.west,
    );

    dmsCoordsNetherlands = DMSCoordinates(
      latDegrees: 52,
      latMinutes: 5,
      latSeconds: 25.48,
      latDirection: DirectionY.north,
      longDegrees: 5,
      longMinutes: 7,
      longSeconds: 13.33,
      longDirection: DirectionX.east,
    );

    dmsCoordsAustralia = DMSCoordinates(
      latDegrees: 33,
      latMinutes: 52,
      latSeconds: 16.24,
      latDirection: DirectionY.south,
      longDegrees: 151,
      longMinutes: 12,
      longSeconds: 46.90,
      longDirection: DirectionX.east,
    );
  });
  group('FromDMSConverter - Test in Alegre|ES|Brazil', () {
    test('convertDMStoDD returns correct DDCoordinates', () {
      final result = FromDMSConverter.convertDMStoDD(dmsCoordsBrazil);

      expect(result.latitude, closeTo(-20.762535, 0.0001));
      expect(result.longitude, closeTo(-41.531941, 0.0001));
    });

    test('convertDMStoUTM returns correct UTMCoordinates', () {
      final result = FromDMSConverter.convertDMStoUTM(dmsCoordsBrazil);

      expect(result.x, closeTo(236379.0, 1));
      expect(result.y, closeTo(7702067.0, 1));
      expect(result.zoneNumber, 24);
      expect(result.isSouthernHemisphere, true);
    });
  });

  group('FromDMSConverter - Test in Oakdale|MN|USA', () {
    test('convertDMStoDD returns correct DDCoordinates', () {
      final result = FromDMSConverter.convertDMStoDD(dmsCoordsUSA);

      expect(result.latitude, closeTo(44.963433, 0.0001));
      expect(result.longitude, closeTo(-92.966224, 0.0001));
    });

    test('convertDMStoUTM returns correct UTMCoordinates', () {
      final result = FromDMSConverter.convertDMStoUTM(dmsCoordsUSA);

      expect(result.x, closeTo(502663.0, 1));
      expect(result.y, closeTo(4978888.0, 1));
      expect(result.zoneNumber, 15);
      expect(result.isSouthernHemisphere, false);
    });
  });

  group('FromDMSConverter - Test in Utrecht|UT|Netherlands', () {
    test('convertDMStoDD returns correct DDCoordinates', () {
      final result = FromDMSConverter.convertDMStoDD(dmsCoordsNetherlands);

      expect(result.latitude, closeTo(52.090413, 0.0001));
      expect(result.longitude, closeTo(5.120372, 0.0001));
    });

    test('convertDMStoUTM returns correct UTMCoordinates', () {
      final result = FromDMSConverter.convertDMStoUTM(dmsCoordsNetherlands);

      expect(result.x, closeTo(645263.0, 1));
      expect(result.y, closeTo(5773215.0, 1));
      expect(result.zoneNumber, 31);
      expect(result.isSouthernHemisphere, false);
    });
  });

  group('FromDMSConverter - Test in Sydney|NSW|Australia', () {
    test('convertDMStoDD returns correct DDCoordinates', () {
      final result = FromDMSConverter.convertDMStoDD(dmsCoordsAustralia);

      expect(result.latitude, closeTo(-33.871180, 0.0001));
      expect(result.longitude, closeTo(151.213028, 0.0001));
    });

    test('convertDMStoUTM returns correct UTMCoordinates', () {
      final result = FromDMSConverter.convertDMStoUTM(dmsCoordsAustralia);

      expect(result.x, closeTo(334718.0, 1));
      expect(result.y, closeTo(6250690.0, 1));
      expect(result.zoneNumber, 56);
      expect(result.isSouthernHemisphere, true);
    });
  });
}
