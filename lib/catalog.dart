import 'package:flutter/material.dart';
import 'package:flutter_app_cart/bloc/cart_bloc.dart';
import 'package:flutter_app_cart/cart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app_cart/item.dart';

class Catalog extends StatefulWidget {
  @override
  _CatalogState createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  List<Item> _itemList = itemList;

  @override
  Widget build(BuildContext context) {
    final _cartBloc = BlocProvider.of<CartBloc>(context);

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
        body: BlocBuilder<CartBloc, List<Item>>(
          bloc: _cartBloc,
          builder: (BuildContext context, List state) {
            return Center(
              child: ListView(
                children: _itemList
                    .map((item) => _buildItem(item, state, _cartBloc))
                    .toList(),
              ),
            );
          },
        ));
  }

  Widget _buildItem(Item todo, List state, CartBloc bloc) {
    final isChecked = state.contains(todo);

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
            setState(() {
              if (isChecked) {
                bloc.add(CartEvent(CartEventType.remove, todo));
              } else {
                bloc.add(CartEvent(CartEventType.add, todo));
              }
            });
          },
        ),
      ),
      padding: const EdgeInsets.all(8.0),
    );
  }
}
