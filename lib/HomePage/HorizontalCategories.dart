import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stylish/HomePage/CardStyle.dart';

import '../DetailPage/DetailPage.dart';
import '../model/product.dart';

class HorizontalCategories extends StatefulWidget {
  final List<ProductList> productLists;
  HorizontalCategories(this.productLists, {Key? key}) : super(key: key);

  @override
  State<HorizontalCategories> createState() => _HorizontalCategoriesState();
}

class _HorizontalCategoriesState extends State<HorizontalCategories> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCategoryItem('女裝', 'women'),
          _buildCategoryItem('男裝', 'men'),
          _buildCategoryItem('配件', 'accessories'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String category, String categoryValue) {
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
              itemCount: widget.productLists
                  .where((product) => product.category == categoryValue)
                  .length,
              itemBuilder: (BuildContext context, int index) {
                final product = widget.productLists
                    .where((product) => product.category == categoryValue)
                    .elementAt(index);
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(product),
                      ),
                    );
                  },
                  child: CardStyle(product),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}



