
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_face/constants.dart';

class VerifyTextField extends StatelessWidget {
  const VerifyTextField({
    super.key,
    required this.controllers,
    required this.focusNodes, required this.index,
  });

  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final int index;
  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: kPrimaryColorA,
      controller: controllers[index],
      focusNode: focusNodes[index],
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      maxLength: 1,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        counterText: "",
        filled: true,
        fillColor: const Color.fromARGB(
          255,
          199,
          202,
          202,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (value) {
        if (value.isNotEmpty) {
          if (index < 3) {
            FocusScope.of(
              context,
            ).requestFocus(focusNodes[index + 1]);
          } else {
            FocusScope.of(context).unfocus();
          }
        } else {
          if (index > 0) {
            FocusScope.of(
              context,
            ).requestFocus(focusNodes[index - 1]);
          }
        }
      },
    );
  }
}
