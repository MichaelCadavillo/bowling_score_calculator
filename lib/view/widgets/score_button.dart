import 'package:flutter/material.dart';

class ScoreButton extends StatelessWidget {
  const ScoreButton({Key? key, required this.onTap, required this.label})
      : super(key: key);

  final Function() onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(label),
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(24),
      ),
    );
  }
}
