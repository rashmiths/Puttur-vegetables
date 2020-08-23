import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'cart.g.dart';

@HiveType(typeId: 1)
class CartItem {
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String quantity;
  @HiveField(4)
  final num price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items =
      Hive.box('cart').toMap().cast<String, CartItem>();

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    print(_items.length.toString() + '####');
    return _items.length;
  }

  num get totalAmount {
    var total = 0.0;
    String quantity = '';
    num price = 0;
    print('################');
   
    _items.forEach((key, cartItem) {
      print(cartItem.title);
       print(cartItem.price);
      if (cartItem.quantity.contains('K')) {
        for (int i = 0; i < cartItem.quantity.length; i++) {
          if (cartItem.quantity[i] == 'K') {
            price = double.parse(quantity);
            print('##### $price');
            quantity = '';
            break;
          } else {
            quantity = quantity + cartItem.quantity[i];
          }
        }
      } else {
        for (int i = 0; i < cartItem.quantity.length; i++) {
          if (cartItem.quantity[i] == 'G') {
            price = double.parse(quantity);
            price = price * 0.001;
            quantity = '';
            break;
          } else {
            quantity = quantity + cartItem.quantity[i];
          }
        }
      }

      total += cartItem.price * price;
      // * cartItem.quantity;
    });
    return total;
  }

  void addItem(
      String productId, num price, String title, String quantity) async {
    if (_items.containsKey(productId)) {
      // change quantity...
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          id: productId,
          title: title,
          price: price,
          quantity: quantity,
        ),
      );
      final hiveItem = CartItem(
          id: productId, title: title, price: price, quantity: quantity);
      var box = await Hive.openBox('cart');
      Hive.box('cart').put(productId, hiveItem);
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: quantity,
        ),
      );
      final hiveItem = CartItem(
          id: productId, title: title, price: price, quantity: quantity);
      var box = await Hive.openBox('cart');
      Hive.box('cart').put(productId, hiveItem);
    }
    print(_items.toString());
    notifyListeners();
  }

  void removeItem(String productId) {
    var box = Hive.openBox('cart');
    Hive.box('cart').delete(productId);
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    // if (_items[productId].quantity > 1) {
    //   _items.update(
    //       productId,
    //       (existingCartItem) => CartItem(
    //             id: existingCartItem.id,
    //             title: existingCartItem.title,
    //             price: existingCartItem.price,
    //             quantity: existingCartItem.quantity - 1,
    //           ));
    // } else {
    _items.remove(productId);
    //}
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
