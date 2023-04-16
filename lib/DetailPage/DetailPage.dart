import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stylish/model/product.dart';

import '../main.dart';

class DetailPage extends StatefulWidget {

  final ProductList productList;

  DetailPage(this.productList, {Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    const double minScreenWidth = 800.0; // 設定最小寬度值

    final isPhoneSize = screenWidth < minScreenWidth;

    return Scaffold(
        appBar: AppBar(
          title: const StylishAppBar(),
          backgroundColor: Colors.grey[200],
        ),
        body: SingleChildScrollView(
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Column(
                children: [
                  if (isPhoneSize)
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(38),
                          child: Image(
                            image: NetworkImage(widget.productList.images[0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: TextWithLine(
                            topText: widget.productList.title,
                            midText: widget.productList.id.toString(),
                            botText: 'NT\$${widget.productList.price}',
                            lineText: '---',
                            productList: widget.productList,
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 38),
                            child: Image(
                              image: NetworkImage(widget.productList.images[0]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: TextWithLine(
                              topText: widget.productList.title,
                              midText: widget.productList.id.toString(),
                              botText: 'NT\$${widget.productList.price}',
                              lineText: '---',
                              productList: widget.productList,
                            ),
                          ),
                        ),
                      ],
                    ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 38),
                        child: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: <Color>[
                                Colors.blue.shade800,
                                Colors.blue.shade400,
                                Colors.green.shade400,
                                Colors.green.shade100,
                              ],
                            ).createShader(bounds);
                          },
                          child: const Text(
                            '細部說明',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(16),
                          height: 1,
                          color: Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 38, right: 38),
                          child: const Text(
                            'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who prefer their summer style extra-breezy.',
                            softWrap: true,
                            maxLines: 3,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(38),
                              child: Image(
                                image: AssetImage(
                                    'images/detailpage${index + 1}.png'),
                                height: 230,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class ImageWidget extends StatelessWidget {
  final ImageProvider image;
  final double height;

  const ImageWidget({Key? key, required this.image, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover, // 添加fit属性
        ),
      ),
    );
  }
}

class TextWithLine extends StatefulWidget {
  final String lineText;
  final String topText;
  final String midText;
  final String botText;
  final ProductList productList;

  const TextWithLine({
    Key? key,
    required this.lineText,
    required this.topText,
    required this.midText,
    required this.botText, required this.productList,
  }) : super(key: key);

  @override
  State<TextWithLine> createState() => _TextWithLineState();
}

class _TextWithLineState extends State<TextWithLine> {

  int selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.topText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      Text(widget.midText),
      const SizedBox(height: 8),
      Text(
        widget.botText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      Container(
        height: 1,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.withOpacity(0.3),
              width: 1,
            ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(widget.lineText),
          ),
        ),
      ),
      Row(
        children: [
          const Text('顏色'),
          const SizedBox(width: 8),
          const Text('｜'),
          const SizedBox(width: 8),
          Row(
            children: List.generate(widget.productList.colors.length, (index) {
              final color = hexToColor(widget.productList.colors[index].code);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedColorIndex = index;
                  });
                },
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    border: Border.all(
                      color: selectedColorIndex == index ? Colors.black : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
              );
            }).map((colorWidget) => Row(
              children: [
                colorWidget,
                const SizedBox(width: 8),
              ],
            )).toList(),
          ),

        ],
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Text(
            '尺寸',
          ),
          const SizedBox(width: 8),
          const Text('｜'),
          const SizedBox(width: 8),
          Expanded(
            child: ButtonList(
              buttonTitles: widget.productList.sizes,
              onTap: (index) {
                // 根據尺寸值執行相應的處理
              },
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Text(
            '數量',
          ),
          const SizedBox(width: 8),
          const Text('｜'),
          const SizedBox(width: 8),
          Expanded(
            child: NumberWidget(
              number: 1,
              onIncrement: (int) {},
              onDecrement: (int) {},
              productList: widget.productList,
            ),
          ),
        ],
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.grey[800],
              height: 50,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ElevatedButton(
                  onPressed: null,
                  child: Text(
                    '請調整尺寸',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16), // 添加邊距
                    backgroundColor: Colors.grey[700],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      SizedBox(height: 8),
      Row(children: const [
        Text(
          '實品顏色依單品照為主',
        ),
      ]),
      Row(children: const [
        Text(
          '棉100%',
        ),
      ]),
      Row(children: const [
        Text(
          '厚薄：薄',
        ),
      ]),
      Row(children: const [
        Text(
          '彈性：無',
        ),
      ]),
      Row(children: const [
        Text(
          '素材產地 / 日本',
        ),
      ]),
      Row(children: const [
        Text(
          '加工產地 / 中國',
        ),
      ]),
    ]);
  }

  // Color hexToColor(String code) {
  //   return Color(int.parse(code.substring(0, 2) + 'FF' + code.substring(2), radix: 16));
  // }
  Color hexToColor(String code) {
    final String hex = code.replaceAll("#", "");
    return Color(int.parse("FF$hex", radix: 16));
  }
}

class NumberWidget extends StatefulWidget {
  NumberWidget(
      {required this.number,
      required this.onIncrement,
      required this.onDecrement, required this.productList});

  final int number;
  final void Function(int) onIncrement;
  final void Function(int) onDecrement;
  final ProductList productList;

  @override
  _NumberWidgetState createState() => _NumberWidgetState();
}

class _NumberWidgetState extends State<NumberWidget> {
  int _number = 0;

  @override
  void initState() {
    super.initState();
    _number = widget.number;
  }

  void _incrementNumber() {
    setState(() {
      if (_number <10) {
        _number++;
        widget.onIncrement(_number);
      }
    });
  }

  void _decrementNumber() {
    setState(() {
      if (_number > 0) {
        _number--;
        widget.onDecrement(_number);
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    Color _decrementbuttonColor = Colors.white; // 定義按鈕的初始顏色
    Color _incrementbuttonColor = Colors.white; // 定義按鈕的初始顏色
    return Row(
      children: [
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            setState(() {
              _decrementbuttonColor = Colors.black; // 按下時更改為黑色背景
            });
          },
          onTapUp: (TapUpDetails details) {
            _decrementNumber(); // 呼叫遞減數字的函數
            setState(() {
              _decrementbuttonColor = Colors.black; // 按下時更改為黑色背景
            });
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _decrementbuttonColor, // 根據 _buttonColor 動態設置背景顏色
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "-",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300]!,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Center(
              child: Text(
                _number.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        GestureDetector(
          onTapDown: (TapDownDetails details) {
            setState(() {
              _incrementbuttonColor = Colors.black; // 按下時更改為黑色背景
            });
          },
          onTapUp: (TapUpDetails details) {
            _incrementNumber();
            setState(() {
              _incrementbuttonColor = Colors.black; // 按下時更改為黑色背景
            });
          },
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: _incrementbuttonColor, // 根據 _buttonColor 動態設置背景顏色
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                "+",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ButtonList extends StatefulWidget {
  final List<String> buttonTitles;
  final Function(int) onTap;

  ButtonList({required this.buttonTitles, required this.onTap});

  @override
  _ButtonListState createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: widget.buttonTitles.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              CustomButton(
                text: widget.buttonTitles[index],
                onTap: () {
                  setState(() {
                    if (_selectedIndex == index) {
                      _selectedIndex = -1;
                    } else {
                      _selectedIndex = index;
                    }
                    widget.onTap(index);
                  });
                },
                isSelected: _selectedIndex == index,
              ),
              SizedBox(width: 8.0),
            ],
          );
        },
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isSelected;

  CustomButton(
      {required this.text, required this.onTap, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    Color customGrey = Color.fromRGBO(70, 70, 70, 1.0);
    return GestureDetector(
      onTapDown: (_) {
        onTap();
      },
      onTapUp: (_) {},
      onTapCancel: () {},
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.grey.shade400 : customGrey,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
