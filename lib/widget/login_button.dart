// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blibli/util/color.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  final String title;
  final bool enable;
  final VoidCallback? onPressed;
  const LoginButton({
    super.key,
    required this.title,
    this.enable = true,
    this.onPressed,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        onPressed: widget.enable ? widget.onPressed : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        height: 45,
        disabledColor: primary[50],
        color: primary,
        child: Text(
          widget.title,
          style:const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
