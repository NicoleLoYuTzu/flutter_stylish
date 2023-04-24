import 'package:flutter/material.dart';
// import 'package:flutter_tappay/flutter_tappay.dart';



class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // FlutterTappay? _tappay;
  TextEditingController? _cardNumberController;
  TextEditingController? _cardMonthController;
  TextEditingController? _cardYearController;
  TextEditingController? _cardCCVController;

  String _token = '';

  @override
  void initState() {
    super.initState();
    // _tappay?.init(
    //   appKey: 'app_whdEWBH8e8Lzy4N6BysVRRMILYORF6UxXbiOFsICkz0J9j1C0JUlCHv1tVJC',
    //   appId: 11334,
    //   serverType: FlutterTappayServerType.Sandbox,
    // );
  }

  @override
  void dispose() {
    _cardNumberController?.dispose();
    _cardMonthController?.dispose();
    _cardYearController?.dispose();
    _cardCCVController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tappay'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '信用卡號',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _cardNumberController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: '輸入信用卡號',
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '到期日',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _cardMonthController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'MM',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _cardYearController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'YY',
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '安全碼',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _cardCCVController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'CCV',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String? cardNumber = _cardNumberController?.text;
                String? cardMonth = _cardMonthController?.text;
                String? cardYear = _cardYearController?.text;
                String? cardCCV = _cardCCVController?.text;

                // TODO: Use Tappay SDK to process payment
              },
              child: Text('付款'),
            ),
          ],
        ),
      ),
    );
  }
}

