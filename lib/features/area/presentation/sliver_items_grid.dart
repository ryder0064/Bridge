import 'dart:math';

import 'package:bridge/constants/app_sizes.dart';
import 'package:bridge/constants/breakpoints.dart';
import 'package:bridge/features/area/domain/item.dart';
import 'package:bridge/features/area/presentation/item_card.dart';
import 'package:bridge/features/area/presentation/item_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SliverItemsGrid extends StatelessWidget {
  const SliverItemsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemController, List<Item>>(
      builder: (context, itemsList) => SliverProductsAlignedGrid(
        itemCount: itemsList.length,
        itemBuilder: (_, index) {
          return ItemCard(
            item: itemsList[index],
          );
        },
      ),
    );
  }
}

class SliverProductsAlignedGrid extends StatelessWidget {
  const SliverProductsAlignedGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  /// Total number of items to display.
  final int itemCount;

  /// Function used to build a widget for a given index in the grid.
  final Widget Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            'No items found',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      );
    }
    // use a LayoutBuilder to determine the crossAxisCount
    return SliverLayoutBuilder(builder: (context, constraints) {
      final width = constraints.crossAxisExtent;
      final maxWidth = min(width, Breakpoint.desktop);
      final crossAxisCount = max(1, maxWidth ~/ 250);
      final padding = width > Breakpoint.desktop + Sizes.p32
          ? (width - Breakpoint.desktop) / 2
          : Sizes.p16;
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: Sizes.p16),
        sliver: SliverAlignedGrid.count(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: Sizes.p24,
          crossAxisSpacing: Sizes.p24,
          itemBuilder: itemBuilder,
          itemCount: itemCount,
        ),
      );
    });
  }
}
