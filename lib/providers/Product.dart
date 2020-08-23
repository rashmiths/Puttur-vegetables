import 'package:flutter/cupertino.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final bool availability;
  final num price;
  final String imageUrl;

  Product({
    @required this.id,
    @required this.title,
    @required this.availability,
    @required this.price,
    @required this.imageUrl,
  });
}
