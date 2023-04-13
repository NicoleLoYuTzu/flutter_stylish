import 'package:flutter/material.dart';

import '../model/product.dart';

class OnTopPicture extends StatefulWidget {
  final List<ProductList> productLists;

  OnTopPicture(this.productLists, {Key? key}) : super(key: key);

  @override
  State<OnTopPicture> createState() => _OnTopPictureState();
}

class _OnTopPictureState extends State<OnTopPicture> {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: PageView.builder(
        itemCount: widget.productLists.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                widget.productLists[index].image.url,
                fit: BoxFit.cover,
                height: 100.0,
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return const Text('Failed to load image');
                },
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
