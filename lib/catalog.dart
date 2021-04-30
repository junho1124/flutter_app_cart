import 'package:flutter/material.dart';
import 'package:flutter_app_cart/bloc/cart_bloc.dart';
import 'package:flutter_app_cart/bloc/cart_provider.dart';
import 'package:flutter_app_cart/cart.dart';
import 'package:flutter_app_cart/item.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  @override
  Widget build(BuildContext context) {
  CartBloc cartBloc = CartProvider.of(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('catalog'),
          actions: [
            IconButton(
                icon: Icon(Icons.archive),
                onPressed: () {
                Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => Cart()));
                }
                )
          ],
        ),
        body: StreamBuilder<List<Item>>(
                stream: cartBloc.cartList,
                builder: (context, snapshot) {
                  return Center(
                    child: ListView(
                      children: cartBloc.itemList
                          .map((item) => _buildItem(item, snapshot.data, cartBloc))
                          .toList(),
                    ),
                  );
                }
                ),
    );
  }

  Widget _buildItem(Item todo, List<Item> state, CartBloc cartBloc) {
    final isChecked = state == null ? false : state.contains(todo);

    return Padding(
      child: ListTile(
        title: Text(
          todo.title,
          style: TextStyle(fontSize: 31.0),
        ),
        subtitle: Text('${todo.price}'),
        trailing: IconButton(
          icon: isChecked
              ? Icon(
                  Icons.check,
                  color: Colors.red,
                )
              : Icon(Icons.check),
          onPressed: () {
              if (isChecked) {
                cartBloc.add(CartEvent(CartEventType.remove, todo));
              } else {
                cartBloc.add(CartEvent(CartEventType.add, todo));
              }
          },
        ),
      ),
      padding: const EdgeInsets.all(8.0),
    );
  }
}
