class Transporter {
  double searchScore;
  String transporterId;
  String transporterName;
  String logo;

  Transporter({
    required this.searchScore,
    required this.transporterId,
    required this.transporterName,
    required this.logo,
  });

  // Convert the object to a Map
  Map<String, dynamic> toMap() {
    return {
      '@search.score': searchScore,
      'transporter_id': transporterId,
      'transporter_name': transporterName,
      'logo': logo,
    };
  }

  // Create an object from a Map
  factory Transporter.fromMap(Map<String, dynamic> map) {
    return Transporter(
      searchScore: map['@search.score'],
      transporterId: map['transporter_id'],
      transporterName: map['transporter_name'],
      logo: map['logo'],
    );
  }
}
