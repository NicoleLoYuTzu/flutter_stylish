import 'package:flutter/material.dart';
import 'package:flutter_stylish/HomePage/product_list_item.dart';

import '../model/product.dart';

class VerticalCategories extends StatefulWidget {
  const VerticalCategories({Key? key}) : super(key: key);

  @override
  _VerticalCategoriesState createState() => _VerticalCategoriesState();
}

class _VerticalCategoriesState extends State<VerticalCategories> {
  final List<ProductList> listItems = List<ProductList>.generate(15, (index) {
    return ProductList(
        productStyle: '女裝',
        image: const AssetImage(
          'assets/images/flowers_2.png',
        ),
        productName: 'UNIQLO 特級輕羽絨',
        price: 323);
  });

  final Map<String, bool> _isVisibleMap = {
    '女裝': false,
    '男裝': false,
    '配件': false,
  };

  Widget _buildCategoryList(String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: InkWell(
            onTap: () {
              setState(() {
                _isVisibleMap[category] = !_isVisibleMap[category]!;
              });
            },
            child: Text(
              category,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isVisibleMap[category]!,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: listItems.length,
            itemBuilder: (context, index) {
              return ProductListItem(item: listItems[index]);
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildCategoryList('女裝'),
            _buildCategoryList('男裝'),
            _buildCategoryList('配件'),
          ],
        ),
      ),
    );
  }
}