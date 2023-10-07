import 'package:calculator_app/models/item_model.dart';
import 'package:flutter/material.dart';
import '../modules/home_screen.dart';

Widget calculatorItem(ItemModel model, {required Function() onTap}) =>
    GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(60)),
          gradient: LinearGradient(colors: [
            model.buttonColor1 ?? const Color(0xFFE5EAF5),
            model.buttonColor2 ?? const Color(0xFFE5EAF5)
          ]),
          // color: model.buttonColor ?? Color(0xFFE5EAF5) ,
        ),
        child: Text(
          model.buttonText,
          style: TextStyle(
              fontSize: 30,
              color: model.buttonTextColor ?? Colors.grey.shade800),
        ),
      ),
    );
