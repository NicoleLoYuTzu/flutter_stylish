import 'package:flutter/material.dart';

import '../model/product.dart';

class OnTopPicture extends StatelessWidget {
  //透過資料產生器，產生資料
  final List<ImageList> listItems = List<ImageList>.generate(50, (index) {
    return ImageList(
        image: Image.asset(
      'images/1.jpeg',
      width: 600,
      height: 500,
      fit: BoxFit.cover,
    ));
  });

  OnTopPicture({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'images/${index + 1}.jpeg',
                fit: BoxFit.cover,
                height: 100.0,
              ),
            ),
          );
        },
        pageSnapping: true,
        scrollDirection: Axis.horizontal,
        controller: PageController(initialPage: 1, viewportFraction: 0.3),
      ),
    );
  }
}
