import 'package:bridge/constants/app_sizes.dart';
import 'package:bridge/features/area/domain/item.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Divider(),
              gapH8,
              Text(item.name, style: Theme.of(context).textTheme.titleLarge),
              gapH24,
              Text("longitude: ${item.longitude}",
                  style: Theme.of(context).textTheme.headlineSmall),
              gapH4,
              Text("latitude: ${item.latitude}",
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}
