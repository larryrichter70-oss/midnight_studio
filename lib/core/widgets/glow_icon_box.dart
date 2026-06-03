import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GlowIconBox extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;

  const GlowIconBox({
    super.key,
    required this.icon,
    this.color = AppColors.gold,
    this.size = 46,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: color.withOpacity(0.13),
        border: Border.all(
          color: color.withOpacity(0.45),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 24,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: color,
        size: size * 0.52,
      ),
    );
  }
}