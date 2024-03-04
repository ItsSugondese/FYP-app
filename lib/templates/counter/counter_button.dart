library item_count_number_button;

import 'package:flutter/material.dart';
import 'package:fyp/constants/designing/colors.dart';

typedef CounterChangeCallback = void Function(num value);

// ignore: must_be_immutable
class ItemCount extends StatelessWidget {
  final CounterChangeCallback onChanged;

  ItemCount({
    Key? key,
    required num initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    required this.decimalPlaces,
    this.color,
    this.textStyle,
    this.step = 1,
    this.buttonTextColor = Colors.white,
    this.buttonSizeWidth = 30,
    this.buttonSizeHeight = 25,
  })  : assert(maxValue > minValue),
        assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedValue = initialValue,
        super(key: key);

  ///min value user can pick
  final num minValue;

  ///max value user can pick
  final num maxValue;

  /// decimal places required by the counter
  final int decimalPlaces;

  ///Currently selected integer value
  num selectedValue;

  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final num step;

  /// indicates the color of fab used for increment and decrement
  Color? color;

  Color? buttonTextColor;

  /// text syle
  TextStyle? textStyle;

  final double buttonSizeWidth, buttonSizeHeight;

  void _incrementCounter() {
    if (selectedValue + step <= maxValue) {
      onChanged((selectedValue + step));
    }
  }

  void _decrementCounter() {
    if (selectedValue - step >= minValue) {
      onChanged((selectedValue - step));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: _decrementCounter,
          child: SizedBox(
            width: buttonSizeWidth,
            height: buttonSizeHeight,
            child: Container(
              child: Center(
                child: Text(
                  '-',
                  style: TextStyle(
                      color: buttonTextColor ?? Colors.black, fontSize: 25),
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
              '${num.parse((selectedValue).toStringAsFixed(decimalPlaces))}',
              style: textStyle != null
                  ? textStyle
                  : const TextStyle(
                      fontSize: 20.0,
                    )),
        ),
        GestureDetector(
          onTap: _incrementCounter,
          child: SizedBox(
            width: buttonSizeWidth,
            height: buttonSizeHeight,
            child: Container(
              child: Center(
                child: Text(
                  '+',
                  style: TextStyle(color: buttonTextColor, fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
