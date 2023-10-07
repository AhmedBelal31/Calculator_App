import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../models/item_model.dart';
import '../shared/component.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

Color symbolColor1 = const Color(0xFFF5EBE3);
Color arithmeticSymbolsColor1 = Colors.deepOrange;
Color arithmeticSymbolsColor2 = Colors.orange.shade300;

class _HomeScreenState extends State<HomeScreen> {
  //const HomeScreen({Key? key}) : super(key: key);
  List<ItemModel> itemModelData = [
    ItemModel(
      buttonText: 'C',
      buttonColor1: symbolColor1,
      buttonColor2: symbolColor1,
    ),
    ItemModel(
      buttonText: 'Del',
      buttonColor1: symbolColor1,
      buttonColor2: symbolColor1,
    ),
    ItemModel(
      buttonText: '%',
      buttonColor1: symbolColor1,
      buttonColor2: symbolColor1,
    ),
    ItemModel(
        buttonText: '/',
        buttonColor1: arithmeticSymbolsColor1,
        buttonColor2: arithmeticSymbolsColor2,
        buttonTextColor: Colors.white),
    ItemModel(buttonText: '9'),
    ItemModel(buttonText: '8'),
    ItemModel(buttonText: '7'),
    ItemModel(
        buttonText: '*',
        buttonColor1: arithmeticSymbolsColor1,
        buttonColor2: arithmeticSymbolsColor2,
        buttonTextColor: Colors.white),
    ItemModel(buttonText: '6'),
    ItemModel(buttonText: '5'),
    ItemModel(buttonText: '4'),
    ItemModel(
        buttonText: '+',
        buttonColor1: arithmeticSymbolsColor1,
        buttonColor2: arithmeticSymbolsColor2,
        buttonTextColor: Colors.white),
    ItemModel(buttonText: '3'),
    ItemModel(buttonText: '2'),
    ItemModel(buttonText: '1'),
    ItemModel(
        buttonText: '-',
        buttonColor1: arithmeticSymbolsColor1,
        buttonColor2: arithmeticSymbolsColor2,
        buttonTextColor: Colors.white),
    ItemModel(buttonText: '.'),
    ItemModel(buttonText: '0'),
    ItemModel(buttonText: 'Ans'),
    ItemModel(
        buttonText: '=',
        buttonColor1: arithmeticSymbolsColor1,
        buttonColor2: arithmeticSymbolsColor2,
        buttonTextColor: Colors.white),
  ];
  String input = '';
  String output = '';

  double changeInputFontSize() {
    if (input.length == 8 || input.length > 8) {
      return 30.0;
    } else {
      return 50.0;
    }
  }

  double changeOutputFontSize() {
    if (output.length == 10 || output.length > 10) {
      return 30.0;
    } else {
      return 60.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: const Text(
        //     "Calculator",
        //     style: TextStyle(
        //         fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),
        //   ),
        //   centerTitle: true,
        // ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    input,
                    style: TextStyle(
                        fontSize: changeInputFontSize(),
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(right: 10),
                  alignment: Alignment.bottomRight,
                  child: Text(
                    output,
                    style: TextStyle(
                        fontSize: changeOutputFontSize(),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              // Divider(
              //   height: 5,
              //   color: Colors.grey.shade300,
              //   thickness: 1,
              //
              // ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                flex: 6,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10.0,
                      crossAxisSpacing: 7.0),
                  itemBuilder: (context, index) {
                    return calculatorItem(itemModelData[index], onTap: () {
                      setState(() {
                        if (itemModelData[index].buttonText == 'C') {
                          input = '';
                          output = '';
                        } else if (itemModelData[index].buttonText == 'Del') {
                          if (input != '') {
                            input = input.substring(0, input.length - 1);
                          } else {
                            return;
                          }
                        } else if (itemModelData[index].buttonText == '%' ||
                            itemModelData[index].buttonText == '/' ||
                            itemModelData[index].buttonText == '*' ||
                            itemModelData[index].buttonText == '+' ||
                            itemModelData[index].buttonText == '-' ||
                            itemModelData[index].buttonText == '.') {
                          if (input.endsWith('%') ||
                              input.endsWith('/') ||
                              input.endsWith('*') ||
                              input.endsWith('+') ||
                              input.endsWith('-') ||
                              input.endsWith('.') ||
                              input == '') {
                            return;
                          } else {
                            input += itemModelData[index].buttonText;
                          }
                        } else if (itemModelData[index].buttonText == 'Ans') {
                          input = output;
                          output = '';
                        } else if (itemModelData[index].buttonText == '=') {
                          if (input.endsWith('%') ||
                              input.endsWith('/') ||
                              input.endsWith('*') ||
                              input.endsWith('+') ||
                              input.endsWith('-') ||
                              input.endsWith('.') ||
                              input == '') {
                            return;
                          } else {
                            Parser p = Parser();
                            Expression exp = p.parse(input);

                            ContextModel cm = ContextModel();
                            double eval = exp.evaluate(EvaluationType.REAL, cm);
                            output = eval.toStringAsFixed(2);
                          }
                        } else {
                          input += itemModelData[index].buttonText;
                        }
                      });
                    });
                  },
                  itemCount: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
