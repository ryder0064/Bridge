import 'package:bridge/features/area/domain/item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemController extends Cubit<List<Item>> {
  ItemController(this.itemList) : super(itemList);
  final List<Item> itemList;

  void searchItems(String query) async {
    emit(itemList.where((item) => item.name.contains(query)).toList());
  }

  void clearSearch() {
    emit(itemList);
  }
}
