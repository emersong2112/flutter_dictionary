import 'package:flutter/material.dart';

class DefaultBox extends StatelessWidget {
  final Widget child;
  const DefaultBox(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: const Color(0xFFF5F5F5),
      ),
      child: child,
    );
  }
}
