import 'package:currency_convertor/Components/convertAmountBtn.dart';
import 'package:currency_convertor/Components/selector.dart';
import 'package:currency_convertor/Components/textInputFeild.dart';
import 'package:currency_convertor/Functions/CurrencyConvertorFunctions.dart';
import 'package:currency_convertor/Screens/HistoryScreen.dart';
import 'package:currency_convertor/dropdownlist.dart';
import 'package:flutter/material.dart';

class CurrencyConvertor extends StatefulWidget {
  const CurrencyConvertor({super.key});

  @override
  State<CurrencyConvertor> createState() => _CurrencyConvertorState();
}

class _CurrencyConvertorState extends State<CurrencyConvertor> {
  String? selectedCurrencyFrom;
  String? selectedCurrencyTo;
  List<String> fromCurrencyRates = [];
  Map<String, dynamic> _exchangeRates = {};
  TextEditingController _controller = TextEditingController();
  String? result = "0.0";
  List<Map<String, dynamic>> history = [];

  void settingTwoState(Map<String, dynamic> rates) {
    setState(() {
      fromCurrencyRates = rates.keys.toList();
      _exchangeRates = rates;
    });
  }

  void settingOneState(double? amount) {
    setState(() {
      result = "$selectedCurrencyTo ${amount.toString()}";
      history.add({
        'AmountFrom': "$selectedCurrencyFrom",
        'AmountTo': "$selectedCurrencyTo",
        'ConvertedAmount': '$result'
      });
      isLoading = false;
    });
  }

  CurrencyConvertorFunctions obj = CurrencyConvertorFunctions();

  void changeFromValue(String? value) {
    setState(() {
      selectedCurrencyFrom = value;
    });
  }

  void changeToValue(String? value) {
    setState(() {
      selectedCurrencyTo = value;
    });
  }

  void Redo() {
    setState(() {
      selectedCurrencyFrom = null;
      selectedCurrencyTo = null;
      _controller.clear();
      result = "0.0";
    });
  }

  void settingState(bool decider) {
    setState(() {
      isLoading = decider;
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Color.fromRGBO(40, 44, 52, 1),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.1,
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  "Currency Convertor",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width * 0.09,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
                top: MediaQuery.sizeOf(context).height * 0.038,
                left: MediaQuery.sizeOf(context).width * 0.85,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.history,
                    color: Colors.white,
                    size: 45,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserHistory(history: history),
                      ),
                    );
                  },
                )),
            Positioned(
              top: MediaQuery.sizeOf(context).height * 0.27,
              right: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "From",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        selectorForCurrency(selectedCurrencyFrom,
                            changeFromValue, dropDownItems)
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "To",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        selectorForCurrency(
                            selectedCurrencyTo, changeToValue, dropDownItems)
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.48,
              // top: 300,
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  textInputFeild(
                      _controller, "Enter the Amount", Icons.currency_exchange),
                  SizedBox(height: 30),
                  Text(
                    "Your Converted Amount",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "$result",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.sizeOf(context).width * 0.15),
                  )
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: MediaQuery.sizeOf(context).height * 0.04,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: convertAmountBtn(
                  () => obj.convertAmount(
                    selectedCurrencyFrom,
                    selectedCurrencyTo,
                    _exchangeRates,
                    _controller,
                    settingOneState,
                    settingTwoState,
                    settingState,
                  ),
                  context,
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: MediaQuery.sizeOf(context).width * 0.7,
              bottom: MediaQuery.sizeOf(context).height * 0.065,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {
                    Redo();
                  },
                  child: Container(
                    color: Colors.blue,
                    child: Icon(
                      Icons.redo,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if (isLoading)
              Positioned.fill(
                  child: Container(
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ))
          ],
        ),
      ),
    );
  }
}
