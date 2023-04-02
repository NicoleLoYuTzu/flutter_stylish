import 'package:flutter/cupertino.dart';

class Product {
  final String title;
  final AssetImage image;
  final int price;

  Product({required this.title, required this.image, required this.price});
}

class ProductCategory {
  final String category;
  final List<Product> products;

  ProductCategory({required this.category, required this.products});
}

class ProductList {
  final String productStyle;
  final AssetImage image;
  final String productName;
  final int price;

  ProductList(
      {required this.productStyle,
        required this.image,
        required this.productName,
        required this.price});
}