import 'package:flutter/widgets.dart';
import 'package:flutter_app_cart/bloc/cart_bloc.dart';

class CartProvider extends InheritedWidget {
  final CartBloc cartBloc;

  CartProvider({Key key, CartBloc cartBloc, Widget child})
      : cartBloc = cartBloc ?? CartBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static CartBloc of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<CartProvider>().cartBloc;
}
