import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/home/home_bloc.dart';
import '../../model/product.dart';
import '../DetailPage/DetailPage.dart';

class OnTopPicture extends StatefulWidget {

  OnTopPicture({Key? key}) : super(key: key);

  @override
  State<OnTopPicture> createState() => _OnTopPictureState();
}

class _OnTopPictureState extends State<OnTopPicture> {
  //透過資料產生器，產生資料
  // final List<ImageList> listItems = List<ImageList>.generate(50, (index) {
  //   return ImageList(
  //       image: Image.asset(
  //     'images/1.jpeg',
  //     width: 600,
  //     height: 500,
  //     fit: BoxFit.cover,
  //   ));
  // });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {

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
        var hots = state.hotsDatum;
        // var womenClothes = state.womenDatum;
        // var menClothes = state.menDatum;
        // var accessories = state.accessoriesDatum;


          return PageView.builder(
            itemCount: hots?.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(productId: hots[index].id,),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      hots![index].image?? "",
                      fit: BoxFit.cover,
                      height: 100.0,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return const Text('Failed to load image');
                      },
                    ),
                  ),
                ),
              );
            },
            pageSnapping: true,
            scrollDirection: Axis.horizontal,
            controller:
            PageController(initialPage: 1, viewportFraction: 0.3),
          );
        };

      return Container();
      }),
    );
  }
}
