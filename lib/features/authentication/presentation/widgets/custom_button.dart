
import 'package:flutter/material.dart';
import 'package:simple_face/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, this.onPressed,  required this.child});
  final void Function()? onPressed;
  //final String text;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: kPrimaryColorA),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
