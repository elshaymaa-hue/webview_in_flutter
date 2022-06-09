import 'package:flutter/material.dart';

class CenterRow extends StatelessWidget {
  const CenterRow({

    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Center(
            child: child,
          ),
        ),
      ],
    );
  }
}
