/// The [dart:async] is neccessary for using streams
import 'dart:async';

class CartItemsBloc {
  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;

  final Map allItems = {
    'shop items': [
      {'name': 'Paracetamol', 'price': 10, 'id': 1},
      {'name': 'Ibuprofeno', 'price': 50, 'id': 2},
      {'name': 'Salicilato de metilo', 'price': 60, 'id': 3},
      {'name': 'weso', 'price': 999, 'id': 4},
      {'name': 'weso2', 'price': 9999, 'id': 5},
      {'name': 'Snack', 'price': 110, 'id': 6},
      {'name': 'Juguete xD', 'price': 130, 'id': 7},
      {'name': 'Cubo Rubik', 'price': 502, 'id': 8},
      {'name': 'Taza de comida', 'price': 90, 'id': 9},
      {'name': 'Playera perruna', 'price': 60, 'id': 10},
      {'name': 'Pantalones Perrunos', 'price': 72, 'id': 11},
      {'name': 'Mayonesa', 'price': 20, 'id': 12},
      {'name': 'Shampoo antipulgas', 'price': 201, 'id': 13},
    ],
    'cart items': []
  };

  void addToCart(item) {
    allItems['shop items'].remove(item);
    allItems['cart items'].add(item);
    cartStreamController.sink.add(allItems);
  }

  void removeFromCart(item) {
    allItems['cart items'].remove(item);
    allItems['shop items'].add(item);
    cartStreamController.sink.add(allItems);
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final bloc = CartItemsBloc();
