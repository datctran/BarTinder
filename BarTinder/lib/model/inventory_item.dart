import 'package:flutter/foundation.dart';

class InventoryItemList {
  List<InventoryItem> items;

  InventoryItemList({@required this.items});
}

class InventoryItem {
  int id;
  String name;
  double price;
  String imgUrl;
  int quantity;

  InventoryItem({
    @required this.id,
    @required this.name,
    @required this.price,
    @required this.imgUrl,
    this.quantity = 1,
  });

  void incrementQuantity() {
    this.quantity = this.quantity + 1;
  }

  void decrementQuantity() {
    this.quantity = this.quantity - 1;
  }
}

// TODO: move to service layer
InventoryItemList inventoryItems = InventoryItemList(items: [
  InventoryItem(
    id: 1,
    name: "Cosmopolitan",
    price: 14.99,
    imgUrl: r"https://uk.thebar.com/assets/en-gb/Images/AS/cosmopolitan$$069A0000001Kj9MIAS.jpg?maxheight=360&maxwidth=540&quality=85",
  ),
  InventoryItem(
    id: 2,
    name: "Gin and Tonic",
    price: 11.99,
    imgUrl: r"https://uk.thebar.com/assets/en-gb/Images/AI/gin-and-tonic$$069A0000001gyMmIAI.jpg?maxheight=360&maxwidth=540&quality=85",
  ),
  InventoryItem(
    id: 3,
    name: "Mint Julep",
    price: 8.49,
    imgUrl: r"https://uk.thebar.com/assets/en-gb/Images/A0/37490_thebar_slices_1425x950_diageo-0937$$069A0000001RtVFIA0.jpg?maxheight=360&maxwidth=540&quality=85",
  ),
  InventoryItem(
    id: 4,
    name: "Mojito",
    price: 10.49,
    imgUrl: r"https://uk.thebar.com/assets/en-gb/Images/AS/mojito$$069A0000001Rw7WIAS.jpg?maxheight=360&maxwidth=540&quality=85",
  ),
  InventoryItem(
    id: 5,
    name: "Margarita",
    price: 14.49,
    imgUrl: r"https://uk.thebar.com/assets/en-gb/Images/AG/margarita_1425x950$$069A0000001RHpfIAG.jpg?maxheight=360&maxwidth=540&quality=85",
  ),
  InventoryItem(
    id: 6,
    name: "Strawberry Daiquiri",
    price: 12.49,
    imgUrl: r"https://uk.thebar.com/assets/en-gb/Images/AM/strawberry-daquiri$$069A0000000eCU8IAM.jpg?maxheight=360&maxwidth=540&quality=85",
  ),
]);
