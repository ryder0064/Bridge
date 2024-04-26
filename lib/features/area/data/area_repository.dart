import 'dart:convert';

import 'package:bridge/features/area/domain/bridge.dart';
import 'package:bridge/features/area/domain/item.dart';
import 'package:bridge/features/area/domain/tunnel.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class AreaRepository extends Cubit<Map<int, List<Item>>> {
  AreaRepository() : super({});

  void groupDataByAreaCode() async {
    final List<Item> bridges = await _fetchBridges();
    final List<Item> tunnels = await _fetchTunnels();
    final List<Item> result = [];
    result.addAll(bridges);
    result.addAll(tunnels);
    emit(groupBy(result, (item) => item.areaCode));
  }

  Future<List<Item>> _fetchBridges() async {
    final response = await http.get(
        Uri.parse('https://tpnco.blob.core.windows.net/blobfs/Bridges.json'));
    if (response.statusCode == 200) {
      Utf8Decoder decode = const Utf8Decoder();
      final List<dynamic> data =
          json.decode(decode.convert(response.bodyBytes));
      return data.map((json) => Bridge.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load bridge data');
    }
  }

  Future<List<Item>> _fetchTunnels() async {
    final response = await http.get(
        Uri.parse('https://tpnco.blob.core.windows.net/blobfs/Tunnels.json'));
    if (response.statusCode == 200) {
      Utf8Decoder decode = const Utf8Decoder();
      final List<dynamic> data =
          json.decode(decode.convert(response.bodyBytes));
      return data.map((json) => Tunnel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tunnel data');
    }
  }
}
