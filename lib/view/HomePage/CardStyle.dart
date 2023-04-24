import 'package:flutter/material.dart';
import '../../data/HomeItem.dart';
import '../DetailPage/DetailPage.dart';

//沒用到
class CardStyle extends StatefulWidget {
  final HomeProduct? product;
  const CardStyle({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  State<CardStyle> createState() => _CardStyleState();
}

class _CardStyleState extends State<CardStyle> {

  @override
  Widget build(BuildContext context) {

    var image = widget.product?.image ?? "";
    var id = widget.product?.id ?? "";
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(productId: id,),
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
                      image: NetworkImage(image),
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
                      widget.product?.name?? "",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'NT\$ ${widget.product?.price}',
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
