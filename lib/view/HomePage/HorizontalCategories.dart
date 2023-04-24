import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/HomeItem.dart';
import 'VerticalCategories.dart';

class HorizontalCategories extends StatefulWidget {
  final List<HomeProduct> womenClothes;
  final List<HomeProduct> menClothes;
  final List<HomeProduct> accessories;

  const HorizontalCategories(
      this.womenClothes, this.menClothes, this.accessories,
      {super.key});

  @override
  State<HorizontalCategories> createState() => _HorizontalCategoriesState();
}

class _HorizontalCategoriesState extends State<HorizontalCategories> {
  bool isWomenExpanded = true;
  bool isMenExpanded = true;
  bool isAccessoriesExpanded = true;

  @override
  Widget build(BuildContext context) {
    final List<HomeProduct> womenClothes = widget.womenClothes;
    final List<HomeProduct> menClothes = widget.menClothes;
    final List<HomeProduct> accessories = widget.accessories;

    return Expanded(
      child: Row(
        children: [
          _listWithTitle("女裝", womenClothes),
          _listWithTitle("男裝", menClothes),
          _listWithTitle("配件", accessories),
        ],
      ),
    );
  }

  Expanded _listWithTitle(
    String title,
    List<HomeProduct> categories,
  ) {
    return Expanded(
        child: Column(
      children: [
        CategoryTitleView(
          title: title,
          onTap: () {
            setState(() {
              if (title == "女裝") isWomenExpanded = !isWomenExpanded;
              if (title == "男裝") isMenExpanded = !isMenExpanded;
              if (title == "配件") isAccessoriesExpanded = !isAccessoriesExpanded;
            });
          },
        ),
        if (title == "女裝" && isWomenExpanded ||
            title == "男裝" && isMenExpanded ||
            title == "配件" && isAccessoriesExpanded)
          _list(categories),
      ],
    ));
  }

  Expanded _list(List<HomeProduct> categories) {
    return Expanded(
      child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          HomeProduct product = categories[index];
          return CategoryCardView(product);
        },
      ),
    );
  }
}
