/// Decimal Degrees - DD coordinates object.
class DDCoordinates {
  /// constructor
  DDCoordinates({required this.latitude, required this.longitude});

  /// Latitude in decimal degrees [double].
  double latitude;

  /// Longitude in decimal degrees [double].
  double longitude;

  /// Returns boths coordinates in [String].
  @override
  String toString() {
    return '$latitude, $longitude';
  }
}
