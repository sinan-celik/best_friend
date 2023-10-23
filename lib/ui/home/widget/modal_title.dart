import 'package:best_friend/core/theme_utils.dart';
import 'package:flutter/material.dart';

class ModalTitle extends StatelessWidget {
  const ModalTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: ThemeUtils.modalTitleColor),
    );
  }
}