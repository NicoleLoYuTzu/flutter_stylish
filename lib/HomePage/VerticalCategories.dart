import 'package:flutter/material.dart';

import '../model/product.dart';

class VerticalCategories extends StatefulWidget {
  final List<String> categories;
  late final int selectedIndex;

  VerticalCategories({
    Key? key,
    required this.categories,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  _VerticalCategoriesState createState() => _VerticalCategoriesState();
}

class _VerticalCategoriesState extends State<VerticalCategories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
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

  Widget _buildCategoryItem(int index) {
    final bool isSelected = index == widget.selectedIndex;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        widget.categories[index],
        textAlign: TextAlign.center,
      ),
    );
  }
}