import 'package:flutter/material.dart';
import 'package:flutter_stylish/HomePage/VerticalCategories.dart';

import 'HomePage/HomePage.dart';
import 'HomePage/HorizontalCategories.dart';
import 'Network/network.dart';
import 'model/product.dart';


void main() {
  runApp(const MyApp());
}
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const StylishAppBar(),
//           backgroundColor: Colors.grey[200],
//         ),
//         body: const HomePage(),
//
//       ),
//     );
//   }
// }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<ProductList> _productLists = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      final products = await fetchProductList();
      setState(() {
        _productLists = products;
      });

    } catch (e) {
      // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    print('_productLists : ${_productLists}');
    print('_productLists length: ${_productLists.length}');


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const StylishAppBar(),
          backgroundColor: Colors.grey[200],
        ),
        body: HomePage(productLists: _productLists),
      ),
    );
  }
}


class StylishAppBar extends StatelessWidget {
  const StylishAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120.0, // 设置图像的宽度
          child: Image.asset(
            'images/stylish_Logo.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
