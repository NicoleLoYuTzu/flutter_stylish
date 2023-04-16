import 'package:flutter/cupertino.dart';
import 'package:flutter_stylish/model/product.dart';

import 'HorizontalCategories.dart';
import 'OnTopPicture.dart';
import 'VerticalCategories.dart';

class HomePage extends StatefulWidget{
  final List<ProductList> productLists;

  HomePage(this.productLists, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnTopPicture(widget.productLists),
        HomePageProductList(widget.productLists),
      ],
    );
  }
}

class HomePageProductList extends StatefulWidget {
  final List<ProductList> productLists;
  HomePageProductList(this.productLists, {Key? key}) : super(key: key);

  @override
  State<HomePageProductList> createState() => _HomePageProductListState();
}

class _HomePageProductListState extends State<HomePageProductList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double minScreenWidth = 800.0; // 設定最小寬度值

    if (screenWidth < minScreenWidth) {
      return VerticalCategories(widget.productLists);
    } else {
      return HorizontalCategories(widget.productLists);
    }
  }
}