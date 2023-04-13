import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/product.dart';

Future<List<ProductList>> fetchProductList() async {
  final String hostName = 'api.appworks-school.tw';
  final String apiVersion = '1.0';
  final String endpoint = '/marketing/campaigns';

  final response = await http.get(Uri.https(hostName, '/api/$apiVersion$endpoint'));

  if (response.statusCode == 200) {
    List<ProductList> productLists = [];

    var jsonData = jsonDecode(response.body);
    var data = jsonData['data'];

    for (var item in data) {
      ProductList productList = ProductList(
          productStyle: item['productStyle'],
          image: NetworkImage(item['image']),
          productName: item['productName'],
          price: item['price']);

      productLists.add(productList);
    }

    return productLists;
  } else {
    throw Exception('Failed to load product list');
  }
}
