import 'package:best_friend/core/theme_utils.dart';
import 'package:flutter/material.dart';

class ModalSepereator extends StatelessWidget {
  const ModalSepereator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 8, 32, 8),
      child: Container(
        height: 2,
        width: double.maxFinite,
        color: ThemeUtils.modalSeperator,
      ),
    );
  }
}