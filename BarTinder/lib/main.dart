import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:BarTinder/bloc/listTileColorBloc.dart';
import 'bloc/cartlistBloc.dart';
import 'view/cart.dart';
import 'const/themeColor.dart';
import 'model/inventory_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => CartListBloc()),
        Bloc((i) => ColorBloc()),
      ],
      child: MaterialApp(
        title: "BarTinder",
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: ListView(
          children: <Widget>[
            FirstHalf(),
            SizedBox(height: 45),
            for (var foodItem in inventoryItems.items)
              Builder(
                builder: (context) {
                  return ItemContainer(item: foodItem);
                },
              )
          ],
        ),
      )),
    );
  }
}

class ItemContainer extends StatelessWidget {
  ItemContainer({
    @required this.item,
  });

  final InventoryItem item;
  final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();

  add(InventoryItem item) {
    bloc.add(item);
  }

  remove(InventoryItem item) {
    bloc.remove(item);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        add(item);
        final snackBar = SnackBar(
          content: Text('${item.name} added to Cart'),
          duration: Duration(milliseconds: 550),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      },
      child: Items(
        itemName: item.name,
        itemPrice: item.price,
        imgUrl: item.imgUrl,
        leftAligned: (item.id % 2) == 0 ? true : false,
      ),
    );
  }
}

class FirstHalf extends StatelessWidget {
  const FirstHalf({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 25, 0, 0),
      child: Column(
        children: <Widget>[
          CustomAppBar(),
          // title(),
          // searchBar(),
          // SizedBox(height: 45),
          // categories(),
        ],
      ),
    );
  }
}

// Widget categories() {
//   return Container(
//     height: 185,
//     child: ListView(
//       scrollDirection: Axis.horizontal,
//       children: <Widget>[
//         CategoryListItem(
//           categoryIcon: Icons.bug_report,
//           categoryName: "Burgers",
//           availability: 12,
//           selected: true,
//         ),
//         CategoryListItem(
//           categoryIcon: Icons.bug_report,
//           categoryName: "Pizza",
//           availability: 12,
//           selected: false,
//         ),
//         CategoryListItem(
//           categoryIcon: Icons.bug_report,
//           categoryName: "Rolls",
//           availability: 12,
//           selected: false,
//         ),
//         CategoryListItem(
//           categoryIcon: Icons.bug_report,
//           categoryName: "Burgers",
//           availability: 12,
//           selected: false,
//         ),
//         CategoryListItem(
//           categoryIcon: Icons.bug_report,
//           categoryName: "Burgers",
//           availability: 12,
//           selected: false,
//         ),
//       ],
//     ),
//   );
// }

class Items extends StatelessWidget {
  Items({
    @required this.leftAligned,
    @required this.imgUrl,
    @required this.itemName,
    @required this.itemPrice,
  });

  final bool leftAligned;
  final String imgUrl;
  final String itemName;
  final double itemPrice;

  @override
  Widget build(BuildContext context) {
    double containerPadding = 45;
    double containerBorderRadius = 10;

    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            left: leftAligned ? 0 : containerPadding,
            right: leftAligned ? containerPadding : 0,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: ClipRRect(
                  borderRadius: BorderRadius.horizontal(
                    left: leftAligned
                        ? Radius.circular(0)
                        : Radius.circular(containerBorderRadius),
                    right: leftAligned
                        ? Radius.circular(containerBorderRadius)
                        : Radius.circular(0),
                  ),
                  child: Image.network(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                  padding: EdgeInsets.only(
                    left: leftAligned ? 20 : 0,
                    right: leftAligned ? 0 : 20,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(itemName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  )),
                            ),
                            Text("\$$itemPrice",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black45, fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(height: containerPadding),
                      ])),
            ],
          ),
        )
      ],
    );
  }
}

class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    Key key,
    @required this.categoryIcon,
    @required this.categoryName,
    @required this.availability,
    @required this.selected,
  }) : super(key: key);

  final IconData categoryIcon;
  final String categoryName;
  final int availability;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: selected ? Themes.color : Colors.white,
        border: Border.all(
            color: selected ? Colors.transparent : Colors.grey[200],
            width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[100],
            blurRadius: 15,
            offset: Offset(15, 0),
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(
                    color: selected ? Colors.transparent : Colors.grey[200],
                    width: 1.5)),
            child: Icon(
              categoryIcon,
              color: Colors.black,
              size: 30,
            ),
          ),
          SizedBox(height: 10),
          Text(
            categoryName,
            style: TextStyle(
                fontWeight: FontWeight.w700, color: Colors.black, fontSize: 15),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 6, 0, 10),
            width: 1.5,
            height: 15,
            color: Colors.black26,
          ),
          Text(
            availability.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}

// Widget searchBar() {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Icon(
//         Icons.search,
//         color: Colors.black45,
//       ),
//       SizedBox(width: 20),
//       Expanded(
//         child: TextField(
//           decoration: InputDecoration(
//               hintText: "Search....",
//               contentPadding: EdgeInsets.symmetric(vertical: 10),
//               hintStyle: TextStyle(
//                 color: Colors.black87,
//               ),
//               border: UnderlineInputBorder(
//                   borderSide: BorderSide(color: Colors.red))),
//         ),
//       ),
//     ],
//   );
// }

Widget title() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      SizedBox(width: 45),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "BarTinder",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 30,
            ),
          ),
        ],
      )
    ],
  );
}

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartListBloc bloc = BlocProvider.getBloc<CartListBloc>();
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(Icons.menu),
          title(),
          StreamBuilder(
            stream: bloc.listStream,
            builder: (context, snapshot) {
              List<InventoryItem> foodItems = snapshot.data;
              int length = foodItems != null ? foodItems.length : 0;

              return buildGestureDetector(length, context, foodItems);
            },
          )
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(
      int length, BuildContext context, List<InventoryItem> items) {
    return GestureDetector(
      onTap: () {
        if (length > 0) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Cart()));
        } else {
          return;
        }
      },
      child: Container(
        margin: EdgeInsets.only(right: 30),
        child: Text(length.toString()),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.yellow[800], borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}
