import 'package:flutter/material.dart';
import '../DetailPage/DetailPage.dart';
import '../model/product.dart';

class CardStyle extends StatefulWidget {
  final ProductList productList;

  CardStyle(this.productList, {Key? key}) : super(key: key);

  @override
  State<CardStyle> createState() => _CardStyleState();
}

class _CardStyleState extends State<CardStyle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(widget.productList),
            ),
          );
        },
        child: Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              children: [
                Flexible(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    child: Image(
                      image: NetworkImage(widget.productList.images[0]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productList.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'NT\$ ${widget.productList.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                )
              ],
            )
        )
    );
  }
}
