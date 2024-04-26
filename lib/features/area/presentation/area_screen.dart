import 'package:bridge/common_widget/responsive_center.dart';
import 'package:bridge/constants/app_sizes.dart';
import 'package:bridge/features/area/domain/item.dart';
import 'package:bridge/features/area/presentation/item_controller.dart';
import 'package:bridge/features/area/presentation/items_search_text_field.dart';
import 'package:bridge/features/area/presentation/sliver_items_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AreaScreen extends StatefulWidget {
  const AreaScreen({super.key, required this.code, required this.itemList});

  final List<Item> itemList;
  final String code;

  @override
  State<StatefulWidget> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<AreaScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ItemController(widget.itemList),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bridges & Tunnels'),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: const [
            ResponsiveSliverCenter(
              padding: EdgeInsets.all(Sizes.p16),
              child: ItemsSearchTextField(),
            ),
            SliverItemsGrid(),
          ],
        ),
      ),
    );
  }
}
