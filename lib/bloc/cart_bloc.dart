import 'package:flutter_app_cart/item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

enum CartEventType {
  add, remove
}

class CartEvent {
  final CartEventType type;
  final Item item;

  CartEvent(this.type, this.item);
}

class CartBloc extends Bloc<CartEvent  , List<Item>> {
  CartBloc() : super([]);

  @override
  Stream<List<Item>> mapEventToState(CartEvent event) async* { // stream 형태로 방출 할거다.
    switch (event.type) {
      case CartEventType.add:
        state.add(event.item);
        break;
      case CartEventType.remove:
        state.remove(event.item);
        break;
    }
    yield state; //
  }
}