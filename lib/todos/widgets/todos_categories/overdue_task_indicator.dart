import 'package:flutter/material.dart';

class OverdueTaskIndicator extends StatelessWidget {
  const OverdueTaskIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 4,
      right: -4,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.error,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Icon(
          Icons.circle,
          color: Theme.of(context).colorScheme.error,
          size: 4,
        ),
      ),
    );
  }
}
