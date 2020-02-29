import 'package:BarTinder/model/inventory_item.dart';

class CartProvider {
  List<InventoryItem> items = [];

  List<InventoryItem> add(InventoryItem item) {
    bool isPresent = false;

    if (items.length > 0) {
      for (int i = 0; i < items.length; i++) {
        if (items[i].id == item.id) {
          increaseItemQuantity(item);
          isPresent = true;
          break;
        } else {
          isPresent = false;
        }
      }

      if (!isPresent) {
        items.add(item);
      }
    } else {
      items.add(item);
    }

    return items;
  }

  List<InventoryItem> remove(InventoryItem item) {
    if (item.quantity > 1) {
      decreaseItemQuantity(item);
    } else {
      items.remove(item);
    }
    return items;
  }

  void increaseItemQuantity(InventoryItem foodItem) => foodItem.incrementQuantity();
  void decreaseItemQuantity(InventoryItem foodItem) => foodItem.decrementQuantity();
}