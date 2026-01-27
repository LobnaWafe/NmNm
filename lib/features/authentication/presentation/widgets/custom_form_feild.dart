
import 'package:flutter/material.dart';
import 'package:simple_face/constants.dart';
class CustomTextFeild extends StatefulWidget {
  const CustomTextFeild({
    super.key,
    required this.hint,
    this.obscureText = false,
    required this.icon,
    required this.textController,
  });

  final String hint;
  final bool obscureText;
  final IconData icon;
  final TextEditingController textController;

  @override
  State<CustomTextFeild> createState() => _CustomTextFeildState();
}
class _CustomTextFeildState extends State<CustomTextFeild> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      obscureText: _isObscure,
      cursorColor: kPrimaryColorA,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${widget.hint} is required";
        }

        if (widget.hint == "Email") {
          final emailRegex =
              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(value)) {
            return "Enter a valid email";
          }
        }

        if (widget.hint == "Password") {
          if (value.length < 6) {
            return "Password must be at least 6 characters";
          }
        }

        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.hint,
        hintStyle: TextStyle(color: Colors.black.withAlpha(70)),
        prefixIcon: Icon(
          widget.icon,
          color: Colors.black.withAlpha(70),
        ),

        // 👁️ suffix icon
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(color: Colors.black.withAlpha(80),
                  _isObscure
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,

        border: _buildBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 0),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide.none,
    );
  }
}
