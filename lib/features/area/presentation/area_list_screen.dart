import 'dart:convert';

import 'package:bridge/features/area/data/area_repository.dart';
import 'package:bridge/features/area/domain/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../main.dart';

class AreaListScreen extends StatelessWidget {
  const AreaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = BlocProvider.of<AreaRepository>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bridges & Tunnels'),
      ),
      body: BlocBuilder<AreaRepository, Map<int, List<Item>>>(
        builder: (context, areaList) {
          if (areaList.isEmpty) {
            repository.groupDataByAreaCode();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: areaList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("AreaCode: ${areaList.keys.elementAt(index)}"),
                  trailing: const Icon(
                    Icons.arrow_forward_rounded,
                  ),
                  shape: const Border(
                    bottom: BorderSide(),
                  ),
                  onTap: () {
                    List<Item> a = areaList.values.elementAt(index);
                    String itemListJson =
                        jsonEncode(a.map((item) => item.toJson()).toList());
                    context.goNamed(AppRoute.area.name, queryParameters: {
                      'list': jsonEncode(itemListJson)
                    }, pathParameters: {
                      'code': areaList.keys.elementAt(index).toString(),
                    });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
