import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';

class HorizontalCategories extends StatefulWidget {
  final List<String> categories;
  late final int selectedIndex;

  HorizontalCategories({
    Key? key,
    required this.categories,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  _HorizontalCategories createState() => _HorizontalCategories();
}

class _HorizontalCategories extends State<HorizontalCategories> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        widget.categories.length,
        (i) => GestureDetector(
          onTap: () => _selectCategory(i),
          child: _buildCategoryItem(i),
        ),
      ),
    );
  }

  void _selectCategory(int index) {
    setState(() {
      widget.selectedIndex = index;
    });
  }

  final List<Product> listItems = List<Product>.generate(50, (index) {
    return Product(
        title: "123", image: const AssetImage('images/dog.png'), price: 15);
  });

  Widget _buildCategoryItem(int index) {
    final bool isSelected = index == widget.selectedIndex;

    return GestureDetector(
      onTap: () => _selectCategory(index),
      child: Expanded(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                widget.categories[index],
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
