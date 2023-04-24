import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stylish/data/HomeItem.dart';

import '../DetailPage/DetailPage.dart';


class VerticalCategories extends StatefulWidget {

  final List<HomeProduct> womenClothes;
  final List<HomeProduct> menClothes;
  final List<HomeProduct> accessories;

  VerticalCategories(this.womenClothes, this.menClothes, this.accessories);

  @override
  _VerticalCategoriesState createState() => _VerticalCategoriesState();
}

class _VerticalCategoriesState extends State<VerticalCategories> {
  bool isWomenExpanded = true;
  bool isMenExpanded = true;
  bool isAccessoriesExpanded = true;

  @override
  Widget build(BuildContext context) {
    List<HomeItem> categories = [];
    int womenTitleIndex = -1;
    int menTitleIndex = -1;
    int otherTitleIndex = -1;
    List<HomeProduct> womenClothes = widget.womenClothes;
    List<HomeProduct> menClothes = widget.menClothes;
    List<HomeProduct> accessories = widget.accessories;

    if (womenClothes.isNotEmpty) {
      womenTitleIndex = 0;
      categories.add(HomeCategoryTitle("女裝"));
      if (isWomenExpanded) categories.addAll(womenClothes);
    }
    if (menClothes.isNotEmpty) {
      menTitleIndex = categories.length;
      categories.add(HomeCategoryTitle("男裝"));
      if (isMenExpanded) categories.addAll(menClothes);
    }
    if (accessories.isNotEmpty) {
      otherTitleIndex = categories.length;
      categories.add(HomeCategoryTitle("配件"));
      if (isAccessoriesExpanded) categories.addAll(accessories);
    }

    return Expanded(
        child: ListView.builder(
      itemCount: categories.length,
      physics: const BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == womenTitleIndex ||
            index == menTitleIndex ||
            index == otherTitleIndex) {
          return CategoryTitleView(
            title: categories[index].name,
            onTap: () {
              setState(() {
                if (index == womenTitleIndex) {
                  isWomenExpanded = !isWomenExpanded;
                }
                if (index == menTitleIndex) {
                  isMenExpanded = !isMenExpanded;
                }
                if (index == otherTitleIndex) {
                  isAccessoriesExpanded = !isAccessoriesExpanded;
                }
              });
            },
          );
        }
        HomeProduct product = categories[index] as HomeProduct;
        return CategoryCardView(product);
      },
    ));
  }
}

class CategoryTitleView extends StatelessWidget {
  final String title;
  final Function() onTap;

  const CategoryTitleView(
      {required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: InkWell(
          onTap: onTap,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ));
  }
}

void goProductContent(
    BuildContext context,
    String productId,
    ) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => DetailPage(productId: productId)),
  );
}

class CategoryCardView extends StatelessWidget {
  late HomeProduct product;

  CategoryCardView(this.product);

  @override
  Widget build(BuildContext context) {
    var id = product.id;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 120,
      child: InkWell(
        onTap: () {
          goProductContent(context, id);
        },
        child: Card(
          semanticContainer: true,
          margin: const EdgeInsets.all(8.0),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black45, width: 2),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
                child: CachedNetworkImage(
                  width: 60,
                  fit: BoxFit.fill,
                  imageUrl: product.image,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      "NT\$ ${product.price}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
