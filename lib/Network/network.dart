import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/product.dart';

Future<List<dynamic>> fetchProductList(category) async {
  const String hostName = 'api.appworks-school.tw';
  const String apiVersion = '1.0';
  String askForRequest;

  if (category == "Hot") {
    askForRequest = '/marketing/hots';
  } else if (category == "All") {
    askForRequest = '/products/all';
  } else {
    // handle other cases, for example:
    throw Exception('Invalid category: $category');
  }

  final response =
      await http.get(Uri.https(hostName, '/api/$apiVersion$askForRequest'));
  print('Uri : ${Uri.https(hostName, '/api/$apiVersion$askForRequest')}');
  print('response.statusCode => ${response.statusCode}');
  if (response.statusCode == 200) {
    List<dynamic> productLists = [];
    ProductListHots productListsHot = ProductListHots(title: '', products: []);


    var jsonData = jsonDecode(response.body);
    var data = jsonData['data'];

    if (category == "All") {
      for (var item in data) {
        List<Variant> variants = [];
        for (var variant in item['variants']) {
          variants.add(
            Variant(
              colorCode: variant['color_code'],
              size: variant['size'],
              stock: variant['stock'],
            ),
          );
        }

        List<ProductColor> colors = [];
        for (var color in item['colors']) {
          colors.add(
            ProductColor(
              code: color['code'],
              name: color['name'],
            ),
          );
        }

        List<String> sizes = [];
        for (var size in item['sizes']) {
          sizes.add(size);
        }

        List<String> images = [];
        for (var image in item['images']) {
          images.add(image);
        }

        ProductList productList = ProductList(
          id: item['id'],
          category: item['category'],
          title: item['title'],
          description: item['description'],
          price: item['price'],
          texture: item['texture'],
          wash: item['wash'],
          place: item['place'],
          note: item['note'],
          story: item['story'],
          colors: colors,
          sizes: sizes,
          variants: variants,
          mainImage: item['main_image'],
          images: images,
        );

        productLists.add(productList);
      }

      for (var product in productLists) {
        print('Product ID: ${product.id}');
        print('Category: ${product.category}');
        print('Title: ${product.title}');
        print('Description: ${product.description}');
        print('Price: ${product.price}');
        print('Texture: ${product.texture}');
        print('Wash: ${product.wash}');
        print('Place: ${product.place}');
        print('Note: ${product.note}');
        print('Story: ${product.story}');
        print('Colors:');
        for (var color in product.colors) {
          print(' - ${color.name} (${color.code})');
        }
        print('Sizes: ${product.sizes}');
        print('Variants:');
        for (var variant in product.variants) {
          print(
              ' - Color: ${variant.colorCode}, Size: ${variant.size}, Stock: ${variant.stock}');
        }
        print('Main Image: ${product.mainImage}');
        print('Images:');
        for (var image in product.images) {
          print(' - $image');
        }
        print('==========================================');
      }

    } else if (category == "Hot") {

      for (var item in data) {
        productListsHot = ProductListHots(
          title: item['title'],products: item['products']
        );

        List<Variant> variants = [];
        for (var variant in item['variants']) {
          variants.add(
            Variant(
              colorCode: variant['color_code'],
              size: variant['size'],
              stock: variant['stock'],
            ),
          );
        }

        List<ProductColor> colors = [];
        for (var color in item['colors']) {
          colors.add(
            ProductColor(
              code: color['code'],
              name: color['name'],
            ),
          );
        }

        List<String> sizes = [];
        for (var size in item['sizes']) {
          sizes.add(size);
        }

        List<String> images = [];
        for (var image in item['images']) {
          images.add(image);
        }

        ProductList productList = ProductList(
          id: item['id'],
          category: item['category'],
          title: item['title'],
          description: item['description'],
          price: item['price'],
          texture: item['texture'],
          wash: item['wash'],
          place: item['place'],
          note: item['note'],
          story: item['story'],
          colors: colors,
          sizes: sizes,
          variants: variants,
          mainImage: item['main_image'],
          images: images,
        );
        productListsHot.products.add(productList);
        productLists = productListsHot.products;
      }


    }

    if (category == "Hot") {
      return productLists;
    } else if (category == "All") {
      return productLists;
    } else {
      // handle other cases, for example:
      throw Exception('Invalid category: $category');
    }

  } else {
    throw Exception('Failed to load product list');
  }
}
