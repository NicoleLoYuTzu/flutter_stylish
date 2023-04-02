import 'package:flutter/material.dart';
import 'package:flutter_stylish/HomePage/VerticalCategories.dart';

import 'HomePage/HorizontalCategories.dart';

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
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth < 600) {
              return const VerticalCategories();
            } else {
              return HorizontalCategories();
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

class PictureOnTop extends StatelessWidget {
  const PictureOnTop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'images/${index + 1}.jpeg',
                fit: BoxFit.cover,
                height: 100.0,
              ),
            ),
          );
        },
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
      ),
    );
  }
}
