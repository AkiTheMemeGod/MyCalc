import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/components/mybutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userQuestion = '0';
  var userAnswer = '0';

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'X',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '0',
    '.',
    'ANS',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Calculator",
            style: GoogleFonts.breeSerif(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    userQuestion,
                    style: TextStyle(fontSize: 40, color: Colors.white),
                    maxLines: 1,
                  )),
              Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onLongPress: () {
                      Clipboard.setData(ClipboardData(text: userAnswer));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Copied to Clipboard!'),
                        ),
                      );
                    },
                    child: SelectableText(
                      userAnswer,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ))
            ],
          )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8, left: 8),
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (BuildContext context, index) {
                      if (index == 0) {
                        return MyButton(
                            buttontapped: () {
                              setState(() {
                                userQuestion = '0';
                                userAnswer = '0';
                              });
                            },
                            color: Colors.green[400],
                            textcolor: Colors.white,
                            buttontext: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ));
                      } else if (index == 1) {
                        return MyButton(
                            buttontapped: () {
                              setState(() {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                              });
                            },
                            color: Colors.red[400],
                            textcolor: Colors.white,
                            buttontext: Icon(
                              Icons.backspace,
                              color: Colors.white,
                            ));
                      } else if (index == buttons.length - 1) {
                        return MyButton(
                            buttontapped: () {
                              setState(() {
                                equaltapped();
                              });
                            },
                            color: Colors.green[400],
                            textcolor: Colors.white,
                            buttontext: buttons[index]);
                      } else if (index == buttons.length - 2) {
                        return MyButton(
                            buttontapped: () {
                              setState(() {
                                userQuestion = userAnswer;
                              });
                            },
                            color: Colors.orange,
                            textcolor: Colors.white,
                            buttontext: buttons[index]);
                      } else {
                        return MyButton(
                            buttontapped: () {
                              setState(() {
                                if (userQuestion == '0') {
                                  userQuestion = '';
                                }

                                userQuestion += buttons[index];
                              });
                            },
                            color: isOperator(buttons[index])
                                ? Colors.orange
                                : Colors.grey,
                            textcolor: isOperator(buttons[index])
                                ? Colors.white
                                : Colors.white,
                            buttontext: buttons[index]);
                      }
                    }),
              )),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'X' || x == '-' || x == '+' || x == '=') {
      return true;
    } else {
      return false;
    }
  }

  void equaltapped() {
    String finalquestion = userQuestion;
    finalquestion = finalquestion.replaceAll('X', '*');
    Parser p = Parser();
    Expression exp = p.parse(finalquestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
