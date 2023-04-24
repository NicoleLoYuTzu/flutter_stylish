import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_bloc.dart';
import 'HorizontalCategories.dart';
import 'OnTopPicture.dart';
import 'VerticalCategories.dart';

class HomePage extends StatefulWidget{

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          OnTopPicture(),
          HomePageProductList(),
        ],
      ),
    );
  }
}

class HomePageProductList extends StatefulWidget {
  HomePageProductList({Key? key}) : super(key: key);

  @override
  State<HomePageProductList> createState() => _HomePageProductListState();
}

class _HomePageProductListState extends State<HomePageProductList> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double minScreenWidth = 800.0; // 設定最小寬度值


    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {

        if (state is HomeLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HomeErrorState) {
          return Center(
            child: Text(state.errorMsg),
          );
        }
        if (state is HomeSuccessState) {
          var womenClothes = state.womenDatum;
          var menClothes = state.menDatum;
          var accessories = state.accessoriesDatum;
          if (screenWidth < minScreenWidth) {
            return VerticalCategories(womenClothes?? [],menClothes?? [],accessories?? []);
          } else {
            return HorizontalCategories(womenClothes?? [],menClothes?? [],accessories?? []);
          }
        }
        // 添加默认返回值
        return Container();
      },


    );


  }
}