import 'package:flutter/material.dart';
// import 'package:currency_convertor/dropdownlist.dart';

Widget selectorForCurrency(String? selectedCurrency, Function changeValue,
    List<String> dropDownItems) {
  return DropdownButton(
    onChanged: (String? newValue) {
      changeValue(newValue);
    },
    value: selectedCurrency,
    hint: Icon(Icons.arrow_downward),
    items: dropDownItems.map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(color: Colors.black),
        ),
      );
    }).toList(),
    selectedItemBuilder: (BuildContext context) {
      return dropDownItems.map<Widget>((String item) {
        return Text(
          item,
          style: TextStyle(color: Colors.white, fontSize: 20),
        );
      }).toList();
    },
  );
}
