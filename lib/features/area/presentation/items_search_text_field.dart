import 'package:bridge/features/area/presentation/item_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemsSearchTextField extends StatefulWidget {
  const ItemsSearchTextField({super.key});

  @override
  State<ItemsSearchTextField> createState() =>
      _ItemsSearchTextFieldState();
}

class _ItemsSearchTextFieldState extends State<ItemsSearchTextField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: _controller,
      builder: (context, value, _) {
        return TextField(
            controller: _controller,
            autofocus: false,
            style: Theme.of(context).textTheme.titleLarge,
            decoration: InputDecoration(
              hintText: 'Search items',
              icon: const Icon(Icons.search),
              suffixIcon: value.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        _controller.clear();
                        BlocProvider.of<ItemController>(context).clearSearch();
                      },
                      icon: const Icon(Icons.clear),
                    )
                  : null,
            ),
            onChanged: (text) =>
                BlocProvider.of<ItemController>(context).searchItems(text));
      },
    );
  }
}
