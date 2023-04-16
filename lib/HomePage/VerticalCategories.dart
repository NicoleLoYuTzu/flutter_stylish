import 'package:flutter/material.dart';
import 'package:flutter_stylish/HomePage/CardStyle.dart';

import '../model/product.dart';

class VerticalCategories extends StatefulWidget {
  final List<dynamic> productLists;

  VerticalCategories(this.productLists, {Key? key}) : super(key: key);

  @override
  _VerticalCategoriesState createState() => _VerticalCategoriesState();
}

class _VerticalCategoriesState extends State<VerticalCategories> {
  // final List<ProductList> listItems = List<ProductList>.generate(15, (index) {
  //   return ProductList(
  //       productStyle: '女裝',
  //       productName: 'UNIQLO 特級輕羽絨',
  //       price: 323);
  // });

  final Map<String, bool> _isVisibleMap = {
    '女裝': false,
    '男裝': false,
    '配件': false,
  };

  Widget _buildCategoryList(String category, String categoryValue) {
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
            itemCount: widget.productLists.length,
            itemBuilder: (context, index) {
              if (widget.productLists[index].category == categoryValue) {
                return CardStyle(widget.productLists[index]);
              } else {
                return const SizedBox.shrink();
              }
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
            _buildCategoryList('女裝', 'women'),
            _buildCategoryList('男裝', 'men'),
            _buildCategoryList('配件', 'accessories'),
          ],
        ),
      ),
    );
  }
}