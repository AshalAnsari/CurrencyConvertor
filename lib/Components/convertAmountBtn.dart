import 'package:flutter/material.dart';

Widget convertAmountBtn(Function? convertAmount, BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(70),
      color: Colors.blue,
    ),
    padding: EdgeInsets.all(20),
    child: GestureDetector(
      onTap: () {
        convertAmount!();
      },
      child: Text(
        "Convert Amount",
        style: TextStyle(
            color: Colors.white,
            fontSize: MediaQuery.sizeOf(context).width * 0.045),
      ),
    ),
  );
}
