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
  late Future<List<ProductList>> _futureAllProductLists;
  late Future<List<ProductList>> _futureHotProductLists;


  @override
  void initState() {
    super.initState();
    // _futureAllProductLists = fetchProductList("All");
    _futureAllProductLists = fetchProductList("All");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const StylishAppBar(),
          backgroundColor: Colors.grey[200],
        ),
        body: FutureBuilder<List<ProductList>>(
          future: _futureAllProductLists,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("Error=> ${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));

            } else {
              List<ProductList>? productLists = snapshot.data;
              return HomePage(productLists!);
            }
          },
        ),
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
