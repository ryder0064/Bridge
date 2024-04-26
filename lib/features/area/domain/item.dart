class Item {
  const Item({
    required this.id,
    required this.areaCode,
    required this.name,
    required this.longitude,
    required this.latitude,
  });

  final int id;
  final int areaCode;
  final String name;
  final double longitude;
  final double latitude;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'areaCode': areaCode,
      'name': name,
      'longitude': longitude,
      'latitude': latitude,
    };
  }

  factory Item.fromJson(Map<String, dynamic> map) {
    return Item(
      id: map['id'] as int,
      areaCode: map['areaCode'] as int,
      name: map['name'] as String,
      longitude: map['longitude'] as double,
      latitude: map['latitude'] as double,
    );
  }
}
