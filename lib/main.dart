import 'package:flutter/material.dart';
import 'package:flutter_stylish/HomePage/VerticalCategories.dart';

import 'HomePage/HomePage.dart';
import 'HomePage/HorizontalCategories.dart';
import 'model/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const StylishAppBar(),
          backgroundColor: Colors.grey[200],
        ),
        body: const HomePage(),
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
