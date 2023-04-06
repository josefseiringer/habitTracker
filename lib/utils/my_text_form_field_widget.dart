import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants.dart';

class MyTextFormWidget extends StatelessWidget {
  final TextInputType textInputType;
  final String? szHintText;
  final RxString rxInputString;
  const MyTextFormWidget({
    Key? key,
    required this.textInputType,
    required this.szHintText,
    required this.rxInputString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width - 70,
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: TextFormField(
        style: Theme.of(context).textTheme.labelMedium,
        keyboardType: textInputType,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: szHintText,
          border: InputBorder.none,
          hintStyle: kHintTextFild,
        ),
        onChanged: (String? value) {
          if (value != null) {
            rxInputString.value = value;
          }
        },
      ),
    );
  }
}
