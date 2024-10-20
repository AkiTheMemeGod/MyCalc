// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyButton extends StatelessWidget {
  final color;
  final textcolor;
  final dynamic buttontext;
  final buttontapped;
  MyButton(
      {super.key,
      required this.color,
      required this.textcolor,
      required this.buttontext,
      required this.buttontapped});

  bool isIcon() {
    if (buttontext is Icon) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.heavyImpact();
        buttontapped();
      },
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: isIcon()
                  ? buttontext
                  : Text(
                      buttontext,
                      style: TextStyle(
                          color: textcolor,
                          fontSize: 20,
                          fontFamily: "Monospace"),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
