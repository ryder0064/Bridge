import 'item.dart';

class Bridge extends Item {
  Bridge({
    required super.id,
    required super.areaCode,
    required super.name,
    required super.longitude,
    required super.latitude,
  });

  factory Bridge.fromJson(Map<String, dynamic> json) {
    return Bridge(
      id: json['ID'],
      areaCode: json['AreaCode'],
      name: json['bridge_name'],
      longitude: json['Obj_Longitude'],
      latitude: json['Obj_Latitude'],
    );
  }

  @override
  String toString() {
    return 'Bridge{id: $id, areaCode: $areaCode, name: $name, longitude: $longitude, latitude: $latitude}';
  }
}
