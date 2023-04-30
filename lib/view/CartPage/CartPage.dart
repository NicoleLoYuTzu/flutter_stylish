import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_tappay/flutter_tappay.dart';



class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  String _tappayMessage = 'init';
  String _googleMap = 'init';

  static const platform = MethodChannel('test_tappay');


  Future<void> sendDataToAndroid(double latitude, double longitude) async {
    String message;

    try {
      final Map<String, double> args = <String, double>{'latitude': latitude, 'longitude': longitude};
      final String result = await platform.invokeMethod('googleMap', args);
      message = result;
    } on PlatformException catch (e) {
      print('Failed to send data to Android: ${e.message}');
      message = e.message ?? '';
    }

    setState(() {
      _googleMap = message;
    });
  }

  Future<void> _inputCreditCard() async {
    String message;

    try {
      final String result = await platform.invokeMethod('tappay');
      message = result;
    } on PlatformException catch (e) {
      message = e.message ?? '';
    }

    setState(() {
      _tappayMessage = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    int _counter = 0;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _tappayMessage,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () {
                final latitude = 25.0478;
                final longitude = 121.5319;
                sendDataToAndroid(latitude,longitude);
              },
              child: Text(_googleMap),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inputCreditCard,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

