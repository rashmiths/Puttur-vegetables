import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:puttur_vegetables/providers/ProductType.dart';
import 'package:http/http.dart' as http;

class ProductTypes with ChangeNotifier {
  List<ProductType> _productTypes = [];
  ProductTypes(this._productTypes);

  List<ProductType> get productTypes {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._productTypes];
  }

  ProductType findById(String id) {
    return _productTypes.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    var url = 'https://putturvegetables-6e0d7.firebaseio.com/type.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      final List<ProductType> loadedProductTypes = [];
      extractedData.forEach((prodId, prodData) {
        loadedProductTypes.add(ProductType(
          id: prodId,
          title: prodData['title'] ?? 'Title Not Available',
          imageUrl: prodData['imageUrl'] ??
              'https://images.unsplash.com/photo-1487260211189-670c54da558d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
        ));
      });
      _productTypes = loadedProductTypes;
      notifyListeners();
    } on SocketException {
      throw 'NO INTERNET';
    } catch (error) {
      print('#####');
      throw (error);
    }
  }
}
