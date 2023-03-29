import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

int _selectedIndex = -1;
final List<String> _categories = ['女裝', '男裝', '配件'];
final List<List<String>> _items = [
  [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10'
  ],
  [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10',
    'Item 11',
    'Item 12'
  ],
  [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
    'Item 6',
    'Item 7',
    'Item 8',
    'Item 9',
    'Item 10'
  ],
];

final List<bool> _itemsExpansionPanel = [false, false, false];

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final double appBarHeight = AppBar().preferredSize.height;
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        body: Column(
          children: [
            const PictureOnTop(),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return (constraints.maxWidth < 600)
                    ? _buildVerticalCategories() // 如果螢幕寬度小於 600，則使用垂直列表
                    : _buildHorizontalCategories(); // 否則使用水平列表
              },
            )
          ],
        ),
      ),
    );
  }

  void _selectCategory(int index) {
    setState(() {
      _selectedIndex = index;
      _itemsExpansionPanel.fillRange(0, _itemsExpansionPanel.length, false);
      _itemsExpansionPanel[0] = index == 0;
    });
  }

  Widget _buildVerticalCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        _categories.length,
        (i) => GestureDetector(
          onTap: () => _selectCategory(i),
          child: _buildCategoryItem(i),
        ),
      ),
    );
  }

  Widget _buildHorizontalCategories() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        _categories.length,
        (i) => GestureDetector(
          onTap: () => _selectCategory(i),
          child: _buildCategoryItem(i),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(int index) {
    final bool isSelected = index == _selectedIndex;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.black : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      child: Text(
        _categories[index],
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}

class PictureOnTop extends StatelessWidget {
  const PictureOnTop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 360.0,
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
