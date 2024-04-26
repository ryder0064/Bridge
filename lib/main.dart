import 'dart:convert';

import 'package:bridge/features/area/data/area_repository.dart';
import 'package:bridge/features/area/domain/item.dart';
import 'package:bridge/features/area/presentation/area_list_screen.dart';
import 'package:bridge/features/area/presentation/area_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  home,
  area,
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: GoRouter(initialLocation: '/', routes: [
        GoRoute(
          path: '/',
          name: AppRoute.home.name,
          builder: (context, state) => BlocProvider(
            create: (BuildContext context) => AreaRepository(),
            child: const AreaListScreen(),
          ),
          routes: [
            GoRoute(
              path: 'area/:code',
              name: AppRoute.area.name,
              builder: (context, state) {
                final Map<String, dynamic>? args = ModalRoute.of(context)
                    ?.settings
                    .arguments as Map<String, dynamic>?;
                final code = state.pathParameters['code']!;
                final String jsonString = jsonDecode(args?['list']!);
                List<dynamic> itemListDecoded = jsonDecode(jsonString);
                final List<Item> itemList = itemListDecoded
                    .map((itemJson) => Item.fromJson(itemJson))
                    .toList();

                return AreaScreen(code: code, itemList: itemList);
              },
            ),
          ],
        ),
      ]),
    );
  }
}
