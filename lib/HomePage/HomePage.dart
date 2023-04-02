import 'package:flutter/cupertino.dart';

import 'HorizontalCategories.dart';
import 'OnTopPicture.dart';
import 'VerticalCategories.dart';

class HomePage extends StatelessWidget{

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OnTopPicture(),
        const HomePageProductList(),
      ],
    );
  }

}

class HomePageProductList extends StatelessWidget {
  const HomePageProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double minScreenWidth = 800.0; // 設定最小寬度值

    if (screenWidth < minScreenWidth) {
      return VerticalCategories();
    } else {
      return HorizontalCategories();
    }
  }
}