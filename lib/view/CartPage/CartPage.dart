import 'package:flutter/material.dart';
import 'package:flutter_tappay/flutter_tappay.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late String _token;
  late FlutterTappay payer;
  bool prepared = false;

  late TextEditingController _cardNumber;
  late TextEditingController _cardMonth;
  late TextEditingController _cardYear;
  late TextEditingController _cardCCV;

  bool _isCardNumberValid = true;
  bool _isCardCCVValid = true;
  bool _isCardYearValid = true;
  bool _isCardMonthValid = true;
  bool _totalValid = false;

  @override
  void initState() {
    super.initState();
    payer = FlutterTappay();
    payer
        .init(
            appKey:
                "app_whdEWBH8e8Lzy4N6BysVRRMILYORF6UxXbiOFsICkz0J9j1C0JUlCHv1tVJC",
            appId: 11334,
            serverType: FlutterTappayServerType.Sandbox)
        .then((_) {
      setState(() {
        prepared = true;
      });
    });

    validator() {
      payer
          .validate(
        cardNumber: _cardNumber.text,
        dueMonth: _cardMonth.text,
        dueYear: _cardYear.text,
        ccv: _cardCCV.text,
      )
          .then((validationResult) {
        bool cardValid = validationResult.isCardNumberValid;
        bool dateValid = validationResult.isExpiryDateValid;
        bool ccvValid = validationResult.isCCVValid;
        _totalValid = cardValid && ccvValid && dateValid;
        if (cardValid == true) {
          _isCardNumberValid = true;
        } else {
          _isCardNumberValid = _cardNumber.text != "" ? false : true;
        }
        if (ccvValid == true) {
          _isCardCCVValid = true;
        } else {
          _isCardCCVValid = _cardCCV.text != "" ? false : true;
        }
        if (dateValid == true) {
          _isCardYearValid = true;
          _isCardMonthValid = true;
        } else {
          _isCardYearValid = _cardYear.text != "" ? false : true;
          _isCardMonthValid = _cardMonth.text != "" ? false : true;
        }

        setState(() {});
      });
    }

    _cardNumber = TextEditingController(text: "")..addListener(validator);
    _cardMonth = TextEditingController(text: "")..addListener(validator);
    _cardYear = TextEditingController(text: "")..addListener(validator);
    _cardCCV = TextEditingController(text: "")..addListener(validator);
  }

  @override
  void dispose() {
    _cardNumber.dispose();
    _cardMonth.dispose();
    _cardYear.dispose();
    _cardCCV.dispose();
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
            TextFormField(
              controller: _cardNumber,
              keyboardType: TextInputType.number,
              validator: (v) => _isCardNumberValid ? null : "卡號不正確",
              autovalidateMode: AutovalidateMode.always,
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
                      TextFormField(
                        controller: _cardMonth,
                        keyboardType: TextInputType.number,
                        validator: (v) => _isCardMonthValid ? null : "月份不正確",
                        autovalidateMode: AutovalidateMode.always,
                        decoration: const InputDecoration(
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
                      TextFormField(
                        controller: _cardYear,
                        keyboardType: TextInputType.number,
                        validator: (v) => _isCardYearValid ? null : "年份不正確",
                        autovalidateMode: AutovalidateMode.always,
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
                      TextFormField(
                        controller: _cardCCV,
                        keyboardType: TextInputType.number,
                        validator: (v) => _isCardCCVValid ? null : "安全碼不正確",
                        autovalidateMode: AutovalidateMode.always,
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
              onPressed: () async {
                String? cardNumber = _cardNumber.text;
                String? cardMonth = _cardMonth.text;
                String? cardYear = _cardYear.text;
                String? cardCCV = _cardCCV.text;
                TappayTokenResponse? response;

                try {
                  response = await payer.sendToken(
                    cardNumber: cardNumber,
                    dueYear: cardMonth,
                    dueMonth: cardYear,
                    ccv: cardCCV,
                  );
                  print("payer=>${payer}");

                  print("cardNumber=>${cardNumber}");
                  print("cardMonth=>${cardMonth}");
                  print("response=>${response}");


                } catch (err) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Payment error: ${err.toString()}")));
                  print("Payment error: ${err.toString()}");
                }

                payer.onTokenReceived.listen((data) {
                  setState(() {
                    _token = data;
                  });
                }, onError: (err) {
                  print("$err");
                }, onDone: () {
                  print("done");
                });
                print("_token=>${_token}");
              },
              child: Text('付款'),
            ),
          ],
        ),
      ),
    );
  }
}
