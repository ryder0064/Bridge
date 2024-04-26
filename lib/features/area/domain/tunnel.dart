import 'package:bridge/features/area/domain/item.dart';

class Tunnel extends Item {
  Tunnel({
    required super.id,
    required super.areaCode,
    required super.name,
    required super.longitude,
    required super.latitude,
  });

  factory Tunnel.fromJson(Map<String, dynamic> json) {
    return Tunnel(
      id: json['ID'],
      areaCode: json['AreaCode'],
      name: json['tunnel_name'],
      longitude: json['Obj_Longitude'],
      latitude: json['Obj_Latitude'],
    );
  }

  @override
  String toString() {
    return 'Tunnel{id: $id, areaCode: $areaCode, name: $name, longitude: $longitude, latitude: $latitude}';
  }
}
