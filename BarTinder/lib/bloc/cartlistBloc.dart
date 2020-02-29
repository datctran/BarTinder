import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:BarTinder/bloc/provider.dart';
import 'package:BarTinder/model/inventory_item.dart';
import 'package:rxdart/rxdart.dart';

class CartListBloc extends BlocBase {
  CartListBloc();

  var _listController = BehaviorSubject<List<InventoryItem>>.seeded([]);

  CartProvider provider = CartProvider();

  Stream<List<InventoryItem>> get listStream => _listController.stream;

  Sink<List<InventoryItem>> get listSink => _listController.sink;

  add(InventoryItem item) {
    listSink.add(provider.add(item));
  }

  remove(InventoryItem item) {
    listSink.add(provider.remove(item));
    
  }

  @override
  void dispose() {
    _listController.close();
    super.dispose();
  }
}