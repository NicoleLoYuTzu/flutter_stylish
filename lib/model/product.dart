import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

// class Product {
//   final String title;
//   final AssetImage image;
//   final int price;
//
//   Product({required this.title, required this.image, required this.price});
// }
//
// class ProductCategory {
//   final String category;
//   final List<Product> products;
//
//   ProductCategory({required this.category, required this.products});
// }
class ProductColor {
  final String code;
  final String name;

  ProductColor({required this.code, required this.name});

  factory ProductColor.fromJson(Map<String, dynamic> json) {
    return ProductColor(
      code: json['code'],
      name: json['name'],
    );
  }
}

class Variant {
  final String colorCode;
  final String size;
  final int stock;

  Variant({
    required this.colorCode,
    required this.size,
    required this.stock,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      colorCode: json['color_code'],
      size: json['size'],
      stock: json['stock'],
    );
  }
}


class ProductList {
  final int id;
  final String category;
  final String title;
  final String description;
  final int price;
  final String texture;
  final String wash;
  final String place;
  final String note;
  final String story;
  final List<ProductColor> colors;
  final List<String> sizes;
  final List<Variant> variants;
  final String mainImage;
  final List<String> images;


  ProductList({
    this.id = 0,
    this.category = '',
    this.title = '',
    this.description = '',
    this.price = 0,
    this.texture = '',
    this.wash = '',
    this.place = '',
    this.note = '',
    this.story = '',
    this.colors = const [],
    this.sizes = const [],
    this.variants = const [],
    this.mainImage = '',
    this.images = const [],
  });

  factory ProductList.fromJson(Map<String, dynamic> json) {
    List<ProductColor>? colors = [];
    if (json['colors'] != null) {
      colors = List.from(json['colors']).map((colorJson) =>
          ProductColor.fromJson(colorJson)).cast<ProductColor>().toList();
    }

    List<Variant> variants = [];
    if (json['variants'] != null) {
      variants = List.from(json['variants']).map((variantJson) =>
          Variant.fromJson(variantJson)).toList();
    }

    return ProductList(
      id: json['id'] ?? 0,
      category: json['category'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      texture: json['texture'] ?? '',
      wash: json['wash'] ?? '',
      place: json['place'] ?? '',
      note: json['note'] ?? '',
      story: json['story'] ?? '',
      colors: colors,
      sizes: List.from(json['sizes'] ?? []),
      variants: variants,
      mainImage: json['main_image'] ?? '',
      images: List.from(json['images'] ?? []),
    );
  }

}


class ImageList {
  final Image image;

  ImageList({required this.image});
}


class ProductListHots {
  final String title;
  final List<dynamic> products;

  ProductListHots({
    required this.title,
    required this.products,
  });

  factory ProductListHots.fromJson(Map<String, dynamic> json) {
    return ProductListHots(
      title: json['title'],
      products: (json['products'] as List<dynamic>)
          .map((productJson) => ProductList.fromJson(productJson))
          .toList(),
    );
  }



  Map<String, dynamic> toJson() => {
    'title': title,
    'products': products.map((product) => product.toJson()).toList(),
  };
}


