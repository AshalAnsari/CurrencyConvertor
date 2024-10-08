import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CurrencyConvertorFunctions {
  Future<void> fetchSelectedCurrency(
      String? selectedCurrencyFrom, Function? performAction) async {
    final apiResponse = await http.get(Uri.parse(
        "https://v6.exchangerate-api.com/v6/6c17bd380e74c6944b7e09b4/latest/${selectedCurrencyFrom}"));
    print(apiResponse);
    if (apiResponse.statusCode == 200) {
      final jsonData = jsonDecode(apiResponse.body);
      final Map<String, dynamic> rates = jsonData['conversion_rates'];
      performAction!(
        rates,
      );
    } else {
      print("Failed to fetch From currency rates");
    }
  }

  void convertAmount(
      String? selectedCurrencyFrom,
      String? selectedCurrencyTo,
      Map<String, dynamic> _exchangeRates,
      TextEditingController? _controller,
      Function? settingOneState,
      Function? settingTwoState,
      Function setLoading) async {
    if (selectedCurrencyFrom != null && selectedCurrencyTo != null) {
      setLoading(true);
      await fetchSelectedCurrency(selectedCurrencyFrom, settingTwoState);
      double? rate = _exchangeRates[selectedCurrencyTo];
      if (rate == null) {
        // print("Rate for the selected currency is not available.");
        //WillShowBottomBar For Error
        setLoading(false);
        return;
      }
      double? value = double.parse(_controller!.text);
      double amount = rate * value;
      settingOneState!(amount);
    }
  }
}
