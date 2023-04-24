import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stylish/repo/stylish_repository.dart';
import 'package:flutter_stylish/util/my_custom_scroll_behavior.dart';
import 'package:flutter_stylish/view/HomePage/HomePage.dart';
import 'bloc/detail/product_content_bloc.dart';
import 'bloc/home/home_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    StylishRepository repository = StylishRepository();

    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => HomeBloc(repository)..add(HomeLoadEvent()),
          ),
          BlocProvider(
            create: (_) => ProductContentBloc(repository),
          ),
        ],
        child:MaterialApp(
          scrollBehavior: MyCustomScrollBehavior(),
          home: Scaffold(
            appBar: AppBar(
              title: const StylishAppBar(),
              backgroundColor: Colors.grey[200],
            ),
            body: HomePage(),
          ),
        ));
  }
}



class StylishAppBar extends StatelessWidget {
  const StylishAppBar({
    Key? key, // Add Key? before key to declare it as a named parameter with a null safety type.
  }) : super(key: key); // Pass key to the super constructor.

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120.0, // 设置图像的宽度
          child: Image.asset(
            'images/stylish_Logo.png',
            fit: BoxFit.fitWidth,
          ),
        ),
      ],
    );
  }
}
