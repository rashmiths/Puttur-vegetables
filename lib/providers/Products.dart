import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:puttur_vegetables/providers/Product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  Products(this._items);

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts(String type) async {
    var url =
        'https://putturvegetables-6e0d7.firebaseio.com/type/$type/${type}List.json';
    print(url);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(extractedData);
      print(extractedData);
      if (extractedData == null) {
        return;
      }

      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'] ?? 'No Title',
          availability: prodData['availability'] ?? true,
          price: prodData['price'] ?? 0,
          imageUrl: prodData['imageUrl']==null || prodData['imageUrl']=='.'?
              'https://images.unsplash.com/photo-1487260211189-670c54da558d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80':prodData['imageUrl']
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
