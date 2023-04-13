import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/product.dart';

Future<List<ProductList>> fetchHotProductList() async {
  const String hostName = 'api.appworks-school.tw';
  const String apiVersion = '1.0';
  const String endpoint = '/marketing/hots';

  final response =
      await http.get(Uri.https(hostName, '/api/$apiVersion$endpoint'));
  print('Uri : ${Uri.https(hostName, '/api/$apiVersion$endpoint')}');

  if (response.statusCode == 200) {
    List<ProductList> productLists = [];

    var jsonData = jsonDecode(response.body);
    var data = jsonData['data'];

    for (var item in data) {
      for (var product in item['products']) {
        ProductList productList = ProductList(
            productStyle: product['category'],
            image: NetworkImage(product['images'][0]),
            productName: product['title'],
            price: product['price']);
        productLists.add(productList);
      }
    }
    print('response : ${response.statusCode}');

    for (var productList in productLists) {
      print('Product Style: ${productList.productStyle}');
      print('Product Name: ${productList.productName}');
      print('Price: ${productList.price}');
      // 如果 image 是 NetworkImage，則需透過 resolve 方法取得其網址後印出
      if (productList.image is NetworkImage) {
        print(
            'Image URL: ${(productList.image as NetworkImage).resolve(ImageConfiguration()).toString()}');
      } else {
        print('Image: ${productList.image}');
      }
      print('\n');
    }

    return productLists;
  } else {
    throw Exception('Failed to load product list');
  }
}
