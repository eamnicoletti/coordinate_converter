/// Direction for the latitude
enum DirectionY {
  north('N'),
  south('S');

  const DirectionY(this.abbreviation);

  final String abbreviation;
}

/// Direction for the longitude
enum DirectionX {
  east('E'),
  west('W');

  const DirectionX(this.abbreviation);

  final String abbreviation;
}
