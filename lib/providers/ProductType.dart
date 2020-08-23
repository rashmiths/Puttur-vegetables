import 'package:flutter/cupertino.dart';

class ProductType with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  ProductType({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });
}
