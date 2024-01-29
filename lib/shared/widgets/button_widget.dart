import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  const ButtonWidget({
    Key? key,
    required this.child,
    this.onPressed,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: child),
    );
  }
}
