import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:puttur_vegetables/providers/cart.dart';
part 'orders.g.dart';

@HiveType(typeId: 0)
class OrderItem {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final num amount;
  @HiveField(2)
  final List<CartItem> products;
  @HiveField(3)
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  Orders(this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    // final url = 'https://shop-a6fb5.firebaseio.com/orders/$userid.json';
    // final response = await http.get(url);
    // final List<OrderItem> loadedOrders = [];
    // final extractedData = json.decode(response.body) as Map<String, dynamic>;
    // if (extractedData == null) {
    //   return;
    // }
    // extractedData.forEach((orderId, orderData) {
    //   loadedOrders.add(
    //     OrderItem(
    //       id: orderId,
    //       amount: orderData['amount'],
    //       dateTime: DateTime.parse(orderData['dateTime']),
    //       products: (orderData['products'] as List<dynamic>)
    //           .map(
    //             (item) => CartItem(
    //               id: item['id'],
    //               price: item['price'],
    //               quantity: item['quantity'],
    //               title: item['title'],
    //             ),
    //           )
    //           .toList(),
    //     ),
    //   );
    // });

    var box = await Hive.openBox<dynamic>('cart');
    final List<OrderItem> loadedOrders =
        Hive.box('cart').values.toList().cast<OrderItem>();

    _orders = loadedOrders;
    notifyListeners();
  }

  Future<void> addOrder(List<CartItem> cartProducts, num total) async {
    final toStoreInHive = OrderItem(
      id: DateTime.now().toString(),
      amount: total,
      products: cartProducts,
      dateTime: DateTime.now(),
    );
    // final url = 'https://shop-a6fb5.firebaseio.com//orders/$userid.json';
    // final timestamp = DateTime.now();
    // final response = await http.post(
    //   url,
    //   body: json.encode({
    //     'amount': total,
    //     'dateTime': timestamp.toIso8601String(),
    //     'products': cartProducts
    //         .map((cp) => {
    //               'id': cp.id,
    //               'title': cp.title,
    //               'quantity': cp.quantity,
    //               'price': cp.price,
    //             })
    //         .toList(),
    //   }),
    // );
    // _orders.insert(
    //   0,
    //   OrderItem(
    //     id: json.decode(response.body)['name'],
    //     amount: total,
    //     dateTime: timestamp,
    //     products: cartProducts,
    //   ),
    // );

    Hive.openBox<dynamic>('cart').then((box) {
      box.put(toStoreInHive.id, toStoreInHive);
    });

    notifyListeners();
  }
}
