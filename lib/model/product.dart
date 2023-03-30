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