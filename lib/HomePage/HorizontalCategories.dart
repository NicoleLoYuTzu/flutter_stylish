import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stylish/HomePage/CardStyle.dart';

import '../model/product.dart';

class HorizontalCategories extends StatelessWidget {
  HorizontalCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCategoryItem('女裝'),
          _buildCategoryItem('男裝'),
          _buildCategoryItem('配件'),
        ],
      ),
    );
  }

  final List<ProductList> listItems = List<ProductList>.generate(15, (index) {
    return ProductList(
        productStyle: '女裝',
        image: const AssetImage(
          'images/dog.png',
        ),
        productName: 'UNIQLO 特級輕羽絨',
        price: 323);
  });

  Widget _buildCategoryItem(String category) {
    return Flexible(
      child: Column(
        children: [
          Text(
            category,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Flexible(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              shrinkWrap: true,
              itemCount: listItems.length,
              itemBuilder: (context, index) {
                return CardStyle(item: listItems[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

